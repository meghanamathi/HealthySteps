// backend/models/Attendance.js
import mongoose from "mongoose";

const attendanceSchema = new mongoose.Schema(
  {
    user: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    date: {
      type: Date,
      default: Date.now,
    },
    isPresent: {
      type: Boolean,
      required: true,
    },
    markedBy: {
      type: String, // parent, staff, or auto
      default: "parent",
    },
  },
  { collection: "attendance" }
);

export default mongoose.model("Attendance", attendanceSchema);
