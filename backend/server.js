import express from "express";
import cors from "cors";
import dotenv from "dotenv";
import connectDB from "./config/db.js";
import authRoutes from "./routes/authRoutes.js";
import attendanceRoutes from "./routes/attendanceRoutes.js";
import goodsRoutes from "./routes/goodsRoutes.js";
import feedbackRoutes from "./routes/feedbackRoutes.js";
import staffRoutes from "./routes/staffRoutes.js";
import parentRoutes from "./routes/parentRoutes.js";
import pregnantRoutes from "./routes/pregnantRoutes.js";
import adminRoutes from "./routes/adminRoutes.js";

dotenv.config();
connectDB();

const app = express();
app.use(cors());
app.use(express.json());

app.use("/api/auth", authRoutes);
app.use("/api/attendance", attendanceRoutes);
app.use("/api/goods", goodsRoutes);
app.use("/api/feedback", feedbackRoutes);
app.use("/api/staff", staffRoutes);
app.use("/api/parents", parentRoutes);
app.use("/api/pregnant", pregnantRoutes);
app.use("/api/admin", adminRoutes);

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`✅ Server running on port ${PORT}`));
