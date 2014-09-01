var express = require('express');
var app = require('express')();
var server = require('http').createServer(app);
var request = require('request');
var fs = require('fs');
var mongoose = require('mongoose');
mongoose.connect('mongodb://localhost/users');

server.listen(8080);

var userSchema = {
    name: String,
    surname: String,
    userID: String,
    password: String,
    email: String,
    history: [
        {
            date: 0,
            ranking: String,
            comment: String,
            where: String,
            job: String,
            nationality: String,
            height: String,
            weight: String,
            age: String,
            friendsShared: [{
                userID: String
}]
}
],
    friends: [{
        userId: String,
        accepted: String
}]
};

var User = mongoose.model('users', userSchema);

app.get('/', function (req, res) {
    'use strict';
    var response = '{\"response\":\"OK\"}';
    res.send(response);
});

app.get('/users/:user', function (req, res) {
    var username = req.params.user;
    console.log(username);
    var db = mongoose.connection;
    db.on('error', console.error.bind(console, 'connection error:'));
    db.once('open', function callback() {
        console.log('yay!');
    });
    User.find({
        name: username
    }, function (err, docs) {
        console.log('got a response' + docs);
        if (docs[0]) {
            res.send(docs[0]);
        } else {
            res.send({})
        }

    });
});

app.post('/users/:user', function (req, res) {
    var data = '';
    if (req.method === 'POST') {
        req.on('data', function (chunk) {
            data += chunk;
        });
        req.on('end', function () {
            var username = req.params.user;
            console.log(username);
            var db = mongoose.connection;
            db.on('error', console.error.bind(console, 'connection error:'));
            db.once('open', function callback() {
                console.log('yay!');
            });
            console.log(req);
            var obj = JSON.parse(data);
            var conditions = {
                _id: obj._id
            };
            update = obj;
            options = {
                multi: false,
                upsert: true
            };

            return User.update(conditions, update, options, function (err) {
                if (!err) {
                    return res.send("updated");
                } else {
                    console.log(err);
                    return res.send(404, {
                        error: "Person was not updated."
                    });
                }
            });
        })
    }
});

//var express = require('express');
//var app = require('express')();
//var server = require('http').createServer(app); 
//var request = require('request');
//var fs = require('fs');
//var mongoose = require('mongoose');
//mongoose.connect('mongodb://localhost/users');
//
//server.listen(8080);
//
//var userSchema = {
//    name: String,
//    surname: String,
//    userID: String,
//    password: String,
//    email: String,
//    history: [
//        {
//            date: 0,
//            ranking: String,
//            comment: String,
//            where: String,
//            job: String,
//            nationality: String,
//            height: String,
//            weight: String,
//            age: String,
//            friendsShared: [{
//                userID: String
//            }]
//        }
//    ],
//    friends: [{
//        userId: String,
//        accepted: String
//    }]
//};
//
//var User = mongoose.model('users', userSchema);
//
//app.get('/', function (req, res) {
//    'use strict';
//    var response = '{\"response\":\"OK\"}';
//    res.send(response);
//});
//
//app.get('/users/:user', function (req, res) {
//    var username = req.params.user;
//    console.log(username);
//    var db = mongoose.connection;
//    db.on('error', console.error.bind(console, 'connection error:'));
//    db.once('open', function callback() {
//        console.log('yay!');
//    });
//    User.find({
//        name: username
//    }, function (err, docs) {
//        console.log('got a response' + docs);
//        if(docs[0]){
//        res.send(docs[0]);
//        }else{
//        res.send({})
//        }
//        
//    });
//});
//
//app.put('/users/:user', function (req, res) {
//    var username = req.params.user;
//    console.log(username);
//    var db = mongoose.connection;
//    db.on('error', console.error.bind(console, 'connection error:'));
//    db.once('open', function callback() {
//        console.log('yay!');
//    });
//    console.log(req);
//
//    var conditions = {
//            _id: req.body._id
//        };
//        update = req.body;
//        options = {
//            multi: false,
//            upsert: true
//        };
//
//    return User.update(conditions, update, options, function (err) {
//        if (!err) {
//            return res.send("updated");
//        } else {
//            console.log(err);
//            return res.send(404, {
//                error: "Person was not updated."
//            });
//        }
//    });
//});
