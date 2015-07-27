var express = require('express');
var router = express.Router();

teamName = [
  "TheWaySoFar"
  , "Damocles"
  , "undetermined"
  , "TDL"
  , "LovelyDonuts"
  , "NewBeer"
  , "TheThreeMusketeers"
  , "I-PPPei+"
  , "Prometheus"
  , "Nostalgia"
  , "Time After Time"
  , "TriMusketeers"
  , "null"
  , "Unknown"
];

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Expresses', teamName: teamName });
});

module.exports = router;
