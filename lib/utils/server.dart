import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:mime/mime.dart';

class Server {
  HttpServer? _server;

  int _port = 12121;

  Server({int port = 12121}) {
    _port = port;
  }

  // Closes the server.
  Future<void> close() async {
    if (_server != null) {
      await _server!.close(force: true);
      if (kDebugMode) {
        print('Server running on http://localhost:$_port closed');
      }
      _server = null;
    }
  }

  Future<void> start() async {
    if (_server != null) {
      throw Exception('Server already started on http://localhost:$_port');
    }

    var completer = Completer();
    runZoned(() {
      HttpServer.bind('0.0.0.0', _port, shared: true).then((server) {
        if (kDebugMode) {
          print('Server running on http://localhost:$_port');
        }

        _server = server;

        server.listen((HttpRequest request) async {
          List<int> body = [];
          var path = request.requestedUri.path;
          if (kDebugMode) {
            print("path = $path");
          }
          path = (path.startsWith('/')) ? path.substring(1) : path;
          path += (path.endsWith('/')) ? 'index.html' : '';

          try {
            body = (await rootBundle.load(path)).buffer.asUint8List();
          } catch (e) {
            if (kDebugMode) {
              print(e.toString());
            }
            request.response.close();
            return;
          }

          var contentType = ['text', 'html'];
          // print("Extension= ${path.substring(path.lastIndexOf('.') + 1)}");
          // if (path.substring(path.lastIndexOf('.') + 1) != "html") {
          //   contentType = ['text', 'plain'];
          // }
          if (!request.requestedUri.path.endsWith('/') &&
              request.requestedUri.pathSegments.isNotEmpty) {
            var mimeType =
                lookupMimeType(request.requestedUri.path, headerBytes: body);
            if (mimeType != null) {
              contentType = mimeType.split('/');
            }
          }

          request.response.headers.contentType =
              ContentType(contentType[0], contentType[1], charset: 'utf-8');
          request.response.add(body);
          request.response.close();
        });

        completer.complete();
      });
    }, onError: (e, stackTrace) => print('Error: $e $stackTrace'));

    return completer.future;
  }
}
