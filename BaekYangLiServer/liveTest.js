var svg = d3.select("body").select("svg#map");
var path = svg.select("path#path2");
var startPoint = pathStartPoint(path);
//Get path start point for placing marker
function pathStartPoint(path) {
    var d = path.attr("d"),
    dsplitted = d.split(" ");
    return dsplitted[1].split(",");
  }
  
  function transition() {
    marker.transition()
        .duration(10000)
        .attrTween("transform", translateAlong(path.node(),0))
        .each("end", transition);// infinite loop
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


var marker = svg.append("rect");
marker.attr("width", 10).attr("height",10)
  .attr("transform", "translate(" + startPoint + ")").attr("fill","#038fa0");

transition();
