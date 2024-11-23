const express = require("express");
const router = express.Router();
const User = require("../models/user_model");
const middleware = require("../middleware/auth_middle");

//save favourite images
router.post("/add", middleware, async (request, response) => {
  const { id, discription, url, cretor } = request.body;

  try {
    //verify user
    const user = await User.findById(request.user.id);
    const alreadyfavourite = user.favouriteImgs.some((img) => img.id === id);

    if (alreadyfavourite) {
      return res.status(400).json({ msg: "Wallpaper already in favorites" });
    }
    //save photo
    user.favouriteImgs.push({ id, discription, url, cretor });
    await user.save();
    response.json(user.favouriteImgs);
  } catch (err) {}
  res.status(500).json({ msg: "Server error" });
});

//remove from favourites
router.post("/remove", middleware, async (request, response) => {
  const { id } = request.body;

  try {
    //get user and filter selected photo
    const user = await User.findById(request.user.id);
    user.favouriteImgs = user.favouriteImgs.filter((img) => img.id !== id);
    await user.save();
    response.json(user.favouriteImgs);
  } catch (err) {
    res.status(500).json({ msg: "Server error" });
  }
});
//get from favourites
router.get("/getfav", middleware, async (request, response) => {
  try {
    //get ideal user
    const user = await User.findById(request.user.id);
    response.json(user.favouriteImgs);
  } catch (err) {
    res.status(500).json({ msg: "Server error" });
  }
});
module.exports = router;
