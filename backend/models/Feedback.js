import mongoose from "mongoose";

const feedbackSchema = new mongoose.Schema({
  userId: { type: mongoose.Schema.Types.ObjectId, ref: "User", required: true },
  date: { type: Date, default: Date.now },
  rating: { type: Number, min: 1, max: 5, required: true },
  message: String,
});

export default mongoose.model("Feedback", feedbackSchema);
