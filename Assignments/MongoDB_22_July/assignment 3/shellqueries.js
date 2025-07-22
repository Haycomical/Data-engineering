// 1
db.products.find({ category: "Electronics" });

// 2 
db.sales.find({ customer: "Ravi" });

// 3
db.products.find({ price: { $gt: 5000 } });

// 4
db.products.find({ stock: { $lt: 50 } });

// 5 
db.sales.find({ date: new Date("2024-08-14") });

// Aggregation & Join Style Operations
// 6 
db.sales.aggregate([
  {
    $group: {
      _id: "$product_id",
      total_quantity_sold: { $sum: "$quantity" }
    }
  }
]);

// 7 
db.sales.aggregate([
  {
    $lookup: {
      from: "products",
      localField: "product_id",
      foreignField: "product_id",
      as: "product_info"
    }
  },
  { $unwind: "$product_info" },
  {
    $project: {
      product_id: 1,
      product_name: "$product_info.name",
      revenue: { $multiply: ["$quantity", "$product_info.price"] }
    }
  },
  {
    $group: {
      _id: "$product_id",
      product_name: { $first: "$product_name" },
      total_revenue: { $sum: "$revenue" }
    }
  }
]);

// 8 
db.sales.find({ quantity: { $gt: 3 } }, { customer: 1, quantity: 1 });

// 9 
db.products.find().sort({ stock: -1 });

// 10
db.sales.aggregate([
  {
    $group: {
      _id: "$product_id",
      total_sold: { $sum: "$quantity" }
    }
  },
  { $sort: { total_sold: -1 } },
  { $limit: 2 },
  {
    $lookup: {
      from: "products",
      localField: "_id",
      foreignField: "product_id",
      as: "product_info"
    }
  },
  {
    $project: {
      _id: 0,
      product_id: "$_id",
      product_name: { $arrayElemAt: ["$product_info.name", 0] },
      total_sold: 1
    }
  }
]);
