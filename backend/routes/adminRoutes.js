import express from "express";
import Admin from "../models/Admin.js";

const router = express.Router();

// 🧑‍💼 Register Admin
router.post("/register", async (req, res) => {
  try {
    const { name, email, phone, aadhar, district, uniqueId, password } = req.body;

    if (!name || !email || !phone || !aadhar || !district || !uniqueId || !password) {
      return res.status(400).json({ message: "Please fill all fields" });
    }

    const existing = await Admin.findOne({ uniqueId });
    if (existing) return res.status(400).json({ message: "Admin already exists" });

    const newAdmin = new Admin({ name, email, phone, aadhar, district, uniqueId, password });
    await newAdmin.save();

    res.status(201).json({
      message: "Admin Registered Successfully",
      name,
      uniqueId,
      phone,
    });
  } catch (error) {
    console.error("Admin Register Error:", error.message);
    res.status(500).json({ message: "Server Error" });
  }
});

// 🔑 Login Admin
router.post("/login", async (req, res) => {
  try {
    const { uniqueId, password } = req.body;

    const admin = await Admin.findOne({ uniqueId });
    if (!admin) return res.status(404).json({ message: "Admin not found" });
    if (admin.password !== password) return res.status(401).json({ message: "Invalid password" });

    res.status(200).json({
      name: admin.name,
      uniqueId: admin.uniqueId,
      phone: admin.phone,
    });
  } catch (error) {
    console.error("Admin Login Error:", error.message);
    res.status(500).json({ message: "Server Error" });
  }
});

export default router;
