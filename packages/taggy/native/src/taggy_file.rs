use crate::audio_info::AudioInfo;
use crate::tag::Tag;

/// A generic representation of an audio file
///
/// Holds the information about a file and its audio tags.
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
