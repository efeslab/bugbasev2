<?php
/**
 * @author Nate Good <me@nategood.com>
 * Trivial script that works as an endpoint for
 * GET, PUT, POST, and DELETE methods. 
 * 
 * Try it out from cURL:
 * 
 * `curl -X GET http://localhost/trivial.php`
 * `curl -X PUT http://localhost/trivial.php`
 * `curl -X POST http://localhost/trivial.php`
 * `curl -X DELETE http://localhost/trivial.php`
 */

require('../Restquest.class.php');

$request = new Restquest;

switch ($request->method) {
    case Http::GET:
        $response = 'GET-ing the resource identified by ' . $request->uri;
        break;
    case Http::PUT:
        $response = 'PUT-ing the resource identified by ' . $request->uri . 
            ' with the body: ' . $request->body . ' parsed as ' . var_export($request->data, true);
        break;
    case Http::POST:
        $response = 'POST-ing to the resource identified by ' . $request->uri . 
            ' with the body: ' . $request->body . ' parsed as ' . var_export($request->data, true);
        break;
    case Http::DELETE:
        $response = 'DELETE-ing the resource identified by ' . $request->uri;
        break;
}

// Output
header('Content-Type: text/plain');
echo $response;