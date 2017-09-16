var svg = d3.select("body").select("svg#map");
var path = svg.select("path#path");
var startPoint = pathStartPoint(path);
//Get path start point for placing marker
function pathStartPoint(path) {
    var d = path.attr("d"),
    dsplitted = d.split(" ");
    return dsplitted[1].split(",");
  }
  
  function transition() {
    marker.transition()
        .duration(7500)
        .attrTween("transform", translateAlong(path.node()))
        .each("end", transition);// infinite loop
  }
  
  function translateAlong(path) {
    var l = path.getTotalLength();
    return function(i) {
      return function(t) {
        var p = path.getPointAtLength(t * l);
        return "translate(" + p.x + "," + p.y + ")";//Move marker
      }
    }
  }


var marker = svg.append("circle");
marker.attr("r", 7)
  .attr("transform", "translate(" + startPoint + ")");

transition();
