import 'package:taggy/taggy.dart';
import 'ffi/stub.dart'
    if (dart.library.io) 'ffi/io.dart'
    if (dart.library.html) 'ffi/web.dart';

extension FlutterTaggyExtension on TaggyInterface {
  /// Initializes the library in a Flutter app.
  /// **Must** be called before using this package.
  ///
  /// Note: an internet connection is required, the first time only,
  /// to download the required binaries from the internet.
  void initialize() {
    initializeFrom(createLibraryImpl());
  }
}
