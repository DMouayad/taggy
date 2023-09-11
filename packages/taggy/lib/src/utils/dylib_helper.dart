import 'dart:ffi';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';

/// Loads the external library from a local binary file.
///
/// Note: This only works in Dart applications.
DynamicLibrary getTaggyDylibFromDirectory(String dir) {
  const libName = 'taggy';
  final libPrefix = {
    Platform.isWindows: '',
    Platform.isMacOS: 'lib',
    Platform.isLinux: 'lib',
  }[true]!;
  final libSuffix = {
    Platform.isWindows: 'dll',
    Platform.isMacOS: 'dylib',
    Platform.isLinux: 'so',
  }[true]!;
  final dylibPath = '$dir${p.separator}$libPrefix$libName.$libSuffix';
  return loadLibForDart(dylibPath);
}
