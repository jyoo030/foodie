const express = require('express');
const yelp = require('yelp-fusion');
const router = express.Router();

require('dotenv').config()
const client = yelp.client(process.env.YELP_API_KEY);

router.get('/id/:id', function (req, res) {
	client.business(req.params.id).then(response => {
		res.json(response.body);
	}).catch(e => {
		console.log(e);
	});
})

router.get('/radius/:radius', function(req, res) {
	if(!req.query.location)
		res.send("Missing location parameter.")

	const searchRequest = {
		term: 'restaurants',
		location: req.query.location,
		radius: req.params.radius
	};

	client.search(searchRequest).then(response => {
		res.json(response.body).status(200);
	}).catch(e => {
		console.log(e);
	});
});

//export this router to use in our index.js
module.exports = router;
