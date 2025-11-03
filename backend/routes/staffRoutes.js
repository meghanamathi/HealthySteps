import express from "express";
import Staff from "../models/staff.js";

const router = express.Router();

// 🧑‍💼 Register Staff
router.post("/register", async (req, res) => {
  try {
    const { name, aadhar, phone, center, designation, centerId, password } = req.body;

    if (!name || !aadhar || !phone || !center || !designation || !centerId || !password) {
      return res.status(400).json({ message: "Please fill all fields" });
    }

    const existing = await Staff.findOne({ centerId });
    if (existing) return res.status(400).json({ message: "Center ID already exists" });

    const newStaff = new Staff({ name, aadhar, phone, center, designation, centerId, password });
    await newStaff.save();

    res.status(201).json({
      message: "Staff Registered Successfully",
      name,
      uniqueId: centerId,
      phone,
    });
  } catch (error) {
    console.error("Staff Register Error:", error.message);
    res.status(500).json({ message: "Server Error" });
  }
});

// 🔑 Login Staff
router.post("/login", async (req, res) => {
  try {
    const { centerId, password } = req.body;

    const staff = await Staff.findOne({ centerId });
    if (!staff) return res.status(404).json({ message: "Center ID not found" });
    if (staff.password !== password) return res.status(401).json({ message: "Invalid password" });

    res.status(200).json({
      name: staff.name,
      uniqueId: staff.centerId,
      phone: staff.phone,
    });
  } catch (error) {
    console.error("Staff Login Error:", error.message);
    res.status(500).json({ message: "Server Error" });
  }
});

export default router;
