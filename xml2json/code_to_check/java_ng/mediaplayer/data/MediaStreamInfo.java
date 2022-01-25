//
//  Agora RTC/MEDIA SDK
//
//  Created by Tongjiangyong in 2019-11.
//  Copyright (c) 2019 Agora.io. All rights reserved.
//
package io.agora.mediaplayer.data;

import io.agora.base.internal.CalledByNative;
public class MediaStreamInfo {
  private int streamIndex;
  private int mediaStreamType;
  private String codecName;
  private String language;
  private int videoFrameRate;
  private int videoBitRate;
  private int videoWidth;
  private int videoHeight;
  private int videoRotation;
  private int audioSampleRate;
  private int audioChannels;
  private int audioBytesPerSample;
  private long duration;

  public MediaStreamInfo() {}

  @CalledByNative
  public MediaStreamInfo(int streamIndex, int mediaStreamType, String codecName, String language,
      int videoFrameRate, int videoBitRate, int videoWidth, int videoHeight, int videoRotation,
      int audioSampleRate, int audioChannels, long duration) {
    this.streamIndex = streamIndex;
    this.mediaStreamType = mediaStreamType;
    this.codecName = codecName;
    this.language = language;
    this.videoFrameRate = videoFrameRate;
    this.videoBitRate = videoBitRate;
    this.videoWidth = videoWidth;
    this.videoHeight = videoHeight;
    this.videoRotation = videoRotation;
    this.audioSampleRate = audioSampleRate;
    this.audioChannels = audioChannels;
    this.duration = duration;
  }

  @CalledByNative
  public int getStreamIndex() {
    return streamIndex;
  }

  @CalledByNative
  public int getMediaStreamType() {
    return mediaStreamType;
  }

  @CalledByNative
  public String getCodecName() {
    return codecName;
  }

  @CalledByNative
  public String getLanguage() {
    return language;
  }

  @CalledByNative
  public int getVideoFrameRate() {
    return videoFrameRate;
  }

  @CalledByNative
  public int getVideoWidth() {
    return videoWidth;
  }

  @CalledByNative
  public int getVideoHeight() {
    return videoHeight;
  }

  @CalledByNative
  public int getAudioSampleRate() {
    return audioSampleRate;
  }

  @CalledByNative
  public int getAudioChannels() {
    return audioChannels;
  }

  @CalledByNative
  public int getAudioBytesPerSample() {
    return audioBytesPerSample;
  }

  @CalledByNative
  public long getDuration() {
    return duration;
  }

  @CalledByNative
  public int getVideoBitRate() {
    return videoBitRate;
  }

  public void setStreamIndex(int streamIndex) {
    this.streamIndex = streamIndex;
  }

  public void setMediaStreamType(int mediaStreamType) {
    this.mediaStreamType = mediaStreamType;
  }

  public void setCodecName(String codecName) {
    this.codecName = codecName;
  }

  public void setLanguage(String language) {
    this.language = language;
  }

  public void setVideoFrameRate(int videoFrameRate) {
    this.videoFrameRate = videoFrameRate;
  }

  public void setVideoBitRate(int videoBitRate) {
    this.videoBitRate = videoBitRate;
  }

  public void setVideoWidth(int videoWidth) {
    this.videoWidth = videoWidth;
  }

  public void setVideoHeight(int videoHeight) {
    this.videoHeight = videoHeight;
  }

  public void setAudioSampleRate(int audioSampleRate) {
    this.audioSampleRate = audioSampleRate;
  }

  public void setAudioChannels(int audioChannels) {
    this.audioChannels = audioChannels;
  }

  public void setAudioBytesPerSample(int audioBytesPerSample) {
    this.audioBytesPerSample = audioBytesPerSample;
  }

  public void setDuration(long duration) {
    this.duration = duration;
  }

  public int getVideoRotation() {
    return videoRotation;
  }

  public void setVideoRotation(int videoRotation) {
    this.videoRotation = videoRotation;
  }

  @Override
  public String toString() {
    return "MediaStreamInfo{"
        + "streamIndex=" + streamIndex + ", mediaStreamType=" + mediaStreamType + ", codecName='"
        + codecName + '\'' + ", language='" + language + '\'' + ", videoFrameRate=" + videoFrameRate
        + ", videoBitRate=" + videoBitRate + ", videoWidth=" + videoWidth + ", videoHeight="
        + videoHeight + ", audioSampleRate=" + audioSampleRate + ", videoRotation=" + videoRotation
        + ", audioChannels=" + audioChannels + ", duration=" + duration + '}';
  }
}
