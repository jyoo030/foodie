"use strict";

var util = require("util");

require("dotenv").config();

const express = require("express");
const bodyParser = require("body-parser");
const port = 3000;
const mongoose = require("mongoose");

mongoose
    .connect(
        process.env.DB_CONNECTION_STRING,
        { useNewUrlParser: true, useUnifiedTopology: true },
        () => console.log("connected to DB!")
    )
    .catch(err => console.log(err));

var app = express();
app.use(bodyParser.json());

// Routes
app.use('/restaurant', require('./routes/restaurant'));
app.use("/user", require("./routes/user"));


app.listen(port, () => console.log(`foodieAPI listening on port ${port}!`));
