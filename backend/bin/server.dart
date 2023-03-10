import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';

import 'package:mongo_dart/mongo_dart.dart';
import 'dart:io' show Platform;

// Configure routes.
final _router = Router()
  ..get('/', _rootHandler)
  ..post('/clients', _clientHandler);

Response _rootHandler(Request req) {
  return Response.ok('Backend!\n');
}

Response _clientHandler(Request request) {
  return Response.ok('$request\n');
}

void main(List<String> args) async {
  var db = await Db.create("mongodb://db/mydb");
  await db.open();

  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  final overrideHeaders = {
    ACCESS_CONTROL_ALLOW_ORIGIN: '*',
    'Content-Type': 'application/json;charset=utf-8'
  };

  // Configure a pipeline that logs requests.
  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(corsHeaders(headers: overrideHeaders))
      .addHandler(_router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '3000');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
