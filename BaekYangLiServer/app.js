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

app.get('/getArrivalTimeLive/:station_name', function(req, res) {
  res.send(getArrivalTimeLive(req.params.station_name));
});

app.get('/getArrivalTimeOfStation/:station_code', function (req, res) {
  res.send(getArrivalTimeOfStation(req.params.station_code));
});

app.get('/getStationsByName/:name', function(req ,res) {
  if(req.params.name.trim().endsWith("역"))
    req.params.name = req.params.name.slice(0, req.params.name.length-1);
  var sql = "SELECT *, (SELECT COUNT(*) from station where name = A.name ) AS transfer, name = \""+req.params.name+"\" AS equal from station AS A where name LIKE \"%"+req.params.name+"%\""+" order by equal desc, name";
  console.log(sql);
  connection.query(sql, function(err, result) {
    res.send(result);
  });
});

app.get('/getStationsByCode/:station_code', function(req ,res) {
  var sql = "SELECT *, (SELECT COUNT(*) from station where name = A.name ) AS transfer from station AS A where station_code = "+req.params.station_code;
  console.log(sql);
  connection.query(sql, function(err, result) {
    res.send(result);
  });
});

app.get('/getNearStations/:lat/:lng', function(req, res) {
  var sql = "SELECT *, (lat-"+req.params.lat+")*(lat-"+req.params.lat+")+(lng-"+req.params.lng+")*(lng-"+req.params.lng+") AS D from station order by D limit 5;";
  connection.query(sql, function(err, result) {
    res.send(result);
  });
});

app.get('/getStationsByLine/:line', function(req, res) {
  var sql = "SELECT *, (SELECT COUNT(*) from station where name = A.name ) AS transfer from station AS A where line = \"" + req.params.line+"\"";
  console.log(sql);
  connection.query(sql, function(err, result) {
    res.send(result);
  });
});

app.get('/getStations', function(req, res) {
  var sql = "SELECT *, (SELECT COUNT(*) from station where name = A.name ) AS transfer from station AS A";
  console.log(sql);
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
  var res = request('GET', 'http://openapi.seoul.go.kr:8088/'+config.key+'/json/SearchArrivalTimeOfLine2SubwayByFRCodeService/1/5/'+stationCode+'/1/'+getDayType());
  var data = JSON.parse(res.getBody('utf8'));
  var res2 = request('GET', 'http://openapi.seoul.go.kr:8088/'+config.key+'/json/SearchArrivalTimeOfLine2SubwayByFRCodeService/1/5/'+stationCode+'/2/'+getDayType());
  console.log('http://openapi.seoul.go.kr:8088/'+config.key+'/json/SearchArrivalTimeOfLine2SubwayByFRCodeService/1/5/'+stationCode+'/2/'+getDayType());
  var data2 = JSON.parse(res2.getBody('utf8'));
  return data.SearchArrivalTimeOfLine2SubwayByFRCodeService.row.concat(data2.SearchArrivalTimeOfLine2SubwayByFRCodeService.row);
}

function getArrivalTimeLive(stationName) {
  var res;
  for(var i = 0; i < 5; i++) {
      res = request('GET', 'http://swopenapi.seoul.go.kr/api/subway/sample/json/realtimeStationArrival/0/5/'+urlencode(stationName)).getBody('utf8');
      if(res.includes('apache'))
        continue;
      else
        break;
  }
  var data = JSON.parse(res);
  return data.realtimeArrivalList;
}

function getRoutes(start, dest) {
  var res = request('GET', 'http://swopenapi.seoul.go.kr/api/subway/sample/json/shortestRoute/0/5/'+urlencode(start)+'/'+urlencode(dest));
  console.log(res.getBody('utf8'));
  var data = JSON.parse(res.getBody('utf8'));
  return data.shortestRouteList;
}

function getDayType() {
  return Math.max(new Date().getDay()-4,1);
}

