import express from "express";
const router = express.Router();

// POST Feedback
router.post("/", async (req, res) => {
  try {
    const { rating, feedback } = req.body;
    if (!rating || !feedback) {
      return res.status(400).json({ message: "Please fill all fields" });
    }

    // Example save logic (if using MongoDB)
    // await new Feedback({ rating, feedback }).save();

    res.status(201).json({ message: "Feedback submitted successfully" });
  } catch (error) {
    console.error("Feedback Error:", error.message);
    res.status(500).json({ message: "Server Error" });
  }
});

export default router;
