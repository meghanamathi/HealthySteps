import express from "express";
import Pregnant from "../models/pregnant.js";

const router = express.Router();

// 🩺 Register Pregnant Woman
router.post("/register", async (req, res) => {
  try {
    const { name, aadhar, phone, password, healthId, address, expectedDeliveryDate } = req.body;

    if (!name || !aadhar || !phone || !password || !healthId || !address || !expectedDeliveryDate) {
      return res.status(400).json({ message: "Please fill all fields" });
    }

    const existing = await Pregnant.findOne({ healthId });
    if (existing) {
      return res.status(400).json({ message: "Health ID already registered" });
    }

    const newPregnant = new Pregnant({
      name,
      aadhar,
      phone,
      password,
      healthId,
      address,
      expectedDeliveryDate,
    });

    await newPregnant.save();
    res.status(201).json({
      message: "Pregnant Woman registered successfully",
      name,
      uniqueId: healthId,
      phone,
    });
  } catch (error) {
    console.error("Pregnant Register Error:", error.message);
    res.status(500).json({ message: "Server Error" });
  }
});

// 🔑 Login Pregnant Woman
router.post("/login", async (req, res) => {
  try {
    const { healthId, password } = req.body;
    if (!healthId || !password) {
      return res.status(400).json({ message: "Please fill all fields" });
    }

    const pregnant = await Pregnant.findOne({ healthId });
    if (!pregnant) {
      return res.status(404).json({ message: "Health ID not found" });
    }

    if (pregnant.password !== password) {
      return res.status(401).json({ message: "Invalid password" });
    }

    res.status(200).json({
      name: pregnant.name,
      uniqueId: pregnant.healthId,
      phone: pregnant.phone,
    });
  } catch (error) {
    console.error("Pregnant Login Error:", error.message);
    res.status(500).json({ message: "Server Error" });
  }
});

export default router;
