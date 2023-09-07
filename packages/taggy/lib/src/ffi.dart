import 'bridge_generated.dart';
import 'ffi/stub.dart'
    if (dart.library.io) 'ffi/io.dart'
    if (dart.library.html) 'ffi/web.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart'
    show loadLibForDart;

Taggy? _wrapper;

Taggy createWrapper(ExternalLibrary lib) {
  _wrapper ??= createWrapperImpl(lib);
  return _wrapper!;
}

Taggy createLib([String? libPath]) {
  return createWrapper(createLibraryImpl(libPath));
}
