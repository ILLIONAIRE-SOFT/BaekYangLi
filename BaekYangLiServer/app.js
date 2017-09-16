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

app.get('/test', function(req ,res) {
  res.send("[\r\n  {\r\n    \"station_id\": 172,\r\n    \"station_code\": \"331\",\r\n    \"line\": \"3\",\r\n    \"name\": \"\uCDA9\uBB34\uB85C\",\r\n    \"lat\": 37.561243,\r\n    \"lng\": 126.99428,\r\n    \"map_station_code\": \"0321\",\r\n    \"D\": 8.24899999934487e-9,\r\n    \"up\": [\r\n      {\r\n        \"FR_CODE\": \"331\",\r\n        \"STATION_CD\": \"0321\",\r\n        \"ARRIVETIME\": \"23:54:00\",\r\n        \"LEFTTIME\": \"23:54:30\",\r\n        \"SUBWAYNAME\": \"\uCDA9\uBB34\uB85C\",\r\n        \"SUBWAYCODE\": \"0321\",\r\n        \"TRAINCODE\": \"S3366\",\r\n        \"DESTSTATION_NAME\": \"\uB3C5\uB9BD\uBB38\",\r\n        \"DESTSTATION_CODE\": \"0316\"\r\n      },\r\n      {\r\n        \"FR_CODE\": \"331\",\r\n        \"STATION_CD\": \"0321\",\r\n        \"ARRIVETIME\": \"23:54:00\",\r\n        \"LEFTTIME\": \"23:54:30\",\r\n        \"SUBWAYNAME\": \"\uCDA9\uBB34\uB85C\",\r\n        \"SUBWAYCODE\": \"0321\",\r\n        \"TRAINCODE\": \"S3366\",\r\n        \"DESTSTATION_NAME\": \"\uB3C5\uB9BD\uBB38\",\r\n        \"DESTSTATION_CODE\": \"0316\"\r\n      },\r\n      {\r\n        \"FR_CODE\": \"331\",\r\n        \"STATION_CD\": \"0321\",\r\n        \"ARRIVETIME\": \"23:54:00\",\r\n        \"LEFTTIME\": \"23:54:30\",\r\n        \"SUBWAYNAME\": \"\uCDA9\uBB34\uB85C\",\r\n        \"SUBWAYCODE\": \"0321\",\r\n        \"TRAINCODE\": \"S3366\",\r\n        \"DESTSTATION_NAME\": \"\uB3C5\uB9BD\uBB38\",\r\n        \"DESTSTATION_CODE\": \"0316\"\r\n      }\r\n    ],\r\n    \"down\": [\r\n      {\r\n        \"FR_CODE\": \"331\",\r\n        \"STATION_CD\": \"0321\",\r\n        \"ARRIVETIME\": \"23:56:30\",\r\n        \"LEFTTIME\": \"23:57:00\",\r\n        \"SUBWAYNAME\": \"\uCDA9\uBB34\uB85C\",\r\n        \"SUBWAYCODE\": \"0321\",\r\n        \"TRAINCODE\": \"S3357\",\r\n        \"DESTSTATION_NAME\": \"\uC57D\uC218\",\r\n        \"DESTSTATION_CODE\": \"0323\"\r\n      },\r\n      {\r\n        \"FR_CODE\": \"331\",\r\n        \"STATION_CD\": \"0321\",\r\n        \"ARRIVETIME\": \"23:56:30\",\r\n        \"LEFTTIME\": \"23:57:00\",\r\n        \"SUBWAYNAME\": \"\uCDA9\uBB34\uB85C\",\r\n        \"SUBWAYCODE\": \"0321\",\r\n        \"TRAINCODE\": \"S3357\",\r\n        \"DESTSTATION_NAME\": \"\uC57D\uC218\",\r\n        \"DESTSTATION_CODE\": \"0323\"\r\n      }\r\n    ],\r\n    \"meter\": 0.00851974741877374\r\n  },\r\n  {\r\n    \"station_id\": 208,\r\n    \"station_code\": \"423\",\r\n    \"line\": \"4\",\r\n    \"name\": \"\uCDA9\uBB34\uB85C\",\r\n    \"lat\": 37.561243,\r\n    \"lng\": 126.99428,\r\n    \"map_station_code\": \"0321\",\r\n    \"D\": 8.24899999934487e-9,\r\n    \"up\": [\r\n      {\r\n        \"FR_CODE\": \"423\",\r\n        \"STATION_CD\": \"0423\",\r\n        \"ARRIVETIME\": \"23:52:00\",\r\n        \"LEFTTIME\": \"23:52:30\",\r\n        \"SUBWAYNAME\": \"\uCDA9\uBB34\uB85C\",\r\n        \"SUBWAYCODE\": \"0423\",\r\n        \"TRAINCODE\": \"S4686\",\r\n        \"DESTSTATION_NAME\": \"\uD55C\uC131\uB300\uC785\uAD6C\",\r\n        \"DESTSTATION_CODE\": \"0419\"\r\n      },\r\n      {\r\n        \"FR_CODE\": \"423\",\r\n        \"STATION_CD\": \"0423\",\r\n        \"ARRIVETIME\": \"23:52:00\",\r\n        \"LEFTTIME\": \"23:52:30\",\r\n        \"SUBWAYNAME\": \"\uCDA9\uBB34\uB85C\",\r\n        \"SUBWAYCODE\": \"0423\",\r\n        \"TRAINCODE\": \"S4686\",\r\n        \"DESTSTATION_NAME\": \"\uD55C\uC131\uB300\uC785\uAD6C\",\r\n        \"DESTSTATION_CODE\": \"0419\"\r\n      },\r\n      {\r\n        \"FR_CODE\": \"423\",\r\n        \"STATION_CD\": \"0423\",\r\n        \"ARRIVETIME\": \"23:52:00\",\r\n        \"LEFTTIME\": \"23:52:30\",\r\n        \"SUBWAYNAME\": \"\uCDA9\uBB34\uB85C\",\r\n        \"SUBWAYCODE\": \"0423\",\r\n        \"TRAINCODE\": \"S4686\",\r\n        \"DESTSTATION_NAME\": \"\uD55C\uC131\uB300\uC785\uAD6C\",\r\n        \"DESTSTATION_CODE\": \"0419\"\r\n      }\r\n    ],\r\n    \"down\": [\r\n      {\r\n        \"FR_CODE\": \"423\",\r\n        \"STATION_CD\": \"0423\",\r\n        \"ARRIVETIME\": \"23:55:30\",\r\n        \"LEFTTIME\": \"23:56:00\",\r\n        \"SUBWAYNAME\": \"\uCDA9\uBB34\uB85C\",\r\n        \"SUBWAYCODE\": \"0423\",\r\n        \"TRAINCODE\": \"S4175\",\r\n        \"DESTSTATION_NAME\": \"\uC11C\uC6B8\",\r\n        \"DESTSTATION_CODE\": \"0426\"\r\n      },\r\n      {\r\n        \"FR_CODE\": \"423\",\r\n        \"STATION_CD\": \"0423\",\r\n        \"ARRIVETIME\": \"23:55:30\",\r\n        \"LEFTTIME\": \"23:56:00\",\r\n        \"SUBWAYNAME\": \"\uCDA9\uBB34\uB85C\",\r\n        \"SUBWAYCODE\": \"0423\",\r\n        \"TRAINCODE\": \"S4175\",\r\n        \"DESTSTATION_NAME\": \"\uC11C\uC6B8\",\r\n        \"DESTSTATION_CODE\": \"0426\"\r\n      }\r\n    ],\r\n    \"meter\": 0.00851974741877374\r\n  },\r\n  {\r\n    \"station_id\": 101,\r\n    \"station_code\": \"203\",\r\n    \"line\": \"2\",\r\n    \"name\": \"\uC744\uC9C0\uB85C3\uAC00\",\r\n    \"lat\": 37.566295,\r\n    \"lng\": 126.99191,\r\n    \"map_station_code\": \"0203\",\r\n    \"D\": 0.00003120312499998105,\r\n    \"up\": [\r\n      {\r\n        \"FR_CODE\": \"203\",\r\n        \"STATION_CD\": \"0203\",\r\n        \"ARRIVETIME\": \"23:46:00\",\r\n        \"LEFTTIME\": \"23:46:30\",\r\n        \"SUBWAYNAME\": \"\uC744\uC9C0\uB85C3\uAC00\",\r\n        \"SUBWAYCODE\": \"0203\",\r\n        \"TRAINCODE\": \"2470\",\r\n        \"DESTSTATION_NAME\": \"\uC131\uC218\",\r\n        \"DESTSTATION_CODE\": \"0211\"\r\n      },\r\n      {\r\n        \"FR_CODE\": \"203\",\r\n        \"STATION_CD\": \"0203\",\r\n        \"ARRIVETIME\": \"23:46:00\",\r\n        \"LEFTTIME\": \"23:46:30\",\r\n        \"SUBWAYNAME\": \"\uC744\uC9C0\uB85C3\uAC00\",\r\n        \"SUBWAYCODE\": \"0203\",\r\n        \"TRAINCODE\": \"2470\",\r\n        \"DESTSTATION_NAME\": \"\uC131\uC218\",\r\n        \"DESTSTATION_CODE\": \"0211\"\r\n      }\r\n    ],\r\n    \"down\": [\r\n      {\r\n        \"FR_CODE\": \"203\",\r\n        \"STATION_CD\": \"0203\",\r\n        \"ARRIVETIME\": \"23:47:30\",\r\n        \"LEFTTIME\": \"23:48:00\",\r\n        \"SUBWAYNAME\": \"\uC744\uC9C0\uB85C3\uAC00\",\r\n        \"SUBWAYCODE\": \"0203\",\r\n        \"TRAINCODE\": \"2467\",\r\n        \"DESTSTATION_NAME\": \"\uD64D\uB300\uC785\uAD6C\",\r\n        \"DESTSTATION_CODE\": \"0239\"\r\n      },\r\n      {\r\n        \"FR_CODE\": \"203\",\r\n        \"STATION_CD\": \"0203\",\r\n        \"ARRIVETIME\": \"23:58:30\",\r\n        \"LEFTTIME\": \"23:59:00\",\r\n        \"SUBWAYNAME\": \"\uC744\uC9C0\uB85C3\uAC00\",\r\n        \"SUBWAYCODE\": \"0203\",\r\n        \"TRAINCODE\": \"2469\",\r\n        \"DESTSTATION_NAME\": \"\uC744\uC9C0\uB85C\uC785\uAD6C\",\r\n        \"DESTSTATION_CODE\": \"0202\"\r\n      }\r\n    ],\r\n    \"meter\": 0.6014203935353706\r\n  },\r\n  {\r\n    \"station_id\": 171,\r\n    \"station_code\": \"330\",\r\n    \"line\": \"3\",\r\n    \"name\": \"\uC744\uC9C0\uB85C3\uAC00\",\r\n    \"lat\": 37.566295,\r\n    \"lng\": 126.99191,\r\n    \"map_station_code\": \"0203\",\r\n    \"D\": 0.00003120312499998105,\r\n    \"up\": [\r\n      {\r\n        \"FR_CODE\": \"330\",\r\n        \"STATION_CD\": \"0320\",\r\n        \"ARRIVETIME\": \"23:55:30\",\r\n        \"LEFTTIME\": \"23:56:00\",\r\n        \"SUBWAYNAME\": \"\uC744\uC9C0\uB85C3\uAC00\",\r\n        \"SUBWAYCODE\": \"0320\",\r\n        \"TRAINCODE\": \"S3366\",\r\n        \"DESTSTATION_NAME\": \"\uB3C5\uB9BD\uBB38\",\r\n        \"DESTSTATION_CODE\": \"0316\"\r\n      },\r\n      {\r\n        \"FR_CODE\": \"330\",\r\n        \"STATION_CD\": \"0320\",\r\n        \"ARRIVETIME\": \"23:55:30\",\r\n        \"LEFTTIME\": \"23:56:00\",\r\n        \"SUBWAYNAME\": \"\uC744\uC9C0\uB85C3\uAC00\",\r\n        \"SUBWAYCODE\": \"0320\",\r\n        \"TRAINCODE\": \"S3366\",\r\n        \"DESTSTATION_NAME\": \"\uB3C5\uB9BD\uBB38\",\r\n        \"DESTSTATION_CODE\": \"0316\"\r\n      }\r\n    ],\r\n    \"down\": [\r\n      {\r\n        \"FR_CODE\": \"330\",\r\n        \"STATION_CD\": \"0320\",\r\n        \"ARRIVETIME\": \"23:55:00\",\r\n        \"LEFTTIME\": \"23:55:30\",\r\n        \"SUBWAYNAME\": \"\uC744\uC9C0\uB85C3\uAC00\",\r\n        \"SUBWAYCODE\": \"0320\",\r\n        \"TRAINCODE\": \"S3357\",\r\n        \"DESTSTATION_NAME\": \"\uC57D\uC218\",\r\n        \"DESTSTATION_CODE\": \"0323\"\r\n      },\r\n      {\r\n        \"FR_CODE\": \"330\",\r\n        \"STATION_CD\": \"0320\",\r\n        \"ARRIVETIME\": \"23:55:00\",\r\n        \"LEFTTIME\": \"23:55:30\",\r\n        \"SUBWAYNAME\": \"\uC744\uC9C0\uB85C3\uAC00\",\r\n        \"SUBWAYCODE\": \"0320\",\r\n        \"TRAINCODE\": \"S3357\",\r\n        \"DESTSTATION_NAME\": \"\uC57D\uC218\",\r\n        \"DESTSTATION_CODE\": \"0323\"\r\n      }\r\n    ],\r\n    \"meter\": 0.6014203935353706\r\n  },\r\n  {\r\n    \"station_id\": 267,\r\n    \"station_code\": \"535\",\r\n    \"line\": \"5\",\r\n    \"name\": \"\uC744\uC9C0\uB85C4\uAC00\",\r\n    \"lat\": 37.566941,\r\n    \"lng\": 126.998079,\r\n    \"map_station_code\": \"0204\",\r\n    \"D\": 0.000048005721999987566,\r\n    \"up\": [\r\n      {\r\n        \"FR_CODE\": \"535\",\r\n        \"STATION_CD\": \"2536\",\r\n        \"ARRIVETIME\": \"23:54:20\",\r\n        \"LEFTTIME\": \"23:54:40\",\r\n        \"SUBWAYNAME\": \"\uC744\uC9C0\uB85C4\uAC00\",\r\n        \"SUBWAYCODE\": \"2536\",\r\n        \"TRAINCODE\": \"5674\",\r\n        \"DESTSTATION_NAME\": \"\uC560\uC624\uAC1C\",\r\n        \"DESTSTATION_CODE\": \"2531\"\r\n      },\r\n      {\r\n        \"FR_CODE\": \"535\",\r\n        \"STATION_CD\": \"2536\",\r\n        \"ARRIVETIME\": \"23:54:20\",\r\n        \"LEFTTIME\": \"23:54:40\",\r\n        \"SUBWAYNAME\": \"\uC744\uC9C0\uB85C4\uAC00\",\r\n        \"SUBWAYCODE\": \"2536\",\r\n        \"TRAINCODE\": \"5674\",\r\n        \"DESTSTATION_NAME\": \"\uC560\uC624\uAC1C\",\r\n        \"DESTSTATION_CODE\": \"2531\"\r\n      }\r\n    ],\r\n    \"down\": [\r\n      {\r\n        \"FR_CODE\": \"535\",\r\n        \"STATION_CD\": \"2536\",\r\n        \"ARRIVETIME\": \"23:47:20\",\r\n        \"LEFTTIME\": \"23:47:50\",\r\n        \"SUBWAYNAME\": \"\uC744\uC9C0\uB85C4\uAC00\",\r\n        \"SUBWAYCODE\": \"2536\",\r\n        \"TRAINCODE\": \"5183\",\r\n        \"DESTSTATION_NAME\": \"\uAD70\uC790\",\r\n        \"DESTSTATION_CODE\": \"2545\"\r\n      },\r\n      {\r\n        \"FR_CODE\": \"535\",\r\n        \"STATION_CD\": \"2536\",\r\n        \"ARRIVETIME\": \"23:55:20\",\r\n        \"LEFTTIME\": \"23:55:50\",\r\n        \"SUBWAYNAME\": \"\uC744\uC9C0\uB85C4\uAC00\",\r\n        \"SUBWAYCODE\": \"2536\",\r\n        \"TRAINCODE\": \"5185\",\r\n        \"DESTSTATION_NAME\": \"\uC655\uC2ED\uB9AC\",\r\n        \"DESTSTATION_CODE\": \"2541\"\r\n      }\r\n    ],\r\n    \"meter\": 0.7241626501055298\r\n  },\r\n  {\r\n    \"station_id\": 102,\r\n    \"station_code\": \"204\",\r\n    \"line\": \"2\",\r\n    \"name\": \"\uC744\uC9C0\uB85C4\uAC00\",\r\n    \"lat\": 37.566941,\r\n    \"lng\": 126.998079,\r\n    \"map_station_code\": \"0204\",\r\n    \"D\": 0.000048005721999987566,\r\n    \"up\": [\r\n      {\r\n        \"FR_CODE\": \"204\",\r\n        \"STATION_CD\": \"0204\",\r\n        \"ARRIVETIME\": \"23:47:30\",\r\n        \"LEFTTIME\": \"23:48:00\",\r\n        \"SUBWAYNAME\": \"\uC744\uC9C0\uB85C4\uAC00\",\r\n        \"SUBWAYCODE\": \"0204\",\r\n        \"TRAINCODE\": \"2470\",\r\n        \"DESTSTATION_NAME\": \"\uC131\uC218\",\r\n        \"DESTSTATION_CODE\": \"0211\"\r\n      },\r\n      {\r\n        \"FR_CODE\": \"204\",\r\n        \"STATION_CD\": \"0204\",\r\n        \"ARRIVETIME\": \"23:47:30\",\r\n        \"LEFTTIME\": \"23:48:00\",\r\n        \"SUBWAYNAME\": \"\uC744\uC9C0\uB85C4\uAC00\",\r\n        \"SUBWAYCODE\": \"0204\",\r\n        \"TRAINCODE\": \"2470\",\r\n        \"DESTSTATION_NAME\": \"\uC131\uC218\",\r\n        \"DESTSTATION_CODE\": \"0211\"\r\n      }\r\n    ],\r\n    \"down\": [\r\n      {\r\n        \"FR_CODE\": \"204\",\r\n        \"STATION_CD\": \"0204\",\r\n        \"ARRIVETIME\": \"23:46:00\",\r\n        \"LEFTTIME\": \"23:46:30\",\r\n        \"SUBWAYNAME\": \"\uC744\uC9C0\uB85C4\uAC00\",\r\n        \"SUBWAYCODE\": \"0204\",\r\n        \"TRAINCODE\": \"2467\",\r\n        \"DESTSTATION_NAME\": \"\uD64D\uB300\uC785\uAD6C\",\r\n        \"DESTSTATION_CODE\": \"0239\"\r\n      },\r\n      {\r\n        \"FR_CODE\": \"204\",\r\n        \"STATION_CD\": \"0204\",\r\n        \"ARRIVETIME\": \"23:57:00\",\r\n        \"LEFTTIME\": \"23:57:30\",\r\n        \"SUBWAYNAME\": \"\uC744\uC9C0\uB85C4\uAC00\",\r\n        \"SUBWAYCODE\": \"0204\",\r\n        \"TRAINCODE\": \"2469\",\r\n        \"DESTSTATION_NAME\": \"\uC744\uC9C0\uB85C\uC785\uAD6C\",\r\n        \"DESTSTATION_CODE\": \"0202\"\r\n      }\r\n    ],\r\n    \"meter\": 0.7241626501055298\r\n  },\r\n  {\r\n    \"station_id\": 209,\r\n    \"station_code\": \"424\",\r\n    \"line\": \"4\",\r\n    \"name\": \"\uBA85\uB3D9\",\r\n    \"lat\": 37.560989,\r\n    \"lng\": 126.986325,\r\n    \"map_station_code\": \"0424\",\r\n    \"D\": 0.00006206014600020062,\r\n    \"up\": [\r\n      {\r\n        \"FR_CODE\": \"424\",\r\n        \"STATION_CD\": \"0424\",\r\n        \"ARRIVETIME\": \"23:50:30\",\r\n        \"LEFTTIME\": \"23:51:00\",\r\n        \"SUBWAYNAME\": \"\uBA85\uB3D9\",\r\n        \"SUBWAYCODE\": \"0424\",\r\n        \"TRAINCODE\": \"S4686\",\r\n        \"DESTSTATION_NAME\": \"\uD55C\uC131\uB300\uC785\uAD6C\",\r\n        \"DESTSTATION_CODE\": \"0419\"\r\n      },\r\n      {\r\n        \"FR_CODE\": \"424\",\r\n        \"STATION_CD\": \"0424\",\r\n        \"ARRIVETIME\": \"23:50:30\",\r\n        \"LEFTTIME\": \"23:51:00\",\r\n        \"SUBWAYNAME\": \"\uBA85\uB3D9\",\r\n        \"SUBWAYCODE\": \"0424\",\r\n        \"TRAINCODE\": \"S4686\",\r\n        \"DESTSTATION_NAME\": \"\uD55C\uC131\uB300\uC785\uAD6C\",\r\n        \"DESTSTATION_CODE\": \"0419\"\r\n      }\r\n    ],\r\n    \"down\": [\r\n      {\r\n        \"FR_CODE\": \"424\",\r\n        \"STATION_CD\": \"0424\",\r\n        \"ARRIVETIME\": \"23:57:00\",\r\n        \"LEFTTIME\": \"23:57:30\",\r\n        \"SUBWAYNAME\": \"\uBA85\uB3D9\",\r\n        \"SUBWAYCODE\": \"0424\",\r\n        \"TRAINCODE\": \"S4175\",\r\n        \"DESTSTATION_NAME\": \"\uC11C\uC6B8\",\r\n        \"DESTSTATION_CODE\": \"0426\"\r\n      },\r\n      {\r\n        \"FR_CODE\": \"424\",\r\n        \"STATION_CD\": \"0424\",\r\n        \"ARRIVETIME\": \"23:57:00\",\r\n        \"LEFTTIME\": \"23:57:30\",\r\n        \"SUBWAYNAME\": \"\uBA85\uB3D9\",\r\n        \"SUBWAYCODE\": \"0424\",\r\n        \"TRAINCODE\": \"S4175\",\r\n        \"DESTSTATION_NAME\": \"\uC11C\uC6B8\",\r\n        \"DESTSTATION_CODE\": \"0426\"\r\n      }\r\n    ],\r\n    \"meter\": 0.6945354186023492\r\n  },\r\n  {\r\n    \"station_id\": 170,\r\n    \"station_code\": \"329\",\r\n    \"line\": \"3\",\r\n    \"name\": \"\uC885\uB85C3\uAC00\",\r\n    \"lat\": 37.571607,\r\n    \"lng\": 126.991806,\r\n    \"map_station_code\": \"0153\",\r\n    \"D\": 0.00011403688500006076,\r\n    \"up\": [\r\n      {\r\n        \"FR_CODE\": \"329\",\r\n        \"STATION_CD\": \"0319\",\r\n        \"ARRIVETIME\": \"23:45:00\",\r\n        \"LEFTTIME\": \"23:45:30\",\r\n        \"SUBWAYNAME\": \"\uC885\uB85C3\uAC00\",\r\n        \"SUBWAYCODE\": \"0319\",\r\n        \"TRAINCODE\": \"S3364\",\r\n        \"DESTSTATION_NAME\": \"\uAD6C\uD30C\uBC1C\",\r\n        \"DESTSTATION_CODE\": \"0310\"\r\n      },\r\n      {\r\n        \"FR_CODE\": \"329\",\r\n        \"STATION_CD\": \"0319\",\r\n        \"ARRIVETIME\": \"23:57:00\",\r\n        \"LEFTTIME\": \"23:57:30\",\r\n        \"SUBWAYNAME\": \"\uC885\uB85C3\uAC00\",\r\n        \"SUBWAYCODE\": \"0319\",\r\n        \"TRAINCODE\": \"S3366\",\r\n        \"DESTSTATION_NAME\": \"\uB3C5\uB9BD\uBB38\",\r\n        \"DESTSTATION_CODE\": \"0316\"\r\n      }\r\n    ],\r\n    \"down\": [\r\n      {\r\n        \"FR_CODE\": \"329\",\r\n        \"STATION_CD\": \"0319\",\r\n        \"ARRIVETIME\": \"23:53:30\",\r\n        \"LEFTTIME\": \"23:54:00\",\r\n        \"SUBWAYNAME\": \"\uC885\uB85C3\uAC00\",\r\n        \"SUBWAYCODE\": \"0319\",\r\n        \"TRAINCODE\": \"S3357\",\r\n        \"DESTSTATION_NAME\": \"\uC57D\uC218\",\r\n        \"DESTSTATION_CODE\": \"0323\"\r\n      },\r\n      {\r\n        \"FR_CODE\": \"329\",\r\n        \"STATION_CD\": \"0319\",\r\n        \"ARRIVETIME\": \"23:53:30\",\r\n        \"LEFTTIME\": \"23:54:00\",\r\n        \"SUBWAYNAME\": \"\uC885\uB85C3\uAC00\",\r\n        \"SUBWAYCODE\": \"0319\",\r\n        \"TRAINCODE\": \"S3357\",\r\n        \"DESTSTATION_NAME\": \"\uC57D\uC218\",\r\n        \"DESTSTATION_CODE\": \"0323\"\r\n      }\r\n    ],\r\n    \"meter\": 1.1762853244658373\r\n  }\r\n]");
})
app.get('/', function (req, res) {
  res.sendFile(process.cwd()+'/view/apis.html');
});

app.get('/subwayLiveView', function(req, res) {
  res.sendFile(process.cwd()+'/view/liveView.html');
});

app.get('/subwayLiveTest', function(req, res) {
  res.sendFile(process.cwd()+'/view/liveTest.html');
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

app.get('/getArrivalTimeLiveMapCode/:map_code', function(req, res) {
  var name;
  for(var i = 0; i < allStations.length; i++)
    if(allStations[i].map_station_code == req.params.map_code) {
      name = allStations[i].name;
      break;
    }
  console.log(name);
  res.send(getArrivalTimeLive(name));
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
      result[i].meter = calcCrow(req.params.lat,req.params.lng,result[i].lat,result[i].lng);
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
  if(req.params.dest.trim().endsWith("역"))
    req.params.dest = req.params.dest.slice(0, req.params.dest.length-1);
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
  try {
    var res = request('GET', 'http://openapi.seoul.go.kr:8088/'+config.key+'/json/SearchArrivalTimeOfLine2SubwayByFRCodeService/1/3/'+stationCode+'/'+up+'/'+getDayType());
    var data = JSON.parse(res.getBody('utf8'));
    return data.SearchArrivalTimeOfLine2SubwayByFRCodeService.row;
  } catch(err) {

  }
  return "";
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
  var list = data.shortestRouteList;
  for(var i = 0 ; i < list.length; i++) {
    var stns = list[i].shtStatnId.split(",");
    for(var j = 0; j < stns.length; j++) {
      if(stns[j].startsWith("106708")) {
        stns[j] = "경춘선";
      } else if(stns[j].startsWith("1001")) {
        stns[j] = "1호선";
      } else if(stns[j].startsWith("1002")) {
        stns[j] = "2호선";
      } else if(stns[j].startsWith("1003")) {
        stns[j] = "3호선";
      } else if(stns[j].startsWith("1004")) {
        stns[j] = "4호선";
      } else if(stns[j].startsWith("1005")) {
        stns[j] = "5호선";
      } else if(stns[j].startsWith("1006")) {
        stns[j] = "6호선";
      } else if(stns[j].startsWith("1007")) {
        stns[j] = "7호선";
      } else if(stns[j].startsWith("1008")) {
        stns[j] = "8호선";
      } else if(stns[j].startsWith("1009")) {
        stns[j] = "9호선";
      } else if(stns[j].startsWith("1063")||stns[j].startsWith("106107")) {
        stns[j] = "경의중앙선";
      } else if(stns[j].startsWith("106500")) {
        stns[j] = "공항철도";
      } else if(stns[j].startsWith("107507")) {
        stns[j] = "분당선";
      }
    }
    list[i].shtStatnId = stns;
  }
  return list;
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