//
//  Agora RTC/MEDIA SDK
//
//  Copyright (c) 2019 Agora.io. All rights reserved.
//
package io.agora.base;

import java.nio.ByteBuffer;

import io.agora.base.internal.CalledByNative;

public class AudioFrame {
  public ByteBuffer buffer; // ByteBuffer format audio pcm data
  public int sampleRataHz; // audio sample rate
  public int bytesPerSample; // audio data size per sample
  public int channelNums; // audio channel numbers
  public int samplesPerChannel; // samples of per audio channel
  public long timestamp; // audio frame timestamp

  @CalledByNative
  public AudioFrame(ByteBuffer buffer, int sampleRataHz, int bytesPerSample, int channelNums,
      int samplesPerChannel, long timestamp) {
    this.sampleRataHz = sampleRataHz;
    this.bytesPerSample = bytesPerSample;
    this.channelNums = channelNums;
    this.samplesPerChannel = samplesPerChannel;
    this.timestamp = timestamp;
    this.buffer = buffer;
  }

  @CalledByNative
  public ByteBuffer getByteBuffer() {
    return buffer;
  }

  @CalledByNative
  public int getBytesPerSample() {
    return bytesPerSample;
  }

  @CalledByNative
  public int getChannelNums() {
    return channelNums;
  }

  @CalledByNative
  public int getSampleRataHz() {
    return sampleRataHz;
  }

  @CalledByNative
  public int getSamplesPerChannel() {
    return samplesPerChannel;
  }

  @CalledByNative
  public long getTimestamp() {
    return timestamp;
  }

  @Override
  public String toString() {
    return "AudioFrame{sampleRataHz=" + sampleRataHz + ", bytesPerSample=" + bytesPerSample
        + ", channelNums=" + channelNums + ", samplesPerChannel=" + samplesPerChannel
        + ", timestamp=" + timestamp + '}';
  }
}
