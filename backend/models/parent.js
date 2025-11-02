import mongoose from "mongoose";

const parentSchema = new mongoose.Schema({
  fatherName: { type: String, required: true },
  motherName: { type: String, required: true },
  fatherAadhar: { type: String, required: true, unique: true },
  motherAadhar: { type: String, required: true, unique: true },
  phoneNumber: { type: String, required: true },
  password: { type: String, required: true },
  childName: { type: String, required: true },
  childGender: { type: String, required: true },
  childDOB: { type: String, required: true },
  birthCertificateNo: { type: String, required: true, unique: true }
}, {
  timestamps: true
});

const Parent = mongoose.model("Parent", parentSchema, "parents");
export default Parent;
