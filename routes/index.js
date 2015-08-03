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
];

/* GET home page. */
router.get('/rating/test', function(req, res, next) {
  res.render('index', { title: '北航ACM集训队Rating计算', teamName: teamName });
});

module.exports = router;
