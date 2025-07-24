use logs;

db.logs.insertMany([
  {
    shipment_id: 1,
    order_id: 201,
    shipped_by: "Professional",
    shipment_status: "In Transit",
    location: "Jharkand Hub",
    last_updated: ISODate("2025-07-22T10:00:00Z")
  },
  {
    shipment_id: 2,
    order_id: 202,
    shipped_by: "ST",
    shipment_status: "Delivered",
    location: "Bangalore",
    last_updated: ISODate("2025-07-21T14:00:00Z")
  }
]);

db.logs.createIndex({ order_id: 1 });
db.logs.createIndex({ shipment_status: 1, last_updated: -1 });
