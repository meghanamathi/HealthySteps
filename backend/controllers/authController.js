// backend/controllers/authController.js
import User from "../models/User.js";

// 🟢 REGISTER
export const register = async (req, res) => {
  try {
    const { name, email, phone, password, role, uniqueId } = req.body;

    // Validate
    if (!name || !password || !role || !uniqueId) {
      return res.status(400).json({ message: "Please fill all required fields" });
    }

    // Check existing user
    const existingUser = await User.findOne({ uniqueId });
    if (existingUser) {
      return res.status(400).json({ message: "User already exists" });
    }

    // Create and save new user
    const user = new User({ name, email, phone, password, role, uniqueId });
    await user.save();

    res.status(201).json({ message: "User registered successfully", user });
  } catch (err) {
    console.error("❌ Registration error:", err.message);
    res.status(500).json({ message: "Server error" });
  }
};

// 🟣 LOGIN
export const login = async (req, res) => {
  try {
    const { uniqueId, password } = req.body;

    if (!uniqueId || !password) {
      return res.status(400).json({ message: "Please enter both fields" });
    }

    const user = await User.findOne({ uniqueId });
    if (!user || user.password !== password) {
      return res.status(401).json({ message: "Invalid credentials" });
    }

    res.status(200).json({ message: "Login successful", user });
  } catch (err) {
    console.error("❌ Login error:", err.message);
    res.status(500).json({ message: "Server error" });
  }
};
