var express = require('express')
  , http = require('http')
  , app = express()
  , server = http.createServer(app);
var config = require(process.cwd()+'/db/config.js');
var mysql = require('mysql');
var urlencode = require('urlencode');
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

app.get('/findRoute/:start/:dest', function(req, res) {
  console.log(req.params);
  res.send(getRoutes(req.params.start, req.params.dest));
})

server.listen(8000, function() {
  console.log('Express server listening on port ' + server.address().port);
});

function getArrivalTimeOfStation(stationCode) {
  var res = request('GET', 'http://openapi.seoul.go.kr:8088/'+config.key+'/json/SearchArrivalTimeOfLine2SubwayByFRCodeService/1/5/'+stationCode+'/1/1/');
  var data = JSON.parse(res.getBody('utf8'));
  var res2 = request('GET', 'http://openapi.seoul.go.kr:8088/'+config.key+'/json/SearchArrivalTimeOfLine2SubwayByFRCodeService/1/5/'+stationCode+'/1/2/');
  var data2 = JSON.parse(res.getBody('utf8'));
  return data.SearchArrivalTimeOfLine2SubwayByFRCodeService.row.concat(data2.SearchArrivalTimeOfLine2SubwayByFRCodeService.row);
}

function getRoutes(start, dest) {
  var res = request('GET', 'http://swopenapi.seoul.go.kr/api/subway/sample/json/shortestRoute/0/5/'+urlencode(start)+'/'+urlencode(dest));
  console.log(res.getBody('utf8'));
  var data = JSON.parse(res.getBody('utf8'));
  return data.shortestRouteList;
}