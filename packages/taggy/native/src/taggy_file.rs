use crate::audio_info::AudioInfo;
use crate::tag::{Tag, TagType};

/// A generic representation of an audio file
///
/// Holds information about a file and its audio tags.
#[derive(Debug)]
pub struct TaggyFile {
    /// The Type of this file
    pub(crate) file_type: Option<FileType>,
    /// The Size of this file
    pub(crate) size: Option<u64>,
    /// The properties of this file audio track.
    pub(crate) audio: AudioInfo,
    /// The tags included with this file.
    pub(crate) tags: Vec<Tag>,
    pub(crate) primary_tag_type: TagType,
}

impl TaggyFile {
    /// Returns the tag which has a [`TagType`] equals to this file `primary_tag_type`.
    pub fn primary_tag(self) -> Option<Tag> {
        self.tags
            .iter()
            .find(|&t| t.tag_type == self.primary_tag_type)
            .cloned()
    }
    /// Returns the first tag of this file tags.
    pub fn first_tag(self) -> Option<Tag> {
        self.tags.first().cloned()
    }
}

/// The type of a file
#[derive(Debug, Copy, Clone)]
pub(crate) enum FileType {
    Aac,
    Aiff,
    Ape,
    Flac,
    Mpeg,
    Mp4,
    Mpc,
    Opus,
    Vorbis,
    Speex,
    Wav,
    WavPack,
    Other,
}
