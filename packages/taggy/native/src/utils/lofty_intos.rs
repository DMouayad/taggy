use crate::picture::{MimeType, Picture, PictureType};
use crate::tag::{Tag, TagType};
use lofty::ItemKey;

impl Tag {
    pub fn to_lofty(&self) -> lofty::Tag {
        let tag_type = self.tag_type.clone().into();
        let mut lofty_tag = lofty::Tag::new(tag_type);

        if let Some(title) = &self.track_title {
            lofty_tag.insert_text(ItemKey::TrackTitle, title.to_string());
        };

        // Artist
        if let Some(artist) = &self.track_artist {
            lofty_tag.insert_text(ItemKey::TrackArtist, artist.to_string());
        };

        // Album Title
        if let Some(album) = &self.album {
            lofty_tag.insert_text(ItemKey::AlbumTitle, album.to_string());
        };
        if let Some(album_artist) = &self.album_artist {
            lofty_tag.insert_text(ItemKey::AlbumArtist, album_artist.to_string());
        };
        if let Some(lyrics) = &self.lyrics {
            lofty_tag.insert_text(ItemKey::Lyrics, lyrics.to_string());
        };
        if let Some(language) = &self.language {
            lofty_tag.insert_text(ItemKey::Language, language.to_string());
        };
        if let Some(producer) = &self.producer {
            // Writing a producer for this tag type results in an error due to writing
            // some invalid frame for the tag.
            // TODO:: remove when 'lofty::ParsingMode::Relaxed' is implemented.
            if tag_type != lofty::TagType::Id3v2 {
                lofty_tag.insert_text(ItemKey::Producer, producer.to_string());
            }
        };
        if let Some(release) = &self.original_release_date {
            lofty_tag.insert_text(ItemKey::OriginalReleaseDate, release.to_string());
        };
        if let Some(recording_date) = &self.recording_date {
            lofty_tag.insert_text(ItemKey::RecordingDate, recording_date.to_string());
        };
        if let Some(track_total) = &self.track_total {
            lofty_tag.insert_text(ItemKey::TrackTotal, track_total.to_string());
        };
        if let Some(track_num) = &self.track_number {
            lofty_tag.insert_text(ItemKey::TrackNumber, track_num.to_string());
        };
        if let Some(disc) = &self.disc_number {
            lofty_tag.insert_text(ItemKey::DiscNumber, disc.to_string());
        };
        if let Some(disc_total) = &self.disc_total {
            lofty_tag.insert_text(ItemKey::DiscTotal, disc_total.to_string());
        };

        // Year
        if let Some(year) = &self.year {
            lofty_tag.insert_text(ItemKey::Year, year.clone().to_string());
        };

        // Genre
        if let Some(genre) = &self.genre {
            lofty_tag.insert_text(ItemKey::Genre, genre.to_string());
        };
        // Pictures
        for (i, picture) in self.pictures.to_vec().into_iter().enumerate() {
            lofty_tag.set_picture(i, get_pic_from_data(&picture));
        }
        lofty_tag
    }
}

fn get_pic_from_data(pic: &Picture) -> lofty::Picture {
    lofty::Picture::new_unchecked(
        pic.pic_type.into(),
        pic.mime_type.map_or(lofty::MimeType::None, |p| p.into()),
        None,
        pic.pic_data.clone(),
    )
}

impl Into<lofty::TagType> for TagType {
    fn into(self) -> lofty::TagType {
        match self {
            TagType::Ape => lofty::TagType::Ape,
            TagType::Id3v1 => lofty::TagType::Id3v1,
            TagType::Id3v2 => lofty::TagType::Id3v2,
            TagType::Mp4Ilst => lofty::TagType::Mp4Ilst,
            TagType::VorbisComments => lofty::TagType::VorbisComments,
            TagType::RiffInfo => lofty::TagType::RiffInfo,
            TagType::AiffText => lofty::TagType::AiffText,
            TagType::Other => lofty::TagType::Id3v2,
            TagType::FilePrimaryType => lofty::TagType::Id3v2,
        }
    }
}
impl Into<lofty::MimeType> for MimeType {
    fn into(self) -> lofty::MimeType {
        match self {
            MimeType::Png => lofty::MimeType::Png,
            MimeType::Jpeg => lofty::MimeType::Jpeg,
            MimeType::Tiff => lofty::MimeType::Tiff,
            MimeType::Bmp => lofty::MimeType::Bmp,
            MimeType::Gif => lofty::MimeType::Gif,
            MimeType::Unknown => lofty::MimeType::Unknown("unknown".to_string()),
            MimeType::None => lofty::MimeType::None,
        }
    }
}
impl Into<lofty::PictureType> for PictureType {
    fn into(self) -> lofty::PictureType {
        match self {
            PictureType::Other => lofty::PictureType::Other,
            PictureType::Icon => lofty::PictureType::Icon,
            PictureType::OtherIcon => lofty::PictureType::OtherIcon,
            PictureType::CoverFront => lofty::PictureType::CoverFront,
            PictureType::CoverBack => lofty::PictureType::CoverBack,
            PictureType::Leaflet => lofty::PictureType::Leaflet,
            PictureType::Media => lofty::PictureType::Media,
            PictureType::LeadArtist => lofty::PictureType::LeadArtist,
            PictureType::Artist => lofty::PictureType::Artist,
            PictureType::Conductor => lofty::PictureType::Conductor,
            PictureType::Band => lofty::PictureType::Band,
            PictureType::Composer => lofty::PictureType::Composer,
            PictureType::Lyricist => lofty::PictureType::Lyricist,
            PictureType::RecordingLocation => lofty::PictureType::RecordingLocation,
            PictureType::DuringRecording => lofty::PictureType::DuringRecording,
            PictureType::DuringPerformance => lofty::PictureType::DuringPerformance,
            PictureType::ScreenCapture => lofty::PictureType::ScreenCapture,
            PictureType::BrightFish => lofty::PictureType::BrightFish,
            PictureType::Illustration => lofty::PictureType::Illustration,
            PictureType::BandLogo => lofty::PictureType::BandLogo,
            PictureType::PublisherLogo => lofty::PictureType::PublisherLogo,
            PictureType::Undefined => lofty::PictureType::Undefined(0),
        }
    }
}
