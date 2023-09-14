import 'package:taggy/taggy.dart';
import 'ffi/stub.dart'
    if (dart.library.io) 'ffi/io.dart'
    if (dart.library.html) 'ffi/web.dart';

extension FlutterTaggyExtension on TaggyInterface {
  void initialize() {
    initializeFrom(createLibraryImpl());
  }
}
