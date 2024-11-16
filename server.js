const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");

require("dotenv").config();
//routes
const auth = require("./routes/authentication");

const app = express();
//middleware
app.use(cors());
app.use(express.json());

//routes
app.use("/api/auth/", auth);

//connect mongo
mongoose
  .connect(process.env.MONGO_URI)
  .then(() => {
    console.log("Mongo DB connected");
  })
  .catch((err) => {
    console.log(`Mongo DB not connected ${err}`);
  });

  //run server
const PORT = process.env.PORT;
app.listen(PORT, () => {
  console.log(`Server is running PORT ${PORT}`);
});
