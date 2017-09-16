var express = require('express')
  , http = require('http')
  , app = express()
  , server = http.createServer(app);
var config = require(process.cwd()+'/db/config.js');
var mysql = require('mysql');
var urlencode = require('urlencode');
var connection = mysql.createConnection(config.db);
connection.connect();

var htmlparser = require('htmlparser2');
var request = require('sync-request');
var allStations;
var sql = "SELECT *, (SELECT COUNT(*) from station where name = A.name ) AS transfer from station AS A";

connection.query(sql, function(err, result) {
  allStations = result;
});

app.get('/', function (req, res) {
  res.sendFile(process.cwd()+'/view/apis.html');
});

app.get('/subwayLiveView', function(req, res) {
  res.sendFile(process.cwd()+'/view/liveView.html');
});

app.get('/assets/:file', function(req, res) {
  res.sendFile(process.cwd()+'/assets/'+req.params.file);
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
  var sql = "SELECT *, (lat-"+req.params.lat+")*(lat-"+req.params.lat+")+(lng-"+req.params.lng+")*(lng-"+req.params.lng+") AS D from station order by D limit 8;";
  connection.query(sql, function(err, result) {
    for(var i = 0; i < result.length; i++) {
      result[i].up =  getArrivalTimeOfStation(result[i].station_code,1);
      result[i].down =  getArrivalTimeOfStation(result[i].station_code,2);
      result[i].meter = calcCrow(req.params.lat,req.params.lng,result[i].lat,result[i].lng)*1000;
    }
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

app.get('/getTrains', function(req, res) {
  var sql = "SELECT * from timetable where TIME_TO_SEC(left_time) >= TIME_TO_SEC(NOW()) AND TIME_TO_SEC(left_time) <= TIME_TO_SEC(NOW()) AND week_tag = "+getDayType();
  console.log(sql);
  connection.query(sql, function(err, result) {
    for(var i = 0; i < result.length; i++) {
      console.log(result[i]);
      result[i].mapCode = getMapStationCodeByCode(result[i].station_num);
    }
    res.send(result);
  });
})

app.get('/getTrainsLive/:line', function(req, res) {
  var startParse = 0;
  var line = 0;
  var infos = new Object();
  
  var data = request('GET',"https://smss.seoulmetro.co.kr/traininfo/traininfoUserMap.do").getBody('utf8');
  var parser = new htmlparser.Parser({
      onopentag: function(name, attribs){
          if(name == "div") {
              if(attribs.class != null) {
                  if(attribs.class.endsWith("line")) {
                      startParse = 0;
                  }
                  if(attribs.class.endsWith("line_metro")) {
                      line = attribs.class.slice(0,1);
                      startParse = 1;
                      infos[line] = new Array();
                      return;
                  }
                  if(startParse) {
                      infos[line][infos[line].length] = attribs;
                  }
              }
          }
      },
      ontext: function(text){
      },
      onclosetag: function(tagname){
      }
  }, {decodeEntities: true});
  parser.write(data);
  parser.end();
  var line = req.params.line;
  for(var i = 1; i <= 8; i++) {
    if(line != null && line != "all" && line != i)
      continue;
    for(var j = 0; j < infos[i].length; j++) {
      infos[i][j] = getInfo(i,infos[i][j]);
    }
  }
  if(line != "all")
    res.send(infos[line]);
  else 
    res.send(infos);
});

server.listen(8000, function() {
  console.log('Express server listening on port ' + server.address().port);
});

function getArrivalTimeOfStation(stationCode, up) {
  var res = request('GET', 'http://openapi.seoul.go.kr:8088/'+config.key+'/json/SearchArrivalTimeOfLine2SubwayByFRCodeService/1/3/'+stationCode+'/'+up+'/'+getDayType());
  var data = JSON.parse(res.getBody('utf8'));
  return data.SearchArrivalTimeOfLine2SubwayByFRCodeService.row;
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

function getMapStationCodeByCode(code) {
  for(var i = 0; i < allStations.length; i++) {
    if(allStations[i].station_code == code) {
      return allStations[i].map_station_code;
    }
  }
}

function getInfo(line, rawData) {
  if(rawData.title == null)
    return rawData;
  rawData.stnName = rawData.title.split(" ")[2];
  rawData.line = line;
  rawData.status = rawData.title.split(" ")[3];
  rawData.dest = rawData.title.split(" ")[4];
  rawData.dest = rawData.dest.slice(0,rawData.dest.length-1);
  for(var i = 0; i < allStations.length; i++)
    if(allStations[i].line == line && allStations[i].name == rawData.stnName) {
      rawData.station_code = allStations[i].station_code;
      rawData.map_station_code = allStations[i].map_station_code;
    } else if(allStations[i].line == line && allStations[i].name.includes(rawData.dest)) {
      rawData.dest_code = allStations[i].station_code;
      rawData.map_dest_code = allStations[i].station_code;
    }
  delete(rawData.class);
  delete(rawData.title);
  delete(rawData["data-statntcd"]);
  rawData.isUp = rawData.map_dest_code > rawData.map_station_code ? 2 : 1;
  var percentage = 0;
  switch(rawData.status) {
      case "도착":
          percentage = 90;
          break;
      case "진입":
          percentage = 80;
          break;
      case "접근":
          percentage = 60;
          break;
      case "이동":
          percentage = 40;
          break;
      case "출발":
          percentage = 20;
          break;
  }
  rawData.percentage = percentage;
  return rawData;
}

function calcCrow(lat1, lon1, lat2, lon2) 
{
  var R = 6371; // km
  var dLat = toRad(lat2-lat1);
  var dLon = toRad(lon2-lon1);
  var lat1 = toRad(lat1);
  var lat2 = toRad(lat2);

  var a = Math.sin(dLat/2) * Math.sin(dLat/2) +
    Math.sin(dLon/2) * Math.sin(dLon/2) * Math.cos(lat1) * Math.cos(lat2); 
  var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)); 
  var d = R * c;
  return d;
}

// Converts numeric degrees to radians
function toRad(Value) 
{
    return Value * Math.PI / 180;
}