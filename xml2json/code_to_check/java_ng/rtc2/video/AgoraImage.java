package io.agora.rtc2.video;

public class AgoraImage {
  public String url;
  public int x;
  public int y;
  public int width;
  public int height;
  public int zOrder;

  public AgoraImage() {
    this.url = null;
    this.x = 0;
    this.y = 0;
    this.width = 0;
    this.height = 0;
    this.zOrder = 0;
  }

  public AgoraImage(String url) {
    this.url = url;
    this.x = 0;
    this.y = 0;
    this.width = 0;
    this.height = 0;
    this.zOrder = 0;
  }
}
