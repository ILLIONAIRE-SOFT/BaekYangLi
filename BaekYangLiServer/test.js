var x = document.getElementsByTagName("circle");

function findStationCircle(num) {
    return x["M"+num];
}

function findPath(start, dest) {
    return d3.selectAll(".P"+start+dest);
}