const mongoose = require("mongoose");

const parentSchema = new mongoose.Schema({
  fatherName: String,
  motherName: String,
  fatherAadhar: String,
  motherAadhar: String,
  phoneNumber: String,
  password: String,
  childName: String,
  childGender: String,
  childDOB: String,
  birthCertificateNo: String
});

module.exports = mongoose.model("Parent", parentSchema, "parents");