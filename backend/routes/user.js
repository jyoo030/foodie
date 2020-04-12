const express = require('express');
const bcrypt = require('bcrypt');
const router = express.Router();

// User Model
const User = require("../models/user");

router.post('/register', (req, res) => {
	let errors = []
	const {name, email, password, password2} = req.body || {}

	if (!name || !email || !password || !password2) {
		return res.status(400).json({errors: ["Please enter all fields"]});
	}

	if (email.indexOf("@") == -1 || email.slice(-4) != ".com") {
		errors.push("Incorrect email address")
	}

	if (password !== password2) {
		errors.push("Passwords do not match");
	}

	if (password.length < 6) {
		errors.push("Password should be at least 6 characters");
	}

	if (errors.length > 0) {
		return res.status(400).json({errors: errors});
	}

	// Check for exisiting user
	User.findOne({ email }).then(user => {
		if (user) return res.status(400).json( {msg: "User already exists."} );

		const newUser = User({
			name,
			email,
			password,
			friends: [],
			groups: []
		})

		bcrypt.genSalt(10, (err, salt) => {
		    bcrypt.hash(newUser.password, salt, (err, hash) => {
			if (err) throw err;
			newUser.password = hash;
			    newUser.save().then(user => {
				    return res.status(201).json({msg: 'Registered', userId: user.id});
			    })
				    .catch(err => console.log(err));
		    });
		});
	})
})

router.post('/login', (req, res) => {
	var {email, password} = req.body || {}

	if(!email || !password) {
		return res.status(400).json({errors: ["Missing fields"]})
	}

	email = email.toLowerCase()

	User.findOne({email: email}).then(user => {
		if(!user) return res.status(400).json({errors: ["Incorrect credentials"]})

		bcrypt.compare(req.body.password, user.password, (err, isMatch) => {
			if(err) throw err;

			if(isMatch) return res.status(200).json({userId: user.id})

			return res.status(400).json({errors: ["Incorrect credentials"]})
		})
	});
})

router.get('/id/:id', (req, res) => {
	const id = req.params.id
	User.findById(id).select('-password').then(user => {
		if(!user) return res.status(400).json({msg: "No user by the id: " + id});

		res.status(200).json(user);
	})
})

module.exports = router;
