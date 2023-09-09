import 'dart:ffi';
import 'dart:io';

import 'package:flutter_rust_bridge/flutter_rust_bridge.dart';
import 'package:taggy/taggy.dart';
import 'package:test/test.dart';

import 'utils.dart';

const fakePath = '/fakePath/to/file.txt';
const audioSampleFilePath = './test_samples/sample.mp3';
const notTagsAudioFilePath = './test_samples/no_tags.mp3';

void main() {
  setUpAll(() => Taggy.initializeFrom(_getTaggyDylib()));

  group(
    'Reading audio tags',
    () {
      test('it throws an exception for a non-existing file', () async {
        await expectLater(
          () async => await Taggy.readAll(fakePath),
          throwsA(isA<FfiException>()),
        );
      });
      test(
          'it returns a [TaggyFile] with no tags when [readPrimary] is called'
          ' for a file with no tags', () async {
        final taggy = await Taggy.readPrimary(notTagsAudioFilePath);
        expectLater(taggy.tags.isEmpty, true);
      });
      test(
          'it returns a [TaggyFile] with no tags when [readAll] is called'
          ' for a file with no tags', () async {
        final taggy = await Taggy.readAll(notTagsAudioFilePath);
        expectLater(taggy.tags.isEmpty, true);
      });
      test('it reads a file primary tag successfully', () async {
        final taggy = await Taggy.readPrimary(audioSampleFilePath);
        expectLater(taggy.tags.length, 1);
        expectLater(taggy.fileType, FileType.Mpeg);
      });
      test(
        'it reads multiple tags from file with many tags',
        () async {
          await _addTagToFile(audioSampleFilePath, TagType.Ape);
          final taggy = await Taggy.readAll(audioSampleFilePath);
          // it should have 2 tags, one by default and one we added.
          expectLater(taggy.tags.length, 2);
        },
      );
    },
  );
  group(
    'Writing tags',
    () {
      test('it throws an exception when writing to a non-existing file',
          () async {
        await expectLater(
          () async => await _addTagAsPrimaryToFile(fakePath),
          throwsA(isA<FfiException>()),
        );
      });
      test('the returned [TaggyFile] has the added tag', () async {
        await withDuplicatedFile(notTagsAudioFilePath, (path) async {
          final tag = _getTagInstance(TagType.FilePrimaryType);
          final taggyFile =
              await Taggy.writePrimary(path: path, tag: tag, keepOthers: false);
          expect(
            taggyFile.firstTagIfAny?.trackTitle,
            tag.trackTitle,
          );
        });
      });
      test('writing primary tag updates the file on disk', () async {
        await withDuplicatedFile(notTagsAudioFilePath, (path) async {
          final tag = await _addTagAsPrimaryToFile(path);
          // Read from disk after it's been added
          final taggyFile = await Taggy.readPrimary(path);
          expect(taggyFile.primaryTag?.trackTitle, tag.trackTitle);
        });
      });
      test(
        'writing multiple tags update the file on disk',
        () async {
          await withDuplicatedFile(notTagsAudioFilePath, (path) async {
            final tags = [
              _getTagInstance(TagType.Id3v2),
              _getTagInstance(TagType.Ape),
            ];
            // act
            await Taggy.writeAll(
                path: path, tags: tags, overrideExistent: true);
            // Read from disk after it's been written
            final taggyFile = await Taggy.readAll(path);
            expect(taggyFile.tags.length, 2);
          });
        },
      );
    },
  );
  group(
    'Removing Tags',
    () {
      test(
        'it throws an exception for a non-existing file',
        () async {
          await expectLater(
            () async => await Taggy.removeAll(fakePath),
            throwsA(isA<FfiException>()),
          );
        },
      );
      test(
        'it returns a [TaggyFile] with an empty tags list',
        () async {
          await withDuplicatedFile(audioSampleFilePath, (path) async {
            // act
            await Taggy.removeAll(path);
            // read the tags from original file again
            final taggyFile = await Taggy.readAll(path);
            // assert
            expect(taggyFile.tags.isEmpty, true);
          });
        },
      );
      test(
        'it removes all tags from a file with many tags',
        () async {
          await withDuplicatedFile(audioSampleFilePath, (path) async {
            // act
            await _addTagAsPrimaryToFile(path);
            // read the tags from original file again
            final taggyFile = await Taggy.readAll(path);
            // assert
            expect(taggyFile.tags.length, 2);
          });
        },
      );
    },
  );
}

Tag _getTagInstance(TagType tagType) {
  return Tag(
    tagType: tagType,
    album: 'Some Album',
    trackTitle: 'some Track',
    trackArtist: 'Some Artist',
    trackTotal: 10,
    trackNumber: 1,
    discNumber: 1,
    discTotal: 2,
    year: 2023,
    recordingDate: '1/3/2019',
    language: 'EN',
    pictures: [
      Picture(
        picData: Uint8List.fromList([0, 0, 0, 0]),
        mimeType: MimeType.Jpeg,
        picType: PictureType.CoverFront,
        width: 1000,
        height: 800,
      ),
    ],
  );
}

Future<Tag> _addTagAsPrimaryToFile(String path) async {
  return await _addTagToFile(path, TagType.FilePrimaryType);
}

Future<Tag> _addTagToFile(String path, TagType tagType) async {
  final tag = _getTagInstance(tagType);
  final taggyFile =
      await Taggy.writeAll(path: path, tags: [tag], overrideExistent: false);
  return taggyFile.tags
      .firstWhere((element) => element.trackTitle == tag.trackTitle);
}

/// Loads the external library from a local binary file.
///
/// Make sure you have run `cargo build` at least once.
DynamicLibrary _getTaggyDylib() {
  const libName = 'taggy';
  final libPrefix = {
    Platform.isWindows: '',
    Platform.isMacOS: 'lib',
    Platform.isLinux: 'lib',
  }[true]!;
  final libSuffix = {
    Platform.isWindows: 'dll',
    Platform.isMacOS: 'dylib',
    Platform.isLinux: 'so',
  }[true]!;
  final dylibPath = '../../target/debug/$libPrefix$libName.$libSuffix';
  return loadLibForDart(dylibPath);
}
