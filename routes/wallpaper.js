const express = require("express");
const wallpaperRoutes = express.Router();
const axios = require("axios");

require("dotenv").config();
//search data
wallpaperRoutes.get("/search", async (request, response) => {
  const keyword = request.query.query;
  const apiKey = process.env.UNSPLASH_ACCESS_KEY;

  try {
    //get the data from unplash
    const allData = await axios.get(
      `https://api.unsplash.com/search/photos?page=1&query=${keyword}`,
      {
        headers: {
          Authorization: `Client-ID ${apiKey}`,
        },
      }
    );
    //filter and map the required data from all fetched data
    const wallpapers = allData.data.results.map((wallpaper) => ({
      id: photo.id,
      url: photo.urls.regular,
      description: photo.description || photo.alt_description,
      photographer: photo.user.name,
    }));
    //return filterd data
    response.json({ wallpapers });
  } catch (err) {
    response.status(400).json({ msg: "Error fetching wallpapers" });
  }
});

module.exports = wallpaperRoutes;
