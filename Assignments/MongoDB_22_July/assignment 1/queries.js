// 1
db.books.find({ price: { $gt: 500 } })

// 2 
db.customers.find({ city: "Hyderabad" })

// 3
db.orders.find({ order_date: { $gt: ISODate("2023-01-01") } })

// 4
db.orders.aggregate([
  {
    $lookup: {
      from: "customers",
      localField: "customer_id",
      foreignField: "customer_id",
      as: "customer_info"
    }
  },
  { $unwind: "$customer_info" },
  {
    $lookup: {
      from: "books",
      localField: "book_id",
      foreignField: "book_id",
      as: "book_info"
    }
  },
  { $unwind: "$book_info" },
  {
    $project: {
      order_id: 1,
      order_date: 1,
      quantity: 1,
      customer_name: "$customer_info.name",
      book_title: "$book_info.title"
    }
  }
])

// 5 
db.orders.aggregate([
  {
    $group: {
      _id: "$book_id",
      total_quantity: { $sum: "$quantity" }
    }
  },
  {
    $lookup: {
      from: "books",
      localField: "_id",
      foreignField: "book_id",
      as: "book_info"
    }
  },
  { $unwind: "$book_info" },
  {
    $project: {
      _id: 0,
      book_title: "$book_info.title",
      total_quantity: 1
    }
  }
])

// 6 
db.orders.aggregate([
  {
    $group: {
      _id: "$customer_id",
      order_count: { $sum: 1 }
    }
  },
  {
    $lookup: {
      from: "customers",
      localField: "_id",
      foreignField: "customer_id",
      as: "customer_info"
    }
  },
  { $unwind: "$customer_info" },
  {
    $project: {
      customer_name: "$customer_info.name",
      order_count: 1
    }
  }
])

// 7 
db.orders.aggregate([
  {
    $lookup: {
      from: "books",
      localField: "book_id",
      foreignField: "book_id",
      as: "book_info"
    }
  },
  { $unwind: "$book_info" },
  {
    $group: {
      _id: "$book_id",
      title: { $first: "$book_info.title" },
      total_revenue: { $sum: { $multiply: ["$quantity", "$book_info.price"] } }
    }
  }
])

// 8 
db.orders.aggregate([
  {
    $lookup: {
      from: "books",
      localField: "book_id",
      foreignField: "book_id",
      as: "book_info"
    }
  },
  { $unwind: "$book_info" },
  {
    $group: {
      _id: "$book_id",
      title: { $first: "$book_info.title" },
      total_revenue: { $sum: { $multiply: ["$quantity", "$book_info.price"] } }
    }
  },
  { $sort: { total_revenue: -1 } },
  { $limit: 1 }
])

// 9 
db.orders.aggregate([
  {
    $lookup: {
      from: "books",
      localField: "book_id",
      foreignField: "book_id",
      as: "book_info"
    }
  },
  { $unwind: "$book_info" },
  {
    $group: {
      _id: "$book_info.genre",
      total_sold: { $sum: "$quantity" }
    }
  },
  {
    $project: {
      genre: "$_id",
      total_sold: 1,
      _id: 0
    }
  }
])

// 10
db.orders.aggregate([
  {
    $group: {
      _id: { customer_id: "$customer_id", book_id: "$book_id" }
    }
  },
  {
    $group: {
      _id: "$_id.customer_id",
      unique_books: { $sum: 1 }
    }
  },
  { $match: { unique_books: { $gt: 2 } } },
  {
    $lookup: {
      from: "customers",
      localField: "_id",
      foreignField: "customer_id",
      as: "customer_info"
    }
  },
  { $unwind: "$customer_info" },
  {
    $project: {
      customer_name: "$customer_info.name",
      unique_books: 1
    }
  }
])
