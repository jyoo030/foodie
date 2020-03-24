var express = require('express');
var router = express.Router();

router.get('/id/:id', function (req, res) {
  res.send(req.params.id)
})

router.get('/radius/:radius', function(req, res){
  res.send(req.params.radius)
});

//export this router to use in our index.js
module.exports = router;
