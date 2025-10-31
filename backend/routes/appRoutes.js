import express from "express";
const router = express.Router();

router.post("/attendance", (req, res) => res.json({ success: true }));
router.post("/goods", (req, res) => res.json({ success: true }));
router.post("/feedback", (req, res) => res.json({ success: true }));

export default router;
