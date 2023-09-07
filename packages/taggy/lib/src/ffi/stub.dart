import 'package:taggy/src/bridge_generated.dart';

/// Represents the external library for taggy
///
/// Will be a DynamicLibrary for dart:io or WasmModule for dart:html
typedef ExternalLibrary = Object;

Taggy createWrapperImpl(ExternalLibrary lib) => throw UnimplementedError();

Object createLibraryImpl([String? libPath]) => throw UnimplementedError();
