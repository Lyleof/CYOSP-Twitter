var express = require('express');
var router = express.Router();
var mysql = require('mysql');
var pool        = mysql.createPool({
    connectionLimit : 10000, // default = 10
    host            : 'localhost',
    user            : 'twitterAdmin',
    password        : 'tacos1235',
    database        : 'twitter_model'
});

/* GET users listing. */
router.get('/', function(req, res, next) {
  res.send('respond with a resource');
});

router.get('/getTimeline', function(req, res, next) {
    pool.getConnection(function(err, con) {
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

router.get('/getUser', function(req, res, next) {
    pool.getConnection(function(err, con) {
        if (err) throw err;
        console.log('Connected!'); // Currently getting an error on sql queries
        con.query('call twitter_model.get_user(\'' + req.get('username') + '\', \'' + req.get('pass') + '\');'
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

router.get('/getUserTweets', function(req, res, next) {
    pool.getConnection(function(err, con) {
        if (err) throw err;
        console.log('Connected!'); // Currently getting an error on sql queries
        con.query('call twitter_model.get_user_tweets(\'' + req.get('username') + '\');'
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

router.get('/getTweetFavs', function(req, res, next) {
    pool.getConnection(function(err, con) {
        if (err) throw err;
        console.log('Connected!'); // Currently getting an error on sql queries
        con.query('call twitter_model.get_tweet_favs(\'' + req.get('tweet_id') + '\');'
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

router.get('/getUsersFollowing', function(req, res, next) {
    pool.getConnection(function(err, con) {
        if (err) throw err;
        console.log('Connected!'); // Currently getting an error on sql queries
        con.query('call twitter_model.get_users_following(\'' + req.get('username') + '\');'
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

router.get('/getUsersFollowers', function(req, res, next) {
    pool.getConnection(function(err, con) {
        if (err) throw err;
        console.log('Connected!'); // Currently getting an error on sql queries
        con.query('call twitter_model.get_users_followers(\'' + req.get('username') + '\');'
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

router.get('/getUsersFavs', function(req, res, next) {
    pool.getConnection(function(err, con) {
        if (err) throw err;
        console.log('Connected!'); // Currently getting an error on sql queries
        con.query('call twitter_model.get_users_favs(\'' + req.get('username') + '\');'
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
