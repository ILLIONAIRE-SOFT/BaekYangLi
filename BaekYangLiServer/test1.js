var lines = document.getElementsByClassName("line");
var colors = new Object();
for(var i = 0; i < lines.length; i++) {
    var color = lines[i].getAttribute("stroke");
    var paths = lines[i].getElementsByClassName("path");
    var line = paths[0].getAttribute("class").split(" ")[1];
    console.log(color+" "+line);
}