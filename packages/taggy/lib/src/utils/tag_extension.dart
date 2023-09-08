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
}
