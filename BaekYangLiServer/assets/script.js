var x = document.getElementsByTagName("circle");
var svg = d3.select("body").select("svg#map");

function findStationCircle(num) {
    return x["M"+num];
}

function findPath(start, dest) {
    console.log(start+" "+dest);
    return d3.selectAll(".P"+start+dest);
}

function addTrain(start, dest, duration, percentage) {
    var marker = svg.append("rect");
    var reverse =  start > dest ? 1 : 0;
    var path = findPath(start,dest);
    var startPoint = pathStartPoint(path);
    var color = findStationCircle(start).getAttribute("stroke");
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
        .attrTween("transform", translateAlong(path.node(),reverse));
}
  
function translateAlong(path, reverse) {
    var l = path.getTotalLength();
    return function(i) {
      return function(t) {
        var p = path.getPointAtLength(reverse == 1 ? l - t * l : t * l);
        return "translate(" + (p.x-5) + "," + (p.y-5) + ")";//Move marker
      }
    }
}