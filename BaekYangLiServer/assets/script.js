var x = document.getElementsByTagName("circle");

function findStationCircle(num) {
    return x["M"+num];
}

function findPath(start, dest) {
    return document.getElementsByClassName("P"+start+dest)[0];
}
