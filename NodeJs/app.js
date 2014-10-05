var express = require('express');
var app = require('express')();
var server = require('http').createServer(app);
var request = require('request');
var fs = require('fs');
var mongoose = require('mongoose');
var agent = require('./agent/_header');

//mongoose.connect('mongodb://localhost/users');
mongoose.connect('mongodb:http://54.77.86.119:27017/users');

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
            gender: String,
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

app.post('/users', function (req, res) {
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
                name: obj.name
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

app.post('/users/:username/history', function (req, res) {
    var data = '';
    if (req.method === 'POST') {
        req.on('data', function (chunk) {
            data += chunk;
        });
        req.on('end', function () {
            var username = req.params.username;
            console.log(data);
            var db = mongoose.connection;
            db.on('error', console.error.bind(console, 'connection error:'));
            db.once('open', function callback() {
                console.log('yay!');
            });
            console.log(req);
            var obj = JSON.parse(data);
            var conditions = {
                name: username
            };
            update = {
                $push: {
                    'history': obj
                }
            };
            options = {
                multi: false,
                upsert: true
            };

            return User.update(conditions, update, options, function (err) {
                if (!err) {
                    return res.send("history upserted");
                } else {
                    console.log(err);
                    return res.send(404, {
                        error: "History was not updated."
                    });
                }
            });
        })
    }
});


app.post('/notification/', function (req, res) {
    var data = '';
    if (req.method === 'POST') {
        req.on('data', function (chunk) {
            data += chunk;
        });
        req.on('end', function () {
            agent.createMessage().device("<acc929df 77f116c5 2a608935 e871139e 32692856 d77734a6 446b9ed4 455ddbc1>").alert('Farid: Une francaise notée 9/10. Lieux AEROPORT OCTEVILLE').badge(3).send();
            return res.send("notification send");
        })
    }
});