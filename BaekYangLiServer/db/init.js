var config = require(process.cwd()+"/config");
var mysql = require("mysql");
var request = require('sync-request');

var connection = mysql.createConnection(config.db);
connection.connect();
var lines = [1,2,3,4,5,6,7,8,9,"I","B","A","G","S","SU"];

for(var i = 0 ; i < lines.length ; i++) {
   var stations = getStations(lines[i]);
   for(var j = 0; j < stations.length; j++) {
       var info = getLatLng(stations[j].FR_CODE);
       var sql = "INSERT INTO station (station_code,line,name,lat,lng) VALUES (\""+info.FR_CODE+"\",\""+info.LINE_NUM+"\",\""+info.STATION_NM+"\",\""+info.XPOINT_WGS+"\",\""+info.YPOINT_WGS+"\");";
       console.log(sql);
       connection.query(sql, function (err, result) {
        console.log("sdf");
        console.log(err);
        console.log("1 record inserted");
       });
       //console.log(sql);
   }
}

function getStations(line) {
    var res = request('GET', 'http://openapi.seoul.go.kr:8088/'+config.key+'/json/SearchSTNBySubwayLineService/1/1000/'+line);
    var stations = JSON.parse(res.getBody('utf8'));
    return stations.SearchSTNBySubwayLineService.row;
}

function getLatLng(sNum) {
   // console.log(sNum);
    var res = request('GET', 'http://openapi.seoul.go.kr:8088/'+config.key+'/json/SearchLocationOfSTNByFRCodeService/1/5/'+sNum);
    var info = JSON.parse(res.getBody('utf8'));
    //console.log(info.SearchLocationOfSTNByFRCodeService.row[0]);
    return info.SearchLocationOfSTNByFRCodeService.row[0];
}
