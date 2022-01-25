package io.agora.rtc2.video;

import android.graphics.Color;
import io.agora.rtc2.internal.Logging;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 * Created by sting on 11/17/2016.
 */

@Deprecated
public class VideoCompositingLayout {
  public int canvasWidth;
  public int canvasHeight;
  public String backgroundColor;
  public Region[] regions = null;
  public byte[] appData = null;

  public static class Region {
    public int uid;
    public String userId;
    public double x;
    public double y;
    public double width;
    public double height;
    public int zOrder;
    public double alpha;
    public int renderMode;

    public Region uid(int uid) {
      this.uid = uid;
      return this;
    }

    public Region userId(String userId) {
      this.userId = userId;
      return this;
    }

    public Region position(double x, double y) {
      this.x = x;
      this.y = y;
      return this;
    }

    public Region size(double width, double height) {
      this.width = width;
      this.height = height;
      return this;
    }

    public Region zOrder(int z) {
      this.zOrder = z;
      return this;
    }

    public Region alpha(double a) {
      this.alpha = a;
      return this;
    }

    public Region renderMode(int mode) {
      this.renderMode = mode;
      return this;
    }
  }

  public static class Canvas {
    public int width = 320;
    public int height = 640;
    public String bgColor = "#FF0000"; // TBD: default bg color
  }

  public static boolean isValidColor(String color) {
    try {
      Color.parseColor(color);
      return true;
    } catch (Exception iae) {
      return false;
    }
  }

  public static class Builder {
    public Canvas canvas;
    public List<Region> regionsList;
    public String appData;

    public Builder() {
      canvas = new Canvas();
    }

    public final int regionCount() {
      if (regionsList == null) {
        return 0;
      } else {
        return regionsList.size();
      }
    }

    public Builder setCanvas(int w, int h) {
      canvas.width = w;
      canvas.height = h;
      return this;
    }

    public Builder setCanvas(int w, int h, String bgColor) {
      if (isValidColor(bgColor)) {
        canvas.bgColor = bgColor;
      } else {
        Logging.w("VideoCompositingLayout", "unknown color " + bgColor + ", using default bgColor");
      }

      return setCanvas(w, h);
    }

    public Builder addWindow(Region region) {
      if (regionsList == null) {
        regionsList = new ArrayList<Region>();
      }
      regionsList.add(region);
      return this;
    }

    public Builder removeWindowForUid(int uid) {
      if (regionsList == null) {
        return this;
      }
      List<Region> removedRegions = new ArrayList<>();
      for (Region item : regionsList) {
        if (item.uid == uid) {
          removedRegions.add(item);
        }
      }
      regionsList.removeAll(removedRegions);
      return this;
    }

    public Builder resetWindows(List<Region> regions) {
      regionsList = new ArrayList<>(regions);
      return this;
    }

    public Builder updateAppData(String appData) {
      this.appData = appData;
      return this;
    }

    public VideoCompositingLayout create() {
      VideoCompositingLayout layout = new VideoCompositingLayout();
      layout.canvasWidth = canvas.width;
      layout.canvasHeight = canvas.height;
      layout.backgroundColor = canvas.bgColor;
      if (regionsList != null && regionsList.size() > 0) {
        layout.regions = regionsList.toArray(new Region[regionsList.size()]);
      }
      if (appData != null) {
        layout.appData = appData.getBytes();
      }
      return layout;
    }
  }
}
