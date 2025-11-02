import mongoose from "mongoose";

const pregnantSchema = new mongoose.Schema({
  name: { type: String, required: true },
  aadhar: { type: String, required: true },
  phone: { type: String, required: true },
  password: { type: String, required: true },
  healthId: { type: String, required: true },
  address: { type: String, required: true },
  expectedDeliveryDate: { type: String, required: true },
});


export default mongoose.model("Pregnant", pregnantSchema);
