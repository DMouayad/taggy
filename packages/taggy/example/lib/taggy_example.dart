import 'dart:io';

import 'package:taggy/taggy.dart';
import 'package:path/path.dart' as p;

Future<void> main(List<String> args) async {
  // init Taggy
  // NOTE: if you you're running this locally, you need to run the `cargo build`
  // command so it generates the binary files
  Taggy.initializeFrom(getTaggyDylibFromDirectory('../../target/debug'));

  await readAllTags();

  await writeTag();
}

Future<void> writeTag() async {
  final tag = Tag(
    tagType: TagType.FilePrimaryType,
    trackTitle: 'Track Title',
    trackArtist: 'Track Artist',
    trackTotal: 10,
    trackNumber: 1,
    discNumber: 1,
    discTotal: 2,
    year: 2023,
    recordingDate: '1/3/2019',
    language: 'EN',
    pictures: [
      Picture(
        picData: File(_getImagePath()).readAsBytesSync(),
        mimeType: MimeType.Jpeg,
        picType: PictureType.CoverFront,
        width: 1000,
        height: 800,
      ),
    ],
  );
  final taggyFile = await Taggy.writePrimary(
    path: _getAudioSamplePath(),
    tag: tag,
    keepOthers: false,
  );
  assert(taggyFile.primaryTag?.trackTitle == tag.trackTitle);
  print('Tag was written successfully');
}

Future<void> readAllTags() async {
  final taggyFile = await Taggy.readAll(_getAudioSamplePath());
  // use `taggyFile` as you wish
  final audioInfo = taggyFile.audio;
  final tags = taggyFile.tags;
  final trackDuration = taggyFile.duration;
  final fileType = taggyFile.fileType;
  final size = taggyFile.sizeInMB;
  print('audioInfo: $audioInfo');
  print('tags: $tags');
  print('fileType: $fileType');
  print('trackDuration: $trackDuration');
  print('size: $size');
}

/**
 * Helper functions
 */

/// Returns the path to an audio file
String _getAudioSamplePath() => p.join(_getAssetsDirPath(), 'sample.mp3');

String _getImagePath() => p.join(_getAssetsDirPath(), 'image.jpg');

String _getAssetsDirPath() {
  final dir = File(p.current).parent.absolute;
  final sep = p.separator;
  return p.join(dir.path, 'taggy${sep}example${sep}assets');
}
