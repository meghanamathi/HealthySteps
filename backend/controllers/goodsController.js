import Goods from "../models/Goods.js";
import User from "../models/User.js";

export const confirmGoods = async (req, res) => {
  try {
    const { uniqueId, items } = req.body;
    const user = await User.findOne({ uniqueId });
    if (!user) return res.status(404).json({ message: "User not found" });

    const goods = await Goods.create({ userId: user._id, items });
    res.status(201).json({ message: "Goods confirmed", goods });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

export const getGoodsHistory = async (req, res) => {
  try {
    const { uniqueId } = req.params;
    const user = await User.findOne({ uniqueId });
    if (!user) return res.status(404).json({ message: "User not found" });

    const history = await Goods.find({ userId: user._id }).sort({ date: -1 });
    res.status(200).json(history);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};
