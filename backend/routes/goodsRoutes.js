import express from "express";
const router = express.Router();

// POST Goods confirmation
router.post("/", async (req, res) => {
  try {
    const goods = req.body;
    if (!goods || Object.keys(goods).length === 0) {
      return res.status(400).json({ message: "No items provided" });
    }

    // Example save logic
    // await new Goods({ items: goods }).save();

    res.status(200).json({ message: "Goods confirmed successfully" });
  } catch (error) {
    console.error("Goods Error:", error.message);
    res.status(500).json({ message: "Server Error" });
  }
});

export default router;
