var express = require('express');
var router = express.Router();
var mysql = require('mysql');

var con = mysql.createConnection({
    host: "localhost",
    user: "twitterAdmin",
    password: "tacos1235"
});

/* GET users listing. */
router.get('/', function(req, res, next) {
  res.send('respond with a resource');
});

router.get('/getTimeline', function(req, res, next) {
    con.connect(function(err) {
        if (err) throw err;
        console.log('Connected!'); // Currently getting an error on sql queries
        con.query('call twitter_model.get_timeline(\'' + req.get('username') + '\');'
            , function (err, result) {
            if (err)
            {
                console.log('Error grabbing timeline: ' + err);
                res.send('Error grabbing timeline, check your credentials and try again');
            }
            res.send(result);
        })
    });
});

module.exports = router;
