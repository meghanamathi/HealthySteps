import mongoose from "mongoose";

const goodsSchema = new mongoose.Schema({
  userId: { type: mongoose.Schema.Types.ObjectId, ref: "User", required: true },
  date: { type: Date, default: Date.now },
  items: [
    {
      name: String,
      quantity: Number,
      quality: { type: String, enum: ["Good", "Average", "Poor"], default: "Good" },
    },
  ],
});

export default mongoose.model("Goods", goodsSchema);
