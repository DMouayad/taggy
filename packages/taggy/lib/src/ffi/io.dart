import 'dart:ffi';

import 'package:taggy/src/bridge_generated.dart';

typedef ExternalLibrary = DynamicLibrary;

Taggy createWrapperImpl(ExternalLibrary dylib) =>
    TaggyImpl(dylib);
