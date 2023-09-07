import 'dart:ffi';
import 'dart:io';

import 'package:taggy/src/bridge_generated.dart';

typedef ExternalLibrary = DynamicLibrary;

Taggy createWrapperImpl(ExternalLibrary dylib) =>
    TaggyImpl(dylib);

DynamicLibrary createLibraryImpl([String? dllPath]) {
  const base = 'taggy';

  if (Platform.isIOS || Platform.isMacOS) {
    return DynamicLibrary.executable();
  } else if (Platform.isWindows) {
    return DynamicLibrary.open(dllPath ?? '$base.dll');
  } else {
    return DynamicLibrary.open(dllPath ?? 'lib$base.so');
  }
}