import 'package:taggy/src/bridge_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';

typedef ExternalLibrary = WasmModule;

Taggy createWrapperImpl(ExternalLibrary module) => TaggyImpl.wasm(module);

WasmModule createLibraryImpl() {
  throw UnsupportedError('Web support is not provided yet.');
}
