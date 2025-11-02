// backend/models/Admin.js
import mongoose from "mongoose";

const adminSchema = new mongoose.Schema(
  {
    name: { type: String, required: true },
    email: { type: String, required: true, unique: true },
    phone: { type: String, required: true },
    aadhar: { type: String, required: true },
    district: { type: String, required: true },
    password: { type: String, required: true },
  },
  { timestamps: true, collection: "admins" } // ✅ only collection name, not DB name
);

export default mongoose.model("Admin", adminSchema);
