const mongoose = require("mongoose");

const staffSchema = new mongoose.Schema({
  staffId: { type: String, required: true, unique: true }, // 🔹 Unique Staff ID
  name: { type: String, required: true },
  aadhar: { type: String, required: true },
  phoneNumber: { type: String, required: true },
  password: { type: String , required: true },
  centerName: { type: String, required: true },
  location: { type: String, required: true },
  role: { type: String, default: "staff" } // optional: to identify user type
});

module.exports = mongoose.model("Staff", staffSchema, "staff");