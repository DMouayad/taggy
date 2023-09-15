<div align="center">

<a href="https://pub.dartlang.org/packages/taggy"><img alt="taggy" src="https://img.shields.io/pub/v/taggy"></a>
<a href="https://github.com/DMouayad/taggy/releases"><img src="https://img.shields.io/github/v/release/DMouayad/taggy?style=flat-square&color=blue" alt="Release"></a>
<a href="https://github.com/DMouayad/taggy/actions"><img src="https://img.shields.io/github/actions/workflow/status/DMouayad/taggy/.github%2Fworkflows%2Fbuild.yaml" alt="Build Status"></a>
<a href="https://github.com/DMouayad/taggy"><img src="https://img.shields.io/github/stars/DMouayad/taggy.svg?style=flat&logo=github&colorB=deeppink&label=stars" alt="Github Stars"></a>
<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-purple.svg" alt="MIT License"></a>
</div>

![taggy cover image](readme-assets/Taggy%20cover.png)

Provides a simple API for reading, writing and converting audio tags.

## Features

- 📖 [Reading audio tags metadata from file](#reading-tags).
- 📝 [Writing audio tags](#writing-tags).
- ✂  [Removing audio tags](#removing-tags).
- 🎶 Supports a variety of [file formats](https://github.com/Serial-ATA/lofty-rs/blob/main/SUPPORTED_FORMATS.md):
  MP3, MP4, FLAC, and more.

### Planned features ⏳

- Batches: write to multiple files at the same time.
- Editing file name: add the option to rename a file based on its track title.
- TaggyFileResult: all public APIs should return a universal result:

  It will contain a value of `TaggyFile` type or a `TaggyError`.

## Getting started

- Install & Setup the package.
- Read the [Usage](#usage) section to explore Taggy's features.
- For more details: check out the [example app](example/README.md).

## Installation

Run the following command:

  ```bash
    dart pub add taggy
  ```

## Usage

### Initialization

It can be done in two ways:

-  First method:

      ```dart
      import 'package:taggy/taggy.dart';
      
      void main(){
        Taggy.initializeFrom(DynamicLibrary.open('path/to/library.dll'));
      }
      ```

- Second method:

  ```dart
    import 'package:taggy/taggy.dart';
  
    // call this helper function which takes care of loading the library for you.
    Taggy.initializeFrom(getTaggyDylibFromDirectory('path/of/binaries/directory'));
    ```

### About the `TaggyFile` type

- It gives us a little more information about the file(s) we're reading from or writing to, so alongside the list of `Tag`,
  we get:
    - the file size (in bytes).
    - a `FileType`: whether it's (flac, wav, mpeg, etc).
    - an `AudioInfo`, which is another type, holds the properties of the audio track.
- you can pretty-print a `TaggyFile` instance by calling `formatAsAString()`:

  <details>
  <summary>output example</summary>

  ```
  TaggyFile: {
      size: 12494053 bytes ~ 12.2 MB,
      fileType: FileType.Mpeg
      primaryTagType: TagType.Id3v2,
      tags: {
      count: 1,
      items: 
        [ Tag(
              tagType: Id3v2,
              trackTitle: Fine Line,
              trackArtist: Eminem,
              trackNumber: 9,
              trackTotal: 1,
              discTotal: null,
              discNumber: null,
              album: SHADYXV,
              albumArtist: Various Artists,
              genre: null,
              language: null,
              year: null,
              recordingDate: null,
              originalReleaseDate: null,
              has lyrics: true,
              pictures: {
                count: 1,
                items: [ Picture(
                  picType: PictureType.CoverFront,
                  picData(Bytes): 168312,
                  mimeType: MimeType.Jpeg,
                  width: 1000,
                  height: 1000,
                  colorDepth: 24,
                  numColors: 0,
                  )],
              },
            ),
        ],
      },
      audio: AudioInfo(
      channelMask: 3,
      channels: 2,
      sampleRate: 44100,
      audioBitrate: 321,
      overallBitrate: 326,
      bitDepth: null,
      durationSec: 306,
      ),
  }
  ```

</details>

### Reading tags

- **Reading all tags:**

    ```dart
    const path = 'path/to/audio/file.mp3';

    final TaggyFile taggyFile = await Taggy.readAll(path);
    // you can use the getter which, under the hood, is [taggyFile.tags.firstOrNull]
    print(taggyFile.firstTagIfAny);
  
    // or easily access all returned tags
    for (var tag in taggyFile.tags) {
      print(tag.tagType);
    }
    ```

- **Reading primary tag:**

    ```dart
    final path = 'path/to/audio/file.mp3';
    final TaggyFile taggyFile = await Taggy.readPrimary(path);
    ```


- **Reading any tag:**

  It's similar to `readPrimary` except that the returned `TaggyFile.tags` might be empty.

    ```dart
    const path = 'path/to/audio/file.mp3';
    final TaggyFile taggyFile = await Taggy.readyAny(path);
  
    // you can also use [formatAsString], we still get a [TaggyFile].
    print(taggyFile.formatAsString());
  
    // you may want to check if it has any tags
    final hasTags = taggyFile.tags.isNotEmpty();
    // Or use the getter
    final Tag? tag = taggyFile.firstTagIfAny;
    ```

### Writing tags:

- **About specifying the `TagType`**

  A tag type is required for creating a new `Tag` instance.
  You can:

    -  check what `TagType` the file supports based on its type(extension). see this [table](https://github.com/Serial-ATA/lofty-rs/blob/main/SUPPORTED_FORMATS.md).

    -  Use the function `Taggy.writePrimary()`
       and pass it a `Tag` with a type of `TagType.FilePrimaryType`, as shown in example below.


- <details> 

    <summary>Example of creating a new Tag</summary>

    ```dart
    Tag getTagInstance(TagType tagType){
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
            // zeros are used to demonstrate how to provide a picture's data.
            picData: Uint8List.fromList([0, 0, 0, 0]),
            mimeType: MimeType.Jpeg,
            picType: PictureType.CoverFront,
            width: 1000,
            height: 800,
          ),
        ],
      );
    }
    ```

</details>

- **Writing primary tag:**

  ```dart
  final path = 'path/to/audio/file.mp3';
  // unfold the [creating a new Tag] section above to find [getTagInstance]
  final tagToWrite = getTagInstance(TagType.FilePrimaryType);

  final TaggyFile taggyFile = await Taggy.writePrimary(
    path: path, tag: tagToWrite, keepOthers: false);

  // On Success, [taggyFile.tags] will contain the newly added tag.
  // NOTE: this tag may not contain the same properties of [tagToWrite].
  final pTag = taggyFile.primaryTag;
  ```

- **Writing multiple tags**:

  In most use-cases, you'll use `Taggy.writePrimary()` to add/edit an audio tag metadata,
  but you can also provide multiple tags to be written to the same file.

  ```dart
  final path = 'path/to/audio/file.mp3';
  // In the same way as the previous example,
  // create a list of [Tag] instances.
  final tags = [
    getTagInstance(TagType.FilePrimaryType),
    getTagInstance(TagType.Id3v1),
  ];
      
  final TaggyFile taggyFile = await Taggy.writeAll(
    path: path, tag: tagToWrite, overrideExistent: true);
  ```

### Removing tags:

- **Remove a specific Tag**:

  You can delete a tag from file by specifying this tag type.

    ```dart
    final path = 'path/to/audio/file.mp3';
    // The type of to-remove-tag
    final tagType = TagType.Ape;
    final TaggyFile taggyFile = await Taggy.removeTag(path: path, tagType: tagType);
    ``` 

- **Remove all tags**:

  ```dart
  final path = 'path/to/audio/file.mp3';
  final TaggyFile taggyFile = await Taggy.removeAll(path: path);
  
  print(taggyFile.tags);
  // output
  // []
  ``` 

## Feed back & Contributions

- 🐛 Found an issue or encountered a bug? please check the existing [issues](https://github.com/DMouayad/taggy/issues) or create a new one.


- 💪🏻 Want to contribute? Thank you, its always welcomed!. You can start by reading
  the [Contributing](CONTRIBUTING.md) guide.


- 🙏🏻 You can also contribute if you ⭐ this repository and 👍🏻 the [package](https://pub.dev/packages/taggy) on `Pub.dev`, we do appreciate your love.

## Acknowledgement

- [**lofty**](https://github.com/Serial-ATA/lofty-rs/): a Rust library which provides `Taggy` with its functionality.

- [**Flutter Rust Bridge**](https://github.com/fzyzcjy/flutter_rust_bridge): connects `Rust` APIs with Dart & Flutter.