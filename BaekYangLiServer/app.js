var express = require('express')
  , http = require('http')
  , app = express()
  , server = http.createServer(app);
var config = require(process.cwd()+'/db/config.js');
var mysql = require('mysql');
var connection = mysql.createConnection(config.db);
connection.connect();

var request = require('sync-request');

app.get('/', function (req, res) {
  res.send('Hello /');
});

app.get('/world.html', function (req, res) {
  res.send('Hello World');
});

app.get('/getArrivalTimeOfStation/:station_code', function (req, res) {
  res.send(getArrivalTimeOfStation(req.params.station_code));
});

app.get('/getNearStations/:lat/:lng', function(req, res) {
  var sql = "SELECT *, (lat-"+req.params.lat+")*(lat-"+req.params.lat+")+(lng-"+req.params.lng+")*(lng-"+req.params.lng+") AS D from station order by D limit 5;";
  connection.query(sql, function(err, result) {
    res.send(result);
  });
});

server.listen(8000, function() {
  console.log('Express server listening on port ' + server.address().port);
});

function getArrivalTimeOfStation(stationCode) {
  var res = request('GET', 'http://openapi.seoul.go.kr:8088/'+config.key+'/json/SearchArrivalTimeOfLine2SubwayByFRCodeService/1/5/'+stationCode+'/1/1/');
  var data = JSON.parse(res.getBody('utf8'));
  return data.SearchArrivalTimeOfLine2SubwayByFRCodeService.row;
}