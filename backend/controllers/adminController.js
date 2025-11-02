import Admin from "../models/Admin.js";

// POST /api/admin/register
export const registerAdmin = async (req, res) => {
  try {
    const { name, email, phone, aadhar, district, password } = req.body;

    // Check if admin already exists
    const existingAdmin = await Admin.findOne({ email });
    if (existingAdmin) {
      return res.status(400).json({ message: "Admin already registered" });
    }

    // Create new admin
    const newAdmin = new Admin({
      name,
      email,
      phone,
      aadhar,
      district,
      password,
    });

    await newAdmin.save();
    res.status(201).json({ message: "Admin registered successfully" });
  } catch (error) {
    console.error("Admin Registration Error:", error.message);
    res.status(500).json({ message: "Server Error" });
  }
};
