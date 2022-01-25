package io.agora.rtc2.live;

public class LiveInjectStreamConfig {

    public enum AudioSampleRateType {
        TYPE_32000(32000),
        TYPE_44100(44100),
        TYPE_48000(48000);

        private int value;

        private AudioSampleRateType(int v) {
            value = v;
        }

        public static int getValue(AudioSampleRateType type) {
            return type.value;
        }
    }
    public int width;
    public int height;
    public int videoGop;
    public int videoFramerate;
    public int videoBitrate;
    public AudioSampleRateType audioSampleRate;
    public int audioBitrate;
    public int audioChannels;

    public LiveInjectStreamConfig() {
        width = 0;
        height = 0;
        videoGop = 30;
        videoFramerate = 15;
        videoBitrate = 400;
        audioSampleRate = AudioSampleRateType.TYPE_44100;
        audioBitrate = 48;
        audioChannels = 1;
    }
}
