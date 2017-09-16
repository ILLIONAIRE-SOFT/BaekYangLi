var x = document.getElementsByTagName("circle");
var svg = d3.select("body").select("svg#map");

setTimeout(function() {
    x = document.getElementsByTagName("circle");
    svg = d3.select("body").select("svg#map");
}, 500);

function findStationColor(num) {
    try {
        return x["M"+num].getAttribute("stroke");
    } catch (err) {
        return "#052f93";
    }
}

function findPath(start, dest) {
    return d3.selectAll(".P"+start+dest);
}

var trainList = new Object();

function addTrain(trainNum, start, dest, duration, percentage) {
    console.log("addTrain");
    var marker = svg.append("rect");
    if(trainList[trainNum] != null)
        trainList[trainNum].remove();
    trainList[trainNum] = marker;
    var reverse =  start > dest ? 1 : 0;
    var path = findPath(start,dest);
    var startPoint = pathStartPoint(path);
    var color = findStationColor(start);
    marker.attr("width", 10).attr("height",10)
      .attr("transform", "translate(" + startPoint + ")").attr("fill",color);
    transition(path,marker,duration, start > dest ? 1 : 0);
}

var svg = d3.select("body").select("svg#map");

function pathStartPoint(path) {
    var d = path.attr("d"),
    dsplitted = d.split(" ");
    return dsplitted[1].split(",");
}
  
function transition(path,marker,duration,reverse) {
    marker.transition()
        .duration(duration)
        .attrTween("transform", translateAlong(marker,path.node(),reverse));
}
  
function translateAlong(marker,path, reverse) {
    var l = path.getTotalLength();
    return function(i) {
      return function(t) {
        var p = path.getPointAtLength(reverse == 1 ? l - t * l : t * l);
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

setInterval(function(){
    var result = JSON.parse(httpGet("/getTrains"));
    ss = result;
    console.log(result);
    for(var i = 0; i < result.length; i++) {
        console.log("addTrain("+result[i].end_station+","+String(result[i].mapCode)+","+getNextStation(result[i].mapCode,result[i].inout_tag)+",60000,0)");
        addTrain(result[i].station_num+result[i].end_station,String(result[i].mapCode),getNextStation(result[i].mapCode),120000,0);
    }
},1000);
    
function getNextStation(start, inout) {
    var x = Number(start);
    x += (inout == 1?1:-1);
    x = String(x);
    if(x.length == 3)
        x = "0"+x;
    return x;
}