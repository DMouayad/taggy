use crate::picture::Picture;

#[derive(Debug)]
pub struct Tag {
    pub(crate) tag_type: Option<TagType>,
    pub(crate) pictures: Vec<Picture>,
    // Track General Info
    pub(crate) track_title: Option<String>,
    pub(crate) track_artist: Option<String>,
    pub(crate) album: Option<String>,
    pub(crate) album_artist: Option<String>,
    pub(crate) producer: Option<String>,
    /// The number of the track on its disk.
    pub(crate) track_number: Option<u32>,
    /// The disk total track count
    pub(crate) track_total: Option<u32>,
    pub(crate) disk_number: Option<u32>,
    pub(crate) disk_total: Option<u32>,
    pub(crate) year: Option<u32>,
    pub(crate) recording_date: Option<String>,
    pub(crate) original_release_date: Option<String>,
    pub(crate) language: Option<String>,
    pub(crate) lyrics: Option<String>,
    pub(crate) genre: Option<String>,
}

#[derive(Debug, Copy, Clone)]
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
    /// Other type
    Other,
}
