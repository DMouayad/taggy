import 'dart:io';
import 'dart:math';

import 'package:path/path.dart' as p;

/// Creates a copy of the file at given [filePath] with a random name.
String _duplicateFile(String filePath) {
  final fileToClone = File(filePath);
  if (fileToClone.existsSync()) {
    final randomNum = Random.secure().nextInt(100);

    final cloneFileName = 'copy_${randomNum}_${p.basename(filePath)}';
    final clonedFilePath = '${p.dirname(filePath)}/$cloneFileName';

    fileToClone.copySync(clonedFilePath);

    return clonedFilePath;
  }
  throw Exception("file at path '$filePath' not found!");
}

/// Provides a convenient way to clone a file and use in some [operation] then
/// automatically remove it when its done.
Future<void> withDuplicatedFile(
  String fileToDuplicate,
  Future<void> Function(String path) operation,
) async {
  final String path = _duplicateFile(fileToDuplicate);
  try {
    await operation(path);
  } catch (e) {
    // clean up the duplicated file then re-throw the exception
    File(path).deleteSync();
    rethrow;
  }
  // clean up the duplicated file also when no error occurs.
  File(path).deleteSync();
}
