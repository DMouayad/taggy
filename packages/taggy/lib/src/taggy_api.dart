import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'package:taggy/src/ffi.dart';

import 'bridge_generated.dart' as bridge;

// ignore: non_constant_identifier_names
final Taggy = TaggyInterface._();

///
// This Provides a public API for Dart clients to call the platform-specific
// native library.
class TaggyInterface {
  late final bridge.Taggy _api;
  bool _initialized = false;

  TaggyInterface._();

  /// Initializes Taggy. **Must** be called before usage.
  ///
  /// You need to provide the dynamic [library] based on your OS.
  void initializeFrom(ExternalLibrary library) {
    if (_initialized) return;
    _api = createLib(library);
    _initialized = true;
  }

  /// Read all audio tags from the file at given [path].
  ///
  /// Throws an **exception** when:
  /// - path doesn't exists
  Future<bridge.TaggyFile> readAll(String path) async {
    return await _api.readAll(path: path);
  }

  /// Read only the primary audio tag from the file at given [path].
  ///
  /// If the primary tag does not exist,
  /// this will return a [TaggyFile] with no tags.
  ///
  /// Throws an **exception** when:
  /// - path doesn't exists
  /// ```
  Future<bridge.TaggyFile> readPrimary(String path) async {
    return await _api.readPrimary(path: path);
  }

  /// Read any audio tag from the file at the given [path].
  ///
  /// If the file has no tags,
  /// this will return a [TaggyFile] with an empty tags.
  ///
  /// Throws an **exception** when:
  /// - path doesn't exists
  /// ```
  Future<bridge.TaggyFile> readAny(String path) async {
    return await _api.readAny(path: path);
  }

  /// Write all provided `tags` to the file at given [path].
  ///
  /// when `override_existent` is set to `true`, this will remove all existing tags.
  /// Otherwise, it will add or update any existing ones.
  ///
  /// Throws an **exception** when:
  /// - path doesn't exists
  Future<bridge.TaggyFile> writeAll({
    required String path,
    required List<bridge.Tag> tags,
    required bool overrideExistent,
  }) async {
    return await _api.writeAll(
        path: path, tags: tags, overrideExistent: overrideExistent);
  }

  /// Write the provided `tag` as the primary tag for the file at given [path].
  ///
  /// If [keepOthers] is set to `false`, this will remove any existing tags from the file.
  ///
  ///
  /// *Note:* the [tag.tagType] of the given [tag] will be overridden
  /// with the primary type of the file, so you can set it to any or use
  /// [bridge.TagType.FilePrimaryType]
  ///
  /// Throws an **exception** when:
  /// - path doesn't exists
  Future<bridge.TaggyFile> writePrimary({
    required String path,
    required bridge.Tag tag,
    required bool keepOthers,
  }) async {
    return await _api.writePrimary(
        path: path, tag: tag, keepOthers: keepOthers);
  }

  /// Delete all tags from file at given [path]
  ///
  /// Throws an **exception** when:
  /// - path doesn't exists
  Future<void> removeAll(String path) async {
    return await _api.removeAll(path: path);
  }

  /// Delete the provided [tag] from file at the given `path`.
  ///
  /// If the [tag] doesn't exist, **no** errors will be returned.
  ///
  /// Throws an **exception** when:
  /// - path doesn't exists
  Future<void> removeTag(
      {required String path, required bridge.Tag tag}) async {
    return await _api.removeTag(path: path, tag: tag);
  }
}
