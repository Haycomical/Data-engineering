// 1
db.movies.find({ duration: { $gt: 100 } });

// 2
db.users.find({ country: "India" });

// 3
db.movies.find({ release_year: { $gt: 2020 } });

// 4 
db.watch_history.aggregate([
  {
    $lookup: {
      from: "users",
      localField: "user_id",
      foreignField: "user_id",
      as: "user_info"
    }
  },
  {
    $lookup: {
      from: "movies",
      localField: "movie_id",
      foreignField: "movie_id",
      as: "movie_info"
    }
  },
  { $unwind: "$user_info" },
  { $unwind: "$movie_info" },
  {
    $project: {
      _id: 0,
      user: "$user_info.name",
      movie: "$movie_info.title",
      watch_time: 1
    }
  }
]);

// 5 
db.watch_history.aggregate([
  {
    $lookup: {
      from: "movies",
      localField: "movie_id",
      foreignField: "movie_id",
      as: "movie_info"
    }
  },
  { $unwind: "$movie_info" },
  {
    $group: {
      _id: "$movie_info.genre",
      watch_count: { $sum: 1 }
    }
  }
]);

// 6 
db.watch_history.aggregate([
  {
    $group: {
      _id: "$user_id",
      total_watch_time: { $sum: "$watch_time" }
    }
  },
  {
    $lookup: {
      from: "users",
      localField: "_id",
      foreignField: "user_id",
      as: "user_info"
    }
  },
  { $unwind: "$user_info" },
  {
    $project: {
      _id: 0,
      user: "$user_info.name",
      total_watch_time: 1
    }
  }
]);

// 7 
db.watch_history.aggregate([
  {
    $group: {
      _id: "$movie_id",
      count: { $sum: 1 }
    }
  },
  { $sort: { count: -1 } },
  { $limit: 1 },
  {
    $lookup: {
      from: "movies",
      localField: "_id",
      foreignField: "movie_id",
      as: "movie_info"
    }
  },
  { $unwind: "$movie_info" },
  {
    $project: {
      movie: "$movie_info.title",
      watch_count: "$count"
    }
  }
]);

// 8
db.watch_history.aggregate([
  {
    $group: {
      _id: "$user_id",
      movie_ids: { $addToSet: "$movie_id" }
    }
  },
  {
    $project: {
      movie_count: { $size: "$movie_ids" }
    }
  },
  { $match: { movie_count: { $gt: 2 } } },
  {
    $lookup: {
      from: "users",
      localField: "_id",
      foreignField: "user_id",
      as: "user_info"
    }
  },
  { $unwind: "$user_info" },
  {
    $project: {
      user: "$user_info.name",
      movie_count: 1
    }
  }
]);

// 9
db.watch_history.aggregate([
  {
    $group: {
      _id: { user_id: "$user_id", movie_id: "$movie_id" },
      watch_count: { $sum: 1 }
    }
  },
  { $match: { watch_count: { $gt: 1 } } },
  {
    $lookup: {
      from: "users",
      localField: "_id.user_id",
      foreignField: "user_id",
      as: "user_info"
    }
  },
  {
    $lookup: {
      from: "movies",
      localField: "_id.movie_id",
      foreignField: "movie_id",
      as: "movie_info"
    }
  },
  { $unwind: "$user_info" },
  { $unwind: "$movie_info" },
  {
    $project: {
      user: "$user_info.name",
      movie: "$movie_info.title",
      watch_count: 1
    }
  }
]);

// 10
db.watch_history.aggregate([
  {
    $lookup: {
      from: "movies",
      localField: "movie_id",
      foreignField: "movie_id",
      as: "movie_info"
    }
  },
  { $unwind: "$movie_info" },
  {
    $project: {
      movie: "$movie_info.title",
      user_id: 1,
      percentage_watched: {
        $multiply: [
          { $divide: ["$watch_time", "$movie_info.duration"] },
          100
        ]
      }
    }
  }
]);
