var x = document.getElementsByTagName("circle");
var svg = d3.select("body").select("svg#map");
var bubble = d3.select("body").select("svg#bubble");
var container = d3.select("svg#test");
var lines = document.getElementsByClassName("line");
var colors = new Object();
for(var i = 0; i < lines.length; i++) {
    var color = lines[i].getAttribute("stroke");
    var paths = lines[i].getElementsByClassName("path");
    var line = paths[0].getAttribute("class").split(" ")[1];
    colors[line] = color;
}

setTimeout(function() {
    x = document.getElementsByTagName("circle");
    svg = d3.select("body").select("svg#map");
    lines = document.getElementsByClassName("line");
    colors = new Object();
    for(var i = 0; i < lines.length; i++) {
        var color = lines[i].getAttribute("stroke");
        var paths = lines[i].getElementsByClassName("path");
        var line = paths[0].getAttribute("class").split(" ")[1];
        colors[line] = color;
    }
}, 700);

//Deprecated
function findStationColor(path) {
    var line = path.node().getAttribute("class");
}

function findPathColor(path) {
    //console.log(path);
    var line = path.node().getAttribute("class").split(" ")[1];
    return colors[line];
}

function findPath(start, dest) {
    return d3.selectAll(".P"+start+dest);
}

var trainList = new Object();

function addTrain(trainNum, start, dest, duration, percentage) {
    //console.log(trainNum+" "+start+" "+dest+" "+duration+" "+percentage);
    var marker = d3.select("svg#test").append("rect");
    trainList[trainList.length] = marker;
    var reverse =  start > dest ? 1 : 0;
    var path = findPath(start,dest);
    var startPoint = pathStartPoint(path);
    //console.log(start+" "+dest);
    var color = findPathColor(path);
    marker.attr("width", 10).attr("height",10)
      .attr("transform", "translate(" + startPoint + ")").attr("fill",color);
    transition(path,marker,duration, start > dest ? 1 : 0,percentage);
}

var svg = d3.select("body").select("svg#map");

function pathStartPoint(path) {
    var d = path.attr("d"),
    dsplitted = d.split(" ");
    return dsplitted[1].split(",");
}
  
function transition(path,marker,duration,reverse,percentage) {
    marker.transition()
        .duration(duration)
        .ease("linear")
        .attrTween("transform", translateAlong(marker,path.node(),reverse,percentage));
}
  
function translateAlong(marker,path, reverse,percentage) {
    var l = path.getTotalLength();
    return function(i) {
      return function(t) {
        var p = path.getPointAtLength(reverse == 1 ? l - percentage/100 * l : percentage/100 * l);
        if(t == 1) marker.remove();
        return "translate(" + (p.x-5) + "," + (p.y-5) + ")";//Move marker
      }
    }
}

function httpGet(theUrl)
{
    var xmlHttp = new XMLHttpRequest();
    xmlHttp.open( "GET", theUrl, false ); // false for synchronous request
    xmlHttp.send( null );
    return xmlHttp.responseText;
}
var ss;

/*
setInterval(function(){
    var result = JSON.parse(httpGet("/getTrains"));
    ss = result;
    console.log(result);
    for(var i = 0; i < result.length; i++) {
        console.log("addTrain("+result[i].station_num+result[i].end_station+",\""+String(result[i].mapCode)+"\",\""+getNextStation(result[i].mapCode,result[i].inout_tag)+"\",60000,0)");
        addTrain(result[i].end_station,String(result[i].mapCode),getNextStation(result[i].mapCode),120000,0);
    }
},1000);
*/

var line = 1;
setInterval(function(){
    var result = JSON.parse(httpGet("/getTrainsLive/all"));
    ss = result;
    
    for(var k = 0; k < trainList.length; k++) {
        trainList[k].remove();
        delete(k);
    }
    delete(trainList);
    trainList = new Object();
    document.getElementById("test").innerHTML = "";
    for(var i = 1; i < 8; i++) {
        for(var j = 0; j < result[i].length; j++) {
            try {
                addTrain(result[i][j].station_code,String(result[i][j].map_station_code),getNextStation(result[i][j].map_station_code,result[i][j].isUp),8000,result[i][j].percentage);
            } catch (err) {
    
            }
        }
    }
},4000);
    
function getNextStation(start, inout) {
    var x = Number(start);
    x += (inout == 1?1:-1);
    x = String(x);
    if(x.length == 3)
        x = "0"+x;
    return x;
}

function showToolTip(xPosition, yPosition, text) {
    var tooltipG = svg.append("g")
    .attr("transform", "translate(" + xPosition + "," + yPosition + ")");
  
  tooltipG.append("rect")
    .attr("width","80")
    .attr("height","40")
    .style("fill", "grey");
  
  tooltipG.append("text")
    .style("font-size", "10px")
    .attr("dy", +10)
    .text((text));
}

function alertInfo(uid) {
    var result = JSON.parse(httpGet("/getArrivalTimeLiveMapCode/"+uid));
    var x = "";
    if(result.length > 0)
        x += result[0].statnNm+"역\n";
    for(var i = 0 ; i < result.length; i++)
     x += result[i].trainLineNm+" "+result[i].arvlMsg2+"\n";
    alert(x);
}