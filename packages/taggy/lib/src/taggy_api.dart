import 'package:taggy/src/ffi.dart';

import 'bridge_generated.dart' as bridge;

abstract class Taggy {
  static final bridge.Taggy _api = createLib();
}
