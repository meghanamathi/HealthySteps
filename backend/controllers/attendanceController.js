import Attendance from "../models/Attendance.js";
import User from "../models/User.js";

export const markAttendance = async (req, res) => {
  try {
    const { uniqueId, status } = req.body;

    const user = await User.findOne({ uniqueId });
    if (!user) return res.status(404).json({ message: "User not found" });

    const today = new Date();
    today.setHours(0, 0, 0, 0);

    const existing = await Attendance.findOne({ userId: user._id, date: { $gte: today } });
    if (existing)
      return res.status(400).json({ message: "Attendance already marked for today" });

    const attendance = await Attendance.create({ userId: user._id, status });
    res.status(201).json({ message: "Attendance marked successfully", attendance });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

export const getAttendance = async (req, res) => {
  try {
    const { uniqueId } = req.params;
    const user = await User.findOne({ uniqueId });
    if (!user) return res.status(404).json({ message: "User not found" });

    const records = await Attendance.find({ userId: user._id }).sort({ date: -1 });
    res.status(200).json(records);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};
