import 'dart:io';

// ignore: non_constant_identifier_names
var preview_server_port = 2227;

void main() async {
  bool working = false;
  var pubSpec = new File('pubspec.yaml');
  var pubLines = pubSpec.readAsLinesSync();
  var newLines = <String>[];
  var resource = <String>[];
  for (var line in pubLines) {
    if (line.contains('begin') && line.contains('#') && line.contains('assets')) {
      working = true;
      newLines.add(line);
    }
    if (line.contains('end') && line.contains('#') && line.contains('assets')) working = false;

    if (working) {
      if (line.trim().startsWith('#') && line.trim().endsWith('*')) {
        newLines.add(line);
        var directory = new Directory(line.replaceAll('#', '').replaceAll('*', '').trim());
        if (directory.existsSync()) {
          var list = directory.listSync(recursive: true);
          resource.add("/// 静态资源配置，程序自动生成，请勿手动修改");
          for (var file in list) {
            if (new File(file.path)
                .statSync()
                .type == FileSystemEntityType.file) {
              var path = file.path.replaceAll('\\', '/');
              var varName = path.replaceAll('/', '_').replaceAll('.', '_').toLowerCase();
              var pos = 0;
              String char;
              while (true) {
                pos = varName.indexOf('_', pos);
                if (pos == -1) break;
                char = varName.substring(pos + 1, pos + 2);
                varName = varName.replaceFirst('_$char', '_${char.toUpperCase()}');
                pos++;
              }
              varName = varName.replaceAll('_', '');
              resource.add("/// ![](http://127.0.0.1:$preview_server_port/$path)");
              resource.add("static final String $varName = '$path';");
              newLines.add('    - $path');
            }
          }
        } else {
          throw new FileSystemException('Directory wrong');
        }
      }
    } else {
      newLines.add(line);
    }
  }

  var r = new File('lib/R.dart');
  if (r.existsSync()) {
    r.deleteSync();
  }
  r.createSync();
  var content = 'class R {\n';
  for (var line in resource) {
    content = '$content  $line\n';
  }
  content = '$content}\n';
  r.writeAsStringSync(content);

  var spec = '';
  for (var line in newLines) {
    spec = '$spec$line\n';
  }
  pubSpec.writeAsStringSync(spec);

  var ser;
  try {
    ser = await HttpServer.bind('127.0.0.1', preview_server_port);
    print('成功启动图片预览服务器于本机<$preview_server_port>端口');
    ser.listen(
          (req) {
        var index = req.uri.path.lastIndexOf('.');
        var subType = req.uri.path.substring(index);
        req.response
          ..headers.contentType = new ContentType('image', subType)
          ..add(new File('.${req.uri.path}').readAsBytesSync())
          ..close();
      },
    );
  } catch (e) {
    print('图片预览服务器已启动或端口被占用');
  }
}