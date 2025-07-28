// 1
db.members.find({ city: "Mumbai" });

// 2
db.trainers.find({ experience: { $gt: 6 } });

// 3
db.sessions.find({ session_type: "Yoga" });

// 4
db.trainers.aggregate([
  { $match: { name: "Swati Nair" }},
  { $lookup: {
      from: "sessions",
      localField: "trainer_id",
      foreignField: "trainer_id",
      as: "sessions"
  }},
  { $unwind: "$sessions" },
  { $replaceRoot: { newRoot: "$sessions" }}
]);

// 5
db.sessions.aggregate([
  { $match: { date: new Date("2024-08-05") }},
  { $lookup: {
      from: "members",
      localField: "member_id",
      foreignField: "member_id",
      as: "member"
  }},
  { $unwind: "$member" },
  { $project: { _id: 0, name: "$member.name" }}
]);

// Intermediate Queries
// 6
db.sessions.aggregate([
  { $group: { _id: "$member_id", session_count: { $sum: 1 }}}
]);

// 7
db.sessions.aggregate([
  { $group: { _id: "$session_type", avg_duration: { $avg: "$duration" }}}
]);

// 8
db.members.aggregate([
  { $match: { gender: "Female" }},
  { $lookup: {
      from: "sessions",
      localField: "member_id",
      foreignField: "member_id",
      as: "sessions"
  }},
  { $unwind: "$sessions" },
  { $match: { "sessions.duration": { $gt: 60 }}},
  { $project: { name: 1, "sessions.duration": 1 }}
]);

// 9
db.sessions.find().sort({ duration: -1 });

// 10
db.sessions.aggregate([
  { $group: { _id: "$member_id", trainers: { $addToSet: "$trainer_id" }}},
  { $match: { "trainers.1": { $exists: true }}}
]);


// 11
db.sessions.aggregate([
  { $lookup: {
      from: "members",
      localField: "member_id",
      foreignField: "member_id",
      as: "member"
  }},
  { $lookup: {
      from: "trainers",
      localField: "trainer_id",
      foreignField: "trainer_id",
      as: "trainer"
  }},
  { $unwind: "$member" },
  { $unwind: "$trainer" },
  { $project: {
    _id: 0,
    session_id: 1,
    member_name: "$member.name",
    trainer_name: "$trainer.name",
    duration: 1,
    session_type: 1
  }}
]);

// 12
db.sessions.aggregate([
  { $group: { _id: "$trainer_id", total_time: { $sum: "$duration" }}}
]);

// 13
db.sessions.aggregate([
  { $group: { _id: "$member_id", total_time: { $sum: "$duration" }}}
]);

// 14
db.sessions.aggregate([
  { $group: { _id: "$trainer_id", session_count: { $sum: 1 }}}
]);

// 15
db.sessions.aggregate([
  { $group: { _id: "$trainer_id", avg_duration: { $avg: "$duration" }}},
  { $sort: { avg_duration: -1 }},
  { $limit: 1 }
]);

// 16
db.sessions.aggregate([
  { $group: { _id: "$trainer_id", unique_members: { $addToSet: "$member_id" }}},
  { $project: { trainer_id: "$_id", unique_count: { $size: "$unique_members" }}}
]);

// 17
db.sessions.aggregate([
  { $group: { _id: "$member_id", total_time: { $sum: "$duration" }}},
  { $sort: { total_time: -1 }},
  { $limit: 1 }
]);

// 18
db.members.aggregate([
  { $match: { membership_type: "Gold" }},
  { $lookup: {
      from: "sessions",
      localField: "member_id",
      foreignField: "member_id",
      as: "sessions"
  }},
  { $unwind: "$sessions" },
  { $match: { "sessions.session_type": "Strength" }},
  { $project: { name: 1 }}
]);

// 19
db.sessions.aggregate([
  { $lookup: {
      from: "members",
      localField: "member_id",
      foreignField: "member_id",
      as: "member"
  }},
  { $unwind: "$member" },
  { $group: {
    _id: "$member.membership_type",
    session_count: { $sum: 1 }
  }}
]);

// 20
db.members.aggregate([
  { $lookup: {
      from: "sessions",
      localField: "member_id",
      foreignField: "member_id",
      as: "sessions"
  }},
  { $match: { sessions: { $eq: [] }}}
]);
