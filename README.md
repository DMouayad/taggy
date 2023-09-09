<p align="center">


<a href="https://github.com/DMouayad/taggy/actions"><img src="https://img.shields.io/github/actions/workflow/status/DMouayad/taggy/.github%2Fworkflows%2Fbuild.yaml" alt="Build Status"></a>
<a href="https://github.com/DMouayad/taggy"><img src="https://img.shields.io/github/stars/DMouayad/taggy.svg?style=flat&logo=github&colorB=deeppink&label=stars" alt="Github Stars"></a>
<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-purple.svg" alt="MIT License"></a>
</p>


Provides a simple API for reading, writing and converting audio tags.

---

## Features

---


- 📖 [Reading audio tags metadata from file.](#reading-tags)
- 📝 [Writing audio tags.](#writing-tags)
- ✂ [Removing audio tags.](#removing-tags)
- 🎶 Supports multiple file formats: (MP3, MP4, FLAC, ...), A full list can be found [below](#lofty-)
- ⏳ And much more [planned features]().

## Getting started

---


- Install the package.
- Read the [Usage](#usage) section to explore `Taggy`'s features.
- Check out the example app for more details.

## Installation

---


Add `taggy` as a dependency in your `pubspec.yaml`:

```yaml
  dependencies:
    taggy: ^0.1.0
```

*or*

Run the following command:

- For a Dart project:

    ```bash
    dart pub add taggy
    ```
- For a Flutter project:

  ```bash
  flutter pub add flutter_taggy
  ```

## Usage

---

### Initialization

```dart
import 'package:taggy/taggy.dart';

void main(){
  // add this line before using [Taggy]
  Taggy.initialize();
  
  // build something cool 
}
  ```

### Reading tags

- **Reading primary tag:**

    ```dart
      final path = "path/to/audio/file.mp3";
      final taggyFile = await Taggy.readPrimary(path);
      
      // you can use [formatAsString] to pretty-print the file instance.
      print(taggyFile.formatAsString());
      // check out the output below 🔽
    ```

    <details>
        <summary>example output</summary>

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

- **Reading all tags:**

    <br/>
  
    It's similar to `readPrimary` but the returned `TaggyFile.tags` may contain more than one item depending on the file. 

    ```dart
      const path = "path/to/audio/file.mp3";
      final taggyFile = await Taggy.readAll(path);
    
      // you can also use [formatAsString], we still get a [TaggyFile].
      print(taggyFile.formatAsString());
    
      // easily access the tags
      for (var tag in taggyFile.tags) {
        print(tag.tagType);
      }
    ```

- **Reading any tag:**

  <br/>
  
  It's similar to `readPrimary` except that the returned `TaggyFile.tags` might be empty.

    ```dart
      const path = "path/to/audio/file.mp3";
      final taggyFile = await Taggy.readyAny(path);
    
      // you can also use [formatAsString], we still get a [TaggyFile].
      print(taggyFile.formatAsString());
    
      // you may want to check if it has any tags
      final hasTags = taggyFile.tags.isNotEmpty();
      // Or use the getter
      final Tag? tag = taggyFile.firstTagIfAny;
    ```

### Writing tags:

- **Note #1: Specifying the `TagType`**

  A tag type is required for creating a new `Tag` instance.

  >  if you know what type to provide: you can skip this note.
  
    else you can:
  
    -  check what `TagType` the file supports based on its type(extension). see this [table](https://github.com/Serial-ATA/lofty-rs/blob/main/SUPPORTED_FORMATS.md).

    -  use the function `Taggy.writePrimary()`
      and pass it a `Tag` with a type of `TagType.FilePrimaryType`, as shown in example below.


   <br/>

  - <details> 
  
    <summary>creating a new Tag</summary>
      
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
  
    final path = "path/to/audio/file.mp3";
    // Create a new [Tag] instance.
    // unfold the [creating new Tag] section to find this method
    final tagToWrite = getTagInstance(TagType.FilePrimaryType);

    final taggyFile = await Taggy.writePrimary(
      path: path, tag: tagToWrite, keepOthers: false);

    // On Success, [taggyFile.tags] will contain the newly added tag.
    // NOTE: this tag may not contain the same properties of [tagToWrite].
    final pTag = taggyFile.primaryTag;
  
  ```
<br/>

- **Writing multiple tags**:

  <br/>
  
  Normally you'll use `Taggy.writePrimary()` to add/edit an audio tag metadata,
  but you can also provide multiple tags to be written to the same file.

  ```dart
  
    final path = "path/to/audio/file.mp3";
    // In the same way as the previous example,
    // create a list of [Tag] instances.
   final tags = [
      getTagInstance(TagType.FilePrimaryType),
      getTagInstance(TagType.Id3v1)
    ];
      
    final taggyFile = await Taggy.writeAll(
      path: path, tag: tagToWrite, overrideExistent: true);
  
  ```

### Removing tags:

- **Remove a specific `Tag`**:

  <br/>

  ```dart
    final path = "path/to/audio/file.mp3";
    
    final taggyFile = await Taggy.removeTag(path: path, tag: tag);
  ```

## Feed back & Contributions

---

- 🐛 Found an issue or encountered a bug? please check the existing [issues](https://github.com/DMouayad/taggy/issues) or create a new one.


- 💪🏻 Want to contribute? Thank you, its always welcomed!. You can start by reading 
the [Contributing](CONTRIBUTING.md) guide.


- 🙏🏻 You can also help us if you ⭐ this repository and 👍🏻 the [package](https://pub.dev/packages/taggy) on `Pub.dev`, we do appreciate your love. 

## Acknowledgement

---


#### [lofty:](https://github.com/Serial-ATA/lofty-rs/)
  
  a Rust library which provides `Taggy` with its functionality.
  So you can find the **supported formats** by `lofty & taggy` [here](https://github.com/Serial-ATA/lofty-rs/blob/main/SUPPORTED_FORMATS.md).


#### [Flutter Rust Bridge:](https://github.com/fzyzcjy/flutter_rust_bridge)

  connects `Rust` APIs with Dart & Flutter.
  
