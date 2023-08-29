// AUTO GENERATED FILE, DO NOT EDIT.
// Generated by `flutter_rust_bridge`@ 1.81.0.
// ignore_for_file: non_constant_identifier_names, unused_element, duplicate_ignore, directives_ordering, curly_braces_in_flow_control_structures, unnecessary_lambdas, slash_for_doc_comments, prefer_const_literals_to_create_immutables, implicit_dynamic_list_literal, duplicate_import, unused_import, unnecessary_import, prefer_single_quotes, prefer_const_constructors, use_super_parameters, always_use_package_imports, annotate_overrides, invalid_use_of_protected_member, constant_identifier_names, invalid_use_of_internal_member, prefer_is_empty, unnecessary_const

import 'dart:convert';
import 'dart:async';
import 'package:meta/meta.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'package:uuid/uuid.dart';
import 'bridge_generated.dart';
export 'bridge_generated.dart';

class TaggyPlatform extends FlutterRustBridgeBase<TaggyWire> with FlutterRustBridgeSetupMixin {
  TaggyPlatform(FutureOr<WasmModule> dylib) : super(TaggyWire(dylib)) {
    setupMixinConstructor();
  }
  Future<void> setup() => inner.init;

// Section: api2wire

  @protected
  String api2wire_String(String raw) {
    return raw;
  }

  @protected
  int api2wire_box_autoadd_mime_type(MimeType raw) {
    return api2wire_mime_type(raw);
  }

  @protected
  int api2wire_box_autoadd_tag_type(TagType raw) {
    return api2wire_tag_type(raw);
  }

  @protected
  int api2wire_box_autoadd_u32(int raw) {
    return api2wire_u32(raw);
  }

  @protected
  List<dynamic> api2wire_list_picture(List<Picture> raw) {
    return raw.map(api2wire_picture).toList();
  }

  @protected
  List<dynamic> api2wire_list_tag(List<Tag> raw) {
    return raw.map(api2wire_tag).toList();
  }

  @protected
  String? api2wire_opt_String(String? raw) {
    return raw == null ? null : api2wire_String(raw);
  }

  @protected
  int? api2wire_opt_box_autoadd_mime_type(MimeType? raw) {
    return raw == null ? null : api2wire_box_autoadd_mime_type(raw);
  }

  @protected
  int? api2wire_opt_box_autoadd_tag_type(TagType? raw) {
    return raw == null ? null : api2wire_box_autoadd_tag_type(raw);
  }

  @protected
  int? api2wire_opt_box_autoadd_u32(int? raw) {
    return raw == null ? null : api2wire_box_autoadd_u32(raw);
  }

  @protected
  List<dynamic> api2wire_picture(Picture raw) {
    return [
      api2wire_picture_type(raw.picType),
      api2wire_opt_box_autoadd_mime_type(raw.mimeType),
      api2wire_opt_box_autoadd_u32(raw.width),
      api2wire_opt_box_autoadd_u32(raw.height),
      api2wire_opt_box_autoadd_u32(raw.colorDepth),
      api2wire_opt_box_autoadd_u32(raw.numColors)
    ];
  }

  @protected
  List<dynamic> api2wire_tag(Tag raw) {
    return [
      api2wire_opt_box_autoadd_tag_type(raw.tagType),
      api2wire_list_picture(raw.pictures),
      api2wire_opt_String(raw.trackTitle),
      api2wire_opt_String(raw.trackArtist),
      api2wire_opt_String(raw.album),
      api2wire_opt_String(raw.albumArtist),
      api2wire_opt_String(raw.producer),
      api2wire_opt_box_autoadd_u32(raw.trackNumber),
      api2wire_opt_box_autoadd_u32(raw.trackTotal),
      api2wire_opt_box_autoadd_u32(raw.diskNumber),
      api2wire_opt_box_autoadd_u32(raw.diskTotal),
      api2wire_opt_box_autoadd_u32(raw.year),
      api2wire_opt_String(raw.recordingDate),
      api2wire_opt_String(raw.originalReleaseDate),
      api2wire_opt_String(raw.language),
      api2wire_opt_String(raw.lyrics),
      api2wire_opt_String(raw.genre)
    ];
  }

  @protected
  Uint8List api2wire_uint_8_list(Uint8List raw) {
    return raw;
  }
// Section: finalizer
}

// Section: WASM wire module

@JS('wasm_bindgen')
external TaggyWasmModule get wasmModule;

@JS()
@anonymous
class TaggyWasmModule implements WasmModule {
  external Object /* Promise */ call([String? moduleName]);
  external TaggyWasmModule bind(dynamic thisArg, String moduleName);
  external dynamic /* void */ wire_read_from_path(NativePortType port_, String path);

  external dynamic /* void */ wire_write_all(NativePortType port_, String path, List<dynamic> tags, bool should_override);
}

// Section: WASM wire connector

class TaggyWire extends FlutterRustBridgeWasmWireBase<TaggyWasmModule> {
  TaggyWire(FutureOr<WasmModule> module) : super(WasmModule.cast<TaggyWasmModule>(module));

  void wire_read_from_path(NativePortType port_, String path) => wasmModule.wire_read_from_path(port_, path);

  void wire_write_all(NativePortType port_, String path, List<dynamic> tags, bool should_override) => wasmModule.wire_write_all(port_, path, tags, should_override);
}
