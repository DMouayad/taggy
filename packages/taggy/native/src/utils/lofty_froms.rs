use lofty::{
    Accessor, AudioFile, BoundTaggedFile, FileProperties, ItemKey, TaggedFile, TaggedFileExt,
};
//
use crate::audio_info::AudioInfo;
use crate::picture::{MimeType, Picture, PictureType};
use crate::tag::{Tag, TagType};
use crate::taggy_file::{FileType, TaggyFile};
use crate::utils::file_utils::get_file_size;

impl From<&lofty::Picture> for Picture {
    fn from(value: &lofty::Picture) -> Picture {
        let [width, height, color_depth, num_colors] = extract_image_info(&value);
        Self {
            pic_type: PictureType::from(value.pic_type()),
            pic_data: value.data().to_vec(),
            mime_type: Some(MimeType::from(value.mime_type())),
            width,
            height,
            color_depth,
            num_colors,
        }
    }
}

fn extract_image_info(pic: &lofty::Picture) -> [Option<u32>; 4] {
    match lofty::PictureInformation::from_picture(pic) {
        Ok(info) => [
            Some(info.width),
            Some(info.height),
            Some(info.color_depth),
            Some(info.num_colors),
        ],
        Err(_) => [None; 4],
    }
}

impl From<&lofty::Tag> for Tag {
    fn from(value: &lofty::Tag) -> Self {
        Self {
            tag_type: TagType::from(value.tag_type()),
            pictures: value.pictures().iter().map(Picture::from).collect(),
            track_title: extract_lofty_tag_string_item(&value, &ItemKey::TrackTitle),
            track_artist: extract_lofty_tag_string_item(&value, &ItemKey::TrackArtist),
            album: extract_lofty_tag_string_item(&value, &ItemKey::AlbumTitle),
            album_artist: extract_lofty_tag_string_item(&value, &ItemKey::AlbumArtist),
            producer: extract_lofty_tag_string_item(&value, &ItemKey::Producer),
            track_number: value.track(),
            track_total: value.track_total(),
            disc_number: value.disk(),
            disc_total: value.disk_total(),
            year: value.year(),
            recording_date: extract_lofty_tag_string_item(&value, &ItemKey::RecordingDate),
            original_release_date: extract_lofty_tag_string_item(
                &value,
                &ItemKey::OriginalReleaseDate,
            ),
            language: extract_lofty_tag_string_item(&value, &ItemKey::Language),
            lyrics: extract_lofty_tag_string_item(&value, &ItemKey::Lyrics),
            genre: match value.genre() {
                None => None,
                Some(g) => Some(g.to_string()),
            },
        }
    }
}

fn extract_lofty_tag_string_item(tag: &lofty::Tag, key: &ItemKey) -> Option<String> {
    tag.get_string(&key).map(|e| e.to_string())
}

impl From<lofty::PictureType> for PictureType {
    fn from(value: lofty::PictureType) -> Self {
        match value {
            lofty::PictureType::Other => PictureType::Other,
            lofty::PictureType::Icon => PictureType::Icon,
            lofty::PictureType::OtherIcon => PictureType::OtherIcon,
            lofty::PictureType::CoverFront => PictureType::CoverFront,
            lofty::PictureType::CoverBack => PictureType::CoverBack,
            lofty::PictureType::Leaflet => PictureType::Leaflet,
            lofty::PictureType::Media => PictureType::Media,
            lofty::PictureType::LeadArtist => PictureType::LeadArtist,
            lofty::PictureType::Artist => PictureType::Artist,
            lofty::PictureType::Conductor => PictureType::Conductor,
            lofty::PictureType::Band => PictureType::Band,
            lofty::PictureType::Composer => PictureType::Composer,
            lofty::PictureType::Lyricist => PictureType::Lyricist,
            lofty::PictureType::RecordingLocation => PictureType::RecordingLocation,
            lofty::PictureType::DuringRecording => PictureType::DuringRecording,
            lofty::PictureType::DuringPerformance => PictureType::DuringPerformance,
            lofty::PictureType::ScreenCapture => PictureType::ScreenCapture,
            lofty::PictureType::BrightFish => PictureType::BrightFish,
            lofty::PictureType::Illustration => PictureType::Illustration,
            lofty::PictureType::BandLogo => PictureType::BandLogo,
            lofty::PictureType::PublisherLogo => PictureType::PublisherLogo,
            lofty::PictureType::Undefined(_) => PictureType::Undefined,
            _ => PictureType::Undefined,
        }
    }
}

impl<'a> From<&'a lofty::MimeType> for MimeType {
    fn from(other: &lofty::MimeType) -> Self {
        match other {
            lofty::MimeType::Png => MimeType::Png,
            lofty::MimeType::Jpeg => MimeType::Jpeg,
            lofty::MimeType::Tiff => MimeType::Tiff,
            lofty::MimeType::Bmp => MimeType::Bmp,
            lofty::MimeType::Gif => MimeType::Gif,
            lofty::MimeType::Unknown(_) => MimeType::Unknown,
            lofty::MimeType::None => MimeType::None,
            _ => MimeType::Unknown,
        }
    }
}

impl From<lofty::FileType> for FileType {
    fn from(value: lofty::FileType) -> Self {
        match value {
            lofty::FileType::Aac => FileType::Aac,
            lofty::FileType::Aiff => FileType::Aiff,
            lofty::FileType::Ape => FileType::Ape,
            lofty::FileType::Flac => FileType::Flac,
            lofty::FileType::Mpeg => FileType::Mpeg,
            lofty::FileType::Mp4 => FileType::Mp4,
            lofty::FileType::Mpc => FileType::Mpc,
            lofty::FileType::Opus => FileType::Opus,
            lofty::FileType::Vorbis => FileType::Vorbis,
            lofty::FileType::Speex => FileType::Speex,
            lofty::FileType::Wav => FileType::Wav,
            lofty::FileType::WavPack => FileType::WavPack,
            lofty::FileType::Custom(_) => FileType::Other,
            _ => FileType::Other,
        }
    }
}

impl<'a> From<&'a FileProperties> for AudioInfo {
    fn from(value: &FileProperties) -> Self {
        Self {
            duration_sec: Some(value.duration().as_secs()),
            overall_bitrate: value.overall_bitrate(),
            audio_bitrate: value.audio_bitrate(),
            sample_rate: value.sample_rate(),
            bit_depth: value.bit_depth(),
            channels: value.channels(),
            channel_mask: match value.channel_mask() {
                None => None,
                Some(cm) => Some(cm.bits()),
            },
        }
    }
}

impl From<lofty::TagType> for TagType {
    fn from(value: lofty::TagType) -> Self {
        match value {
            lofty::TagType::Ape => TagType::Ape,
            lofty::TagType::Id3v1 => TagType::Id3v1,
            lofty::TagType::Id3v2 => TagType::Id3v2,
            lofty::TagType::Mp4Ilst => TagType::Mp4Ilst,
            lofty::TagType::VorbisComments => TagType::VorbisComments,
            lofty::TagType::RiffInfo => TagType::RiffInfo,
            lofty::TagType::AiffText => TagType::AiffText,
            _ => TagType::Other,
        }
    }
}
pub fn taggy_from_tagged(file: &TaggedFile, path: &String) -> TaggyFile {
    TaggyFile {
        file_type: Some(file.file_type().into()),
        size: get_file_size(path),
        audio: AudioInfo::from(file.properties()),
        /// convert the [`TaggedFile::tags`] to a `Vec` of our taggy's [`Tag`]
        tags: file.tags().iter().map(Tag::from).collect(),
        primary_tag_type: TagType::from(file.primary_tag_type()),
    }
}

pub(crate) fn taggy_from_bound_tagged(file: &BoundTaggedFile, path: &String) -> TaggyFile {
    TaggyFile {
        file_type: Some(file.file_type().into()),
        size: get_file_size(path),
        audio: AudioInfo::from(file.properties()),
        /// convert the [`TaggedFile::tags`] to a `Vec` of our taggy's [`Tag`]
        tags: file.tags().iter().map(Tag::from).collect(),
        primary_tag_type: TagType::from(file.primary_tag_type()),
    }
}
/// Returns a list of [Tag] with only the primary tag if exists
pub(crate) fn get_primary_tag_from_tagged_file(file: &TaggedFile) -> Vec<Tag> {
    let mut tags: Vec<Tag> = Vec::with_capacity(1);
    if let Some(lofty_tag) = file.primary_tag() {
        tags.push(Tag::from(lofty_tag));
    }
    tags
}

pub(crate) fn get_any_tag_from_tagged_file(file: &TaggedFile) -> Vec<Tag> {
    file.first_tag().map_or(vec![], |t| vec![Tag::from(t)])
}
