const express = require('express');
const bcrypt = require('bcrypt');
const router = express.Router();

require('dotenv').config()

// User Model
const User = require("../models/user");


router.post('/register', (req, res) => {
	let errors = []
	const {name, email, password, password2} = req.body || {}

	if (!name || !email || !password || !password2) {
		errors.push({msg: "Please enter all fields"});
	}

	if (email.indexOf("@") == -1 || email.slice(-4) != ".com") {
		errors.push({msg: "Incorrect email address"})
	}

	if (password !== password2) {
		errors.push({msg: "Passwords do not match"});
	}

	if (password.length < 6) {
		errors.push({msg: "Password should be at least 6 characters"});
	}

	if (errors.length > 0) {
		return res.status(400).json(errors);
	}

	// Check for exisiting user
	User.findOne({ email }).then(user => {
		if (user) return res.status(400).json( {msg: "User already exists."} );

		const newUser = User({
			name,
			email,
			password,
			friends: []
		})

		bcrypt.genSalt(10, (err, salt) => {
		    bcrypt.hash(newUser.password, salt, (err, hash) => {
			if (err) throw err;
			newUser.password = hash;
			    newUser.save().then(user => {
				    return res.status(201).json({msg: 'Registered'});
			    })
				    .catch(err => console.log(err));
		    });
		});
	})
})

module.exports = router;
