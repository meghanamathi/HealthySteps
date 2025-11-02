import Parent from "../models/Parent.js";
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";

// 📌 Register a new parent
export const registerParent = async (req, res) => {
  try {
    const { fatherName, motherName, fatherAadhar, motherAadhar, phoneNumber, password, childName, childGender, childDOB, birthCertificateNo } = req.body;

    const existingParent = await Parent.findOne({ birthCertificateNo });
    if (existingParent) return res.status(400).json({ message: "Parent already registered" });

    const hashedPassword = await bcrypt.hash(password, 10);

    const parent = await Parent.create({
      fatherName,
      motherName,
      fatherAadhar,
      motherAadhar,
      phoneNumber,
      password: hashedPassword,
      childName,
      childGender,
      childDOB,
      birthCertificateNo
    });

    res.status(201).json({ message: "Parent registered successfully", parent });
  } catch (err) {
    console.error("❌ Parent Registration Error:", err);
    res.status(500).json({ message: "Server Error", error: err.message });
  }
};

// 📌 Parent Login
export const loginParent = async (req, res) => {
  try {
    const { birthCertificateNo, password } = req.body;
    const parent = await Parent.findOne({ birthCertificateNo });

    if (!parent) return res.status(404).json({ message: "Parent not found" });

    const isMatch = await bcrypt.compare(password, parent.password);
    if (!isMatch) return res.status(401).json({ message: "Invalid credentials" });

    const token = jwt.sign(
      { id: parent._id, role: "parent" },
      process.env.JWT_SECRET,
      { expiresIn: "7d" }
    );

    res.status(200).json({ message: "Login successful", token });
  } catch (err) {
    console.error("❌ Parent Login Error:", err);
    res.status(500).json({ message: "Server Error", error: err.message });
  }
};

// 📌 Get parent profile
export const getParentProfile = async (req, res) => {
  try {
    const parent = await Parent.findById(req.user.id).select("-password");
    if (!parent) return res.status(404).json({ message: "Parent not found" });

    res.json(parent);
  } catch (err) {
    res.status(500).json({ message: "Server Error", error: err.message });
  }
};
