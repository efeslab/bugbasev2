console.log('server start');

var webSocket = require('ws');
var webSocketServer = new webSocket.Server({port: 8010});

webSocketServer.on('connection', function(ws) {
    console.log('connection');
    ws.send('refused');
    ws.terminate();
});
