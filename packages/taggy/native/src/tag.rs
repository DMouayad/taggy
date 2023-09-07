use crate::builders::tag_builder::TagBuilder;
use crate::picture::Picture;
use rand::prelude::SliceRandom;

#[derive(Debug, PartialEq)]
pub struct Tag {
    pub(crate) tag_type: TagType,
    pub(crate) pictures: Vec<Picture>,
    // Track General Info
    pub(crate) track_title: Option<String>,
    pub(crate) track_artist: Option<String>,
    pub(crate) album: Option<String>,
    pub(crate) album_artist: Option<String>,
    pub(crate) producer: Option<String>,
    pub(crate) track_number: Option<u32>,
    /// Total track count of this track's disc
    pub(crate) track_total: Option<u32>,
    pub(crate) disc_number: Option<u32>,
    pub(crate) disc_total: Option<u32>,
    pub(crate) year: Option<u32>,
    pub(crate) recording_date: Option<String>,
    pub(crate) original_release_date: Option<String>,
    pub(crate) language: Option<String>,
    pub(crate) lyrics: Option<String>,
    pub(crate) genre: Option<String>,
}

impl Clone for Tag {
    fn clone(&self) -> Self {
        Self {
            tag_type: self.tag_type,
            pictures: self.pictures.to_vec(),
            track_title: (&self.track_title).clone(),
            track_artist: (&self.track_artist).clone(),
            album: (&self.album).clone(),
            album_artist: (&self.album_artist).clone(),
            producer: (&self.producer).clone(),
            track_number: (&self.track_number).clone(),
            track_total: (&self.track_total).clone(),
            disc_number: (&self.disc_number).clone(),
            disc_total: (&self.disc_total).clone(),
            year: (&self.year).clone(),
            recording_date: (&self.recording_date).clone(),
            original_release_date: (&self.original_release_date).clone(),
            language: (&self.language).clone(),
            lyrics: (&self.lyrics).clone(),
            genre: (&self.genre).clone(),
        }
    }
}

#[derive(Debug, Copy, Clone, PartialEq)]
pub enum TagType {
    /// This covers both APEv1 and APEv2 as it doesn't matter much
    Ape,
    /// Represents an ID3v1 tag
    Id3v1,
    /// This covers all ID3v2 versions since they all get upgraded to ID3v2.4
    Id3v2,
    /// Represents an MP4 ilst atom
    Mp4Ilst,
    /// Represents vorbis comments
    VorbisComments,
    /// Represents a RIFF INFO LIST
    RiffInfo,
    /// Represents AIFF text chunks
    AiffText,
    /// This will be converted to the audio file primary tag type.
    ///
    /// **Note**: this is intended for the tag passed to `write_primary()` if you don't
    /// know the file primary tag type.
    FilePrimaryType,
    /// Other type
    Other,
}
impl Tag {
    pub fn builder() -> TagBuilder {
        TagBuilder::new()
    }
    pub fn new(tag_type: TagType) -> Self {
        Self {
            tag_type,
            pictures: vec![],
            track_title: None,
            track_artist: None,
            album: None,
            album_artist: None,
            producer: None,
            track_number: None,
            track_total: None,
            disc_number: None,
            disc_total: None,
            year: None,
            recording_date: None,
            original_release_date: None,
            language: None,
            lyrics: None,
            genre: None,
        }
    }
}
impl TagType {
    pub fn random() -> TagType {
        let enum_vals = [
            TagType::Ape,
            TagType::Other,
            TagType::Id3v2,
            TagType::Id3v1,
            TagType::Mp4Ilst,
            TagType::RiffInfo,
            TagType::AiffText,
            TagType::VorbisComments,
        ];
        enum_vals.choose(&mut rand::thread_rng()).unwrap().clone()
    }
}
