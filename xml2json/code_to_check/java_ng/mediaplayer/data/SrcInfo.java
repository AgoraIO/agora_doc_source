//
//  Agora RTC/MEDIA SDK
//
//  Created by Chenjianming in 2021-10.
//  Copyright (c) 2021 Agora.io. All rights reserved.
//
package io.agora.mediaplayer.data;

import io.agora.base.internal.CalledByNative;
public class SrcInfo {
  /**
   * The bitrate of the media stream. The unit of the number is kbps.
   *
   */
  private int bitrateInKbps;

  /**
   * The name of the media stream.
   *
   */
  private String name;

  public SrcInfo() {}

  @CalledByNative
  public SrcInfo(int bitrateInKbps, String name) {
    this.bitrateInKbps = bitrateInKbps;
    this.name = name;
  }

  @CalledByNative
  public int getBitrateInKbps() {
    return bitrateInKbps;
  }

  @CalledByNative
  public String getName() {
    return name;
  }

  public void setBitrateInKbps(int bitrateInKbps) {
    this.bitrateInKbps = bitrateInKbps;
  }

  public void setName(String name) {
    this.name = name;
  }

  @Override
  public String toString() {
    return "SrcInfo{"
        + "bitrateInKbps=" + bitrateInKbps + ", name=" + name + '}';
  }
}
