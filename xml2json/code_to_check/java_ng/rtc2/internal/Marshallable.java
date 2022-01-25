package io.agora.rtc2.internal;

import java.io.UnsupportedEncodingException;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.util.ArrayList;

class Marshallable {
  public static final int PROTO_PACKET_SIZE = 8 * 1024;
  private ByteBuffer mBuffer = ByteBuffer.allocate(PROTO_PACKET_SIZE);

  public Marshallable() {
    mBuffer.order(ByteOrder.LITTLE_ENDIAN);
    mBuffer.position(2);
  }

  public byte[] marshall() {
    short len = (short) mBuffer.position();
    mBuffer.putShort(0, len);
    byte[] data = new byte[len];
    mBuffer.position(0);
    mBuffer.get(data);
    return data;
  }

  public void marshall(ByteBuffer buf) {
    mBuffer = buf;
  }

  public void unmarshall(byte[] buf) {
    mBuffer = ByteBuffer.wrap(buf);
    mBuffer.order(ByteOrder.LITTLE_ENDIAN);
    short len = popShort();
  }

  public void unmarshall(ByteBuffer buf) {
    this.mBuffer = buf;
  }

  public ByteBuffer getBuffer() {
    return mBuffer;
  }

  public void pushBool(Boolean val) {
    byte b = 0;
    if (val)
      b = 1;

    mBuffer.put(b);
  }

  public Boolean popBool() {
    byte b = mBuffer.get();
    return (b == 1);
  }

  public void pushByte(byte val) {
    mBuffer.put(val);
  }

  public byte popByte() {
    return mBuffer.get();
  }

  public void pushBytes(byte[] buf) {
    mBuffer.putShort((short) buf.length);
    mBuffer.put(buf);
  }

  public byte[] popBytes() {
    int len = mBuffer.getShort();
    byte[] buf = new byte[0];
    if (len > 0) {
      buf = new byte[len];
      mBuffer.get(buf);
    }

    return buf;
  }

  public void pushBytes32(byte[] buf) {
    mBuffer.putInt(buf.length);
    mBuffer.put(buf);
  }

  public byte[] popBytes32() {
    int len = mBuffer.getInt();
    byte[] buf = null;
    if (len > 0) {
      buf = new byte[len];
      mBuffer.get(buf);
    }

    return buf;
  }

  public byte[] popAll() {
    int len = mBuffer.remaining();
    byte[] buf = new byte[len];
    mBuffer.get(buf);
    return buf;
  }

  public void pushShort(short val) {
    mBuffer.putShort(val);
  }

  public short popShort() {
    return mBuffer.getShort();
  }

  public void pushInt(int val) {
    mBuffer.putInt(val);
  }
  public void pushDouble(double val) {
    mBuffer.putDouble(val);
  }

  public int popInt() {
    return mBuffer.getInt();
  }

  public void pushInt64(long val) {
    mBuffer.putLong(val);
  }

  public long popInt64() {
    return mBuffer.getLong();
  }

  public double popDouble() {
    return mBuffer.getDouble();
  }

  public void pushString16(String val) {
    if (val == null) {
      mBuffer.putShort((short) 0);
      return;
    }

    mBuffer.putShort((short) val.getBytes().length);
    if (val.getBytes().length > 0) {
      mBuffer.put(val.getBytes());
    }
  }

  public String popString16() {
    short len = mBuffer.getShort();
    byte[] buf = null;
    if (len > 0) {
      buf = new byte[len];
      mBuffer.get(buf);
      try {
        return new String(buf, "ISO-8859-1"); // ansi
      } catch (UnsupportedEncodingException e) {
        e.printStackTrace();
      }
    }

    return "";
  }

  public String popString16UTF8() {
    short len = mBuffer.getShort();
    byte[] buf = null;
    if (len > 0) {
      buf = new byte[len];
      mBuffer.get(buf);
      try {
        return new String(buf, "utf-8"); // utf-8
      } catch (UnsupportedEncodingException e) {
        e.printStackTrace();
      }
    }

    return "";
  }

  public void pushStringArray(ArrayList<String> vals) {
    if (vals == null) {
      pushInt(0);
      return;
    }

    int len = vals.size();
    pushShort((short) len);
    for (int i = 0; i < len; i++) {
      pushBytes(vals.get(i).getBytes());
    }
  }
  public void pushIntArray(int[] vals) {
    if (vals == null) {
      pushInt(0);
      return;
    }

    int len = vals.length;
    pushInt(len);
    for (int i = 0; i < len; i++) {
      pushInt(vals[i]);
    }
  }

  public void pushIntArray(Integer[] vals) {
    if (vals == null) {
      pushInt(0);
      return;
    }

    int len = vals.length;
    pushInt(len);
    for (int i = 0; i < len; i++) {
      pushInt(vals[i]);
    }
  }

  public int[] popIntArray() {
    int len = popInt();
    int[] vals = new int[len];
    for (int i = 0; i < len; i++) {
      vals[i] = popInt();
    }

    return vals;
  }

  public void pushShortArray(short[] vals) {
    if (vals == null) {
      pushInt(0);
      return;
    }

    int len = vals.length;
    pushInt(len);
    for (int i = 0; i < len; i++) {
      pushShort(vals[i]);
    }
  }

  public short[] popShortArray() {
    int len = popInt();
    short[] vals = new short[len];
    for (int i = 0; i < len; i++) {
      vals[i] = popShort();
    }

    return vals;
  }

  public void clear() {
    mBuffer.position(10);
  }
}
