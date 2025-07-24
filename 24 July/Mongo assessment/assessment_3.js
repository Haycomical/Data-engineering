Design and Query Challenge
use job_portal;

// Jobs collection
db.jobs.insertMany([
  { _id: 1, title: "Backend Developer", company: "Tcs", location: "Bangalore", salary: 1200000, job_type: "remote", posted_on: ISODate("2025-07-01") },
  { _id: 2, title: "Frontend Developer", company: "Ixigo", location: "Hyderabad", salary: 800000, job_type: "on-site", posted_on: ISODate("2025-06-20") },
  { _id: 3, title: "Data Analyst", company: "Hexaware", location: "Pune", salary: 950000, job_type: "hybrid", posted_on: ISODate("2025-07-15") },
  { _id: 4, title: "DevOps Engineer", company: "Zoho", location: "Chennai", salary: 1500000, job_type: "remote", posted_on: ISODate("2025-07-10") },
  { _id: 5, title: "UI/UX Designer", company: "Freshworks", location: "Mumbai", salary: 700000, job_type: "on-site", posted_on: ISODate("2025-05-28") }
]);

// Applicants collection
db.applicants.insertMany([
  { _id: 1, name: "Ayesha", skills: ["JavaScript", "MongoDB", "Node.js"], experience: 3, city: "Hyderabad", applied_on: ISODate("2025-07-18") },
  { _id: 2, name: "Rahul", skills: ["Python", "Django", "SQL"], experience: 5, city: "Bangalore", applied_on: ISODate("2025-07-12") },
  { _id: 3, name: "Sneha", skills: ["MongoDB", "React", "Express"], experience: 2, city: "Chennai", applied_on: ISODate("2025-07-14") },
  { _id: 4, name: "John", skills: ["Java", "Spring Boot", "AWS"], experience: 4, city: "Pune", applied_on: ISODate("2025-06-29") },
  { _id: 5, name: "Divya", skills: ["HTML", "CSS", "Figma"], experience: 1, city: "Mumbai", applied_on: ISODate("2025-07-05") }
]);

// Applications collection
db.applications.insertMany([
  { _id: 1, applicant_id: 1, job_id: 1, application_status: "interview scheduled", interview_scheduled: ISODate("2025-07-25"), feedback: "" },
  { _id: 2, applicant_id: 2, job_id: 2, application_status: "applied", interview_scheduled: null, feedback: "" },
  { _id: 3, applicant_id: 3, job_id: 4, application_status: "interview scheduled", interview_scheduled: ISODate("2025-07-28"), feedback: "" },
  { _id: 4, applicant_id: 4, job_id: 3, application_status: "shortlisted", interview_scheduled: null, feedback: "" },
  { _id: 5, applicant_id: 5, job_id: 5, application_status: "rejected", interview_scheduled: null, feedback: "Needs more design experience" }
]);

// 1 
db.jobs.find({ job_type: "remote", salary: { $gt: 1000000 } });

// 2 
db.applicants.find({ skills: "MongoDB" });

// 3 
db.jobs.countDocuments({
  posted_on: { $gte: new Date(Date.now() - 30 * 24 * 60 * 60 * 1000) }
});

// 4 
db.applications.find({ application_status: "interview scheduled" });

// 5 
db.jobs.aggregate([
  { $group: { _id: "$company", totalJobs: { $sum: 1 } } },
  { $match: { totalJobs: { $gt: 2 } } }
]);

// 6 
db.applications.aggregate([
  {
    $lookup: {
      from: "jobs",
      localField: "job_id",
      foreignField: "job_id",
      as: "job_info"
    }
  },
  {
    $lookup: {
      from: "applicants",
      localField: "applicant_id",
      foreignField: "applicant_id",
      as: "applicant_info"
    }
  },
  {
    $project: {
      _id: 0,
      job_title: { $arrayElemAt: ["$job_info.title", 0] },
      applicant_name: { $arrayElemAt: ["$applicant_info.name", 0] }
    }
  }
]);

// 7 
db.applications.aggregate([
  { $group: { _id: "$job_id", applications: { $sum: 1 } } }
]);

// 8 
db.applications.aggregate([
  { $group: { _id: "$applicant_id", total: { $sum: 1 } } },
  { $match: { total: { $gt: 1 } } }
]);

// 9 
db.applicants.aggregate([
  { $group: { _id: "$city", count: { $sum: 1 } } },
  { $sort: { count: -1 } },
  { $limit: 3 }
]);

// 10
db.jobs.aggregate([
  { $group: { _id: "$job_type", avgSalary: { $avg: "$salary" } } }
]);

// 11 
db.applications.updateMany({}, { $set: { shortlisted: false } });

// 12
const appliedJobs = db.applications.distinct("job_id");
db.jobs.deleteOne({ job_id: { $nin: appliedJobs } });

// 13 
db.applications.updateMany({}, { $set: { shortlisted: false } });

// 14 
db.applicants.updateMany(
  { city: "Hyderabad" },
  { $inc: { experience: 1 } }
);

// 15
const appliedApplicants = db.applications.distinct("applicant_id");
db.applicants.deleteMany({ applicant_id: { $nin: appliedApplicants } });
