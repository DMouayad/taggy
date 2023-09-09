import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'package:taggy/src/ffi.dart';

import 'bridge_generated.dart' as bridge;

// This Provides a public API for Dart clients to call native library through
// ffi.
// ignore: non_constant_identifier_names
final Taggy = TaggyInterface._();

class TaggyInterface {
  TaggyInterface._();

  bridge.Taggy? _api;

  bridge.Taggy _getApi() {
    if (_api == null) {
      throw StateError(
        'Taggy has not been initialized!\n'
        'Help: call Taggy.initialize() in your main function',
      );
    }
    return _api!;
  }

  /// Initializes Taggy. **Must** be called before usage.
  ///
  /// You need to provide the dynamic [library] based on your OS.
  void initializeFrom(ExternalLibrary library) {
    _api ??= createLib(library);
  }

  /// Read all audio tags from the file at given [path].
  ///
  /// Throws an **exception** when:
  /// - path doesn't exists
  Future<bridge.TaggyFile> readAll(String path) async {
    return await _getApi().readAll(path: path);
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
    return await _getApi().readPrimary(path: path);
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
    return await _getApi().readAny(path: path);
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
    return await _getApi()
        .writeAll(path: path, tags: tags, overrideExistent: overrideExistent);
  }

  /// Write the provided `tag` as the primary tag for the file at given [path].
  ///
  /// If [keepOthers] is set to `false`, this will remove any existing tags from the file.
  ///
  ///
  /// *Note:* the [tag.tagType] of the given [tag] will be overridden
  /// with the primary type of the file, so you can set it to any or use
  /// [TagType.FilePrimaryType]
  ///
  /// Throws an **exception** when:
  /// - path doesn't exists
  Future<bridge.TaggyFile> writePrimary({
    required String path,
    required bridge.Tag tag,
    required bool keepOthers,
  }) async {
    return await _getApi()
        .writePrimary(path: path, tag: tag, keepOthers: keepOthers);
  }

  /// Delete all tags from file at given [path]
  ///
  /// Throws an **exception** when:
  /// - path doesn't exists
  Future<void> removeAll(String path) async {
    return await _getApi().removeAll(path: path);
  }

  /// Deletes the tag with [TagType] equals to [tagType] from file at the given [path].
  ///
  /// If the file doesn't have any tag with the given [tagType],
  /// **no** errors will be returned.
  ///
  /// Throws an **exception** when:
  /// - path doesn't exists
  Future<void> removeTag({
    required String path,
    required bridge.TagType tagType,
  }) async {
    return await _getApi().removeTag(path: path, tagType: tagType);
  }
}
