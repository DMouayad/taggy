/// The information of an audio track
#[derive(Debug)]
pub struct AudioInfo {
    /// The duration in seconds.
    pub(crate) duration_sec: Option<u64>,
    pub(crate) overall_bitrate: Option<u32>,
    pub(crate) audio_bitrate: Option<u32>,
    pub(crate) sample_rate: Option<u32>,
    pub(crate) bit_depth: Option<u8>,
    pub(crate) channels: Option<u8>,
    pub(crate) channel_mask: Option<u32>,
}
impl Default for AudioInfo {
    fn default() -> Self {
        Self {
            duration_sec: None,
            overall_bitrate: None,
            audio_bitrate: None,
            sample_rate: None,
            bit_depth: None,
            channels: None,
            channel_mask: None,
        }
    }
}
