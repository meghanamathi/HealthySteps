import express from "express";
const router = express.Router();

router.post("/", async (req, res) => {
  const { present } = req.body;

  if (typeof present !== "boolean") {
    return res.status(400).json({ message: "Invalid attendance value" });
  }

  console.log("Attendance received:", present);

  // Simulate saving attendance to DB
  res.status(200).json({ message: "Attendance marked successfully" });
});

export default router;
