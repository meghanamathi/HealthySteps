import express from "express";
import Parent from "../models/parent.js";

const router = express.Router();

// 👨‍👩‍👧 Register Parent
router.post("/register", async (req, res) => {
  try {
    const { fatherName, motherName, fatherAadhar, motherAadhar, phoneNumber, password, childName, childGender, childDOB, birthCertificateNo } = req.body;

    if (!fatherName || !motherName || !fatherAadhar || !motherAadhar || !phoneNumber || !password || !childName || !childGender || !childDOB || !birthCertificateNo) {
      return res.status(400).json({ message: "Please fill all fields" });
    }

    const existing = await Parent.findOne({ birthCertificateNo });
    if (existing) {
      return res.status(400).json({ message: "Birth Certificate already registered" });
    }

    const newParent = new Parent({
      fatherName,
      motherName,
      fatherAadhar,
      motherAadhar,
      phoneNumber,
      password,
      childName,
      childGender,
      childDOB,
      birthCertificateNo,
    });

    await newParent.save();
    res.status(201).json({
      message: "Parent Registered Successfully",
      name: fatherName,
      uniqueId: birthCertificateNo,
      phone: phoneNumber,
    });
  } catch (error) {
    console.error("Parent Register Error:", error.message);
    res.status(500).json({ message: "Server Error" });
  }
});

// 🔑 Login Parent
router.post("/login", async (req, res) => {
  try {
    const { birthCertificateNo, password } = req.body;

    if (!birthCertificateNo || !password) {
      return res.status(400).json({ message: "Please fill all fields" });
    }

    const parent = await Parent.findOne({ birthCertificateNo });
    if (!parent) return res.status(404).json({ message: "Parent not found" });
    if (parent.password !== password) return res.status(401).json({ message: "Invalid password" });

    res.status(200).json({
      name: parent.fatherName,
      uniqueId: parent.birthCertificateNo,
      phone: parent.phoneNumber,
    });
  } catch (error) {
    console.error("Parent Login Error:", error.message);
    res.status(500).json({ message: "Server Error" });
  }
});

export default router;
