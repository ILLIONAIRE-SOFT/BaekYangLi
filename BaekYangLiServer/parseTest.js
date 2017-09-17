var request = require('sync-request');

var htmlparser = require('htmlparser2');
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
        console.log(name, attribs);
    },
    ontext: function(text){
        console.log(text);
    },
    onclosetag: function(tagname){
        console.log(tagname);
    }
}, {decodeEntities: true});
parser.write(data);
parser.end();

res.send(infos);