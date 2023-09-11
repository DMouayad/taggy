import 'package:taggy/src/utils/tag_extension.dart';

import '../bridge_generated.dart' as bridge;

extension TaggyFileExtension on bridge.TaggyFile {
  /// Returns the size of this file in MegaBytes
  double get sizeInMB {
    if (size == null) return 0.0;
    return double.parse(((size! / 1024) / 1000).toStringAsFixed(2));
  }

  /// The duration of the audio track.
  Duration get duration {
    return Duration(seconds: audio.durationSec ?? 0);
  }

  bridge.Tag? get firstTagIfAny {
    return tags.firstOrNull;
  }

  /// Returns the [Tag] with a type equals to [primaryTagType].
  /// If it wasn't found, will return `null`.
  bridge.Tag? get primaryTag {
    try {
      return tags.firstWhere((t) => t.tagType == primaryTagType);
    } on StateError {
      return null;
    }
  }

  /// Formats this file properties into a [String].
  String formatAsString() {
    return '''
    TaggyFile: {
      size: $size bytes ~ $sizeInMB MB,
      fileType: $fileType
      primaryTagType: $primaryTagType,
      tags: {
         count: ${tags.length},
         items: ${tags.map((e) => '\n\t${e.formatAsAString()}').toList()},
      },
      audio: AudioInfo(
        channelMask: ${audio.channelMask},
        channels: ${audio.channels},
        sampleRate: ${audio.sampleRate},
        audioBitrate: ${audio.audioBitrate},
        overallBitrate: ${audio.overallBitrate},
        bitDepth: ${audio.bitDepth},
        durationSec: ${audio.durationSec},
        ),
      }''';
  }
}
