import '../bridge_generated.dart' as bridge;

extension TagExtension on bridge.Tag {
  bridge.Tag copyWith({
    bridge.TagType? tagType,
    List<bridge.Picture>? pictures,
    String? trackTitle,
    String? trackArtist,
    String? album,
    String? albumArtist,
    String? producer,
    int? trackNumber,
    int? trackTotal,
    int? discNumber,
    int? discTotal,
    int? year,
    String? recordingDate,
    String? originalReleaseDate,
    String? language,
    String? lyrics,
    String? genre,
  }) {
    return bridge.Tag(
      tagType: tagType ?? this.tagType,
      pictures: pictures ?? this.pictures,
      trackArtist: trackArtist ?? this.trackArtist,
      trackTotal: trackTotal ?? this.trackTotal,
      trackTitle: trackTitle ?? this.trackTitle,
      trackNumber: trackNumber ?? this.trackNumber,
      discNumber: discNumber ?? this.discNumber,
      discTotal: discTotal ?? this.discTotal,
      genre: genre ?? this.genre,
      lyrics: lyrics ?? this.lyrics,
      language: language ?? this.language,
      producer: producer ?? this.producer,
      album: album ?? this.album,
      albumArtist: albumArtist ?? this.albumArtist,
      originalReleaseDate: originalReleaseDate ?? this.originalReleaseDate,
      recordingDate: recordingDate ?? this.recordingDate,
      year: year ?? this.year,
    );
  }

  String formatAsAString() {
    return ''' 
      Tag(
          tagType: ${tagType.name},
          trackTitle: $trackTitle,
          trackArtist: $trackArtist,
          trackNumber: $trackNumber,
          trackTotal: $trackTotal,
          discTotal: $discTotal,
          discNumber: $discNumber,
          album: $album,
          albumArtist: $albumArtist,
          genre: $genre,
          language: $language,
          year: $year,
          recordingDate: $recordingDate,
          originalReleaseDate: $originalReleaseDate,
          has lyrics: ${lyrics?.isNotEmpty ?? false},
          pictures: {
            count: ${pictures.length},
            items: ${pictures.map((p) {
      return '''Picture(
                  picType: ${p.picType},
                  picData(Bytes): ${p.picData.buffer.lengthInBytes},
                  mimeType: ${p.mimeType},
                  width: ${p.width},
                  height: ${p.height},
                  colorDepth: ${p.colorDepth},
                  numColors: ${p.numColors},
            ), ''';
    }).toList()},
          },
      )''';
  }
}
