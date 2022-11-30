import 'dart:io';

import 'package:yaml/yaml.dart';

final libDir = Directory('lib');
final String packageName = getPackageName();

final _templateHeader = '''
// This file is automatically generated by tools.
// To update all exports inside project
// run :
// genexp

''';

String getPackageName() {
  final file = File('pubspec.yaml');
  if (!file.existsSync()) {
    throw Exception('pubspec.yaml file not found');
  }

  final content = file.readAsStringSync();
  var doc = loadYaml(content);
  return doc['name'];
}

bool generateExport(
  Directory directory, {
  String? fileName,
  String ext = '.exports',
  bool recursive = true,
}) {
  print('[GEN] Library: ${directory.path}');
  final items = directory.listSync();
  items.sort((a, b) => a.path.compareTo(b.path));

  final directoryName = fileName ??
      directory.absolute.path.substring(
        directory.absolute.path.lastIndexOf('\\') + 1,
      );

  final exportFile = File('${directory.absolute.path}/$directoryName$ext.dart');

  var exports = '';
  for (var item in items) {
    if (item is Directory && recursive) {
      final res = generateExport(item);
      if (!res) continue;

      final subDirName = item.absolute.path.substring(
        item.absolute.path.lastIndexOf('\\') + 1,
      );

      exports += "export '$subDirName/$subDirName.exports.dart';\n";
      continue;
    }

    if (item is File &&
        item.path.toLowerCase().endsWith('.dart') &&
        !item.path.toLowerCase().endsWith('generated_plugin_registrant.dart') &&
        !item.path.toLowerCase().endsWith('.g.dart')) {
      if (item.absolute.path == exportFile.absolute.path) continue;

      fixImport(item);
      final path =
          item.absolute.path.substring(directory.absolute.path.length + 1);
      exports += "export '$path';\n";
      continue;
    }
  }

  if (exports.isNotEmpty) {
    final content = '$_templateHeader$exports';

    exportFile.writeAsStringSync(content, flush: true);
    return true;
  }

  return false;
}

void fixImport(File file) {
  print('[GEN] Fix Imports: ${file.path}');
  final xcontent = file.readAsStringSync();
  if (xcontent.contains('package:$packageName/$packageName.dart')) {
    return;
  }

  final lines = file.readAsLinesSync();
  var content = '';
  var hasImport = false;

  for (final line in lines) {
    if (!line.trim().startsWith('//') &&
        line.contains('package:$packageName')) {
      hasImport = true;
    } else {
      content += line + '\n';
    }
  }

  if (hasImport) {
    content = "import 'package:$packageName/$packageName.dart';\n$content";
  }

  file.writeAsStringSync(content, flush: true);
}
