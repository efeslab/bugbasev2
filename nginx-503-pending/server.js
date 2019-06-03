console.log('server start');

var webSocket = require('ws');
var webSocketServer = new webSocket.Server({
    port: 8010,
    verifyClient: function (info, cb) {
        cb(false, 401, 'unauthorized');
    },
});

webSocketServer.on('connection', function(ws) {
    console.log('connection');
    //ws.terminate();
});
