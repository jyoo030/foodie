const express = require('express');
const app = express();
const port = 3000;

var restaurants = require('./routes/restaurant');

app.listen(port, () => console.log(`foodieAPI listening on port ${port}!`));

app.use('/restaurant', restaurants);


