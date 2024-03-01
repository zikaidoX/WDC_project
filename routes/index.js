/* eslint-disable linebreak-style */
var express = require('express');
var router = express.Router();

//add hashing and salting
const argon2 = require('argon2');

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

/* GET posts from database*/
router.get('/getPosts', function(req, res, next){
  console.log(req.body);
  req.pool.getConnection(function (cerr, connection){
    if(cerr){
      console.log("Connection Error");
      res.sendStatus(500);
      return;
    }
    let query = `SELECT Club_Posts.id, Club_Posts.created, Club_Posts.content, Clubs.club_name FROM Club_Posts
                INNER JOIN Clubs ON Club_Posts.club_id = Clubs.id WHERE Club_Posts.is_public = 1 ORDER BY Club_Posts.created DESC`;
    connection.query(query, (qerr, rows, fields) => {
      connection.release();
      if(qerr) {
        console.log("Query Error");
        res.sendStatus(500);
        return;
      }
        res.json(rows);

  });

  });
});

/* Post Signup data and add to database */
router.post('/signup', function(req, res, next){
  if('email' in req.body && 'password' in req.body && 'first_name' in req.body && 'last_name' in req.body){
    console.log(req.body);
    req.pool.getConnection(async function(cerr, connection){
      if(cerr){
        console.log("Connection Error");
        res.sendStatus(500);
        return;
      }
      //hash the password
      const hash = await argon2.hash(req.body.password);
      let query = `INSERT INTO Users (first_name, last_name, email, pass) VALUES (?, ?, ?, ?)`;
      connection.query(query, [req.body.first_name, req.body.last_name, req.body.email, hash],
      function(qerr, rows, fields){
        connection.release();
        if(qerr){
          console.log("Values:", [req.body.first_name, req.body.last_name, req.body.email, hash]);
          console.log("Query Error");
          res.sendStatus(500);
          return;
        }
        res.end();
      });
    });
  } else {
    res.sendStatus(401);
  }
});

router.post('/login', function(req, res, next){
  console.log(req.body);
  if('email' in req.body && 'password' in req.body){
    req.pool.getConnection(async function(cerr, connection){
      if(cerr){
        console.log("Connection Error");
        res.sendStatus(500);
        return;
      }
      let query = "SELECT id, first_name, last_name, email, pass, is_admin, is_manager FROM Users WHERE email = ?";
      connection.query(query, [req.body.email], async function(qerr, rows, fields){
        connection.release();
        if(qerr){
          console.log("Query Error");
          res.sendStatus(500);
          return;
        }
        //if there is user
        if(rows.length > 0){
          //use argon verify to see if hash matches plaintext
          if(await argon2.verify(rows[0].pass, req.body.password)){
            let [user_info] = rows;
            delete user_info.pass;
            //there is a user

            req.session.user = user_info;
            req.session.id = user_info.id;
            console.log(req.session.user);
            res.json(req.session.user);
          } else {
            res.sendStatus(401);
          }
        } else {
          res.sendStatus(401);
        }
      });
    });
  }
});

module.exports = router;