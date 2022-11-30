import 'dart:io';

import 'gen_export.dart';

Future<void> main(List<String> args) async {
  if (args.contains('update')) {
    Process.runSync('dart', ['pub', 'global', 'deactivate', 'gen_export']);
    Process.runSync('dart', ['pub', 'global', 'activate', 'gen_export']);
    return;
  }

  var watch = args.contains('watch');
  generateExport(
    libDir,
    fileName: packageName,
    ext: '',
  );

  if (watch) {
    final stream = libDir.watch(
      recursive: true,
    );

    final sub = stream.listen((event) {
      if (event.isDirectory) {
        final dir = Directory(event.path);
        generateExport(dir);
      } else {
        final file = File(event.path);
        final dir = file.parent;
        generateExport(dir);
      }
    });

    await stream.join();
    await sub.cancel();
  }
}
