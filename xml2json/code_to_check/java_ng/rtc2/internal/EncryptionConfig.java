package io.agora.rtc2.internal;

/**
 * Definition of EncryptionConfig.
 */
public class EncryptionConfig {
  public enum EncryptionMode {
    /** 1: 128-bit AES encryption, XTS mode. */
    AES_128_XTS(1),
    /** 2: 128-bit AES encryption, ECB mode. */
    AES_128_ECB(2),
    /** 3: 256-bit AES encryption, XTS mode. */
    AES_256_XTS(3),
    /** 4: 128-bit SM4 encryption, ECB mode. */
    SM4_128_ECB(4),
    /** 5: 128-bit AES encryption, GCM mode. */
    AES_128_GCM(5),
    /** 6: 256-bit AES encryption, GCM mode. */
    AES_256_GCM(6),
    /** 7: (Default) 128-bit AES encryption, GCM mode, with KDF salt. */
    AES_128_GCM2(7),
    /** 8: 256-bit AES encryption, GCM mode, with KDF salt. */
    AES_256_GCM2(8),
    MODE_END(9);
    private int value;

    private EncryptionMode(int v) {
      value = v;
    }

    public int getValue() {
      return this.value;
    }
  }

  /**
   * Encryption mode. The default encryption mode is `AES_128_GCM2`. See {@link EncryptionMode}.
   */
  public EncryptionMode encryptionMode;

  /**
   * Encryption key in string type.
   * @note If you do not set an encryption key or set it as `null`, you cannot use the built-in
   * encryption, and the SDK returns `ERR_INVALID_ARGUMENT(-2)`.
   */
  public String encryptionKey;
  public final byte[] encryptionKdfSalt = new byte[32];

  public EncryptionConfig() {
    encryptionMode = EncryptionMode.AES_128_GCM2;
    encryptionKey = null;
    java.util.Arrays.fill(encryptionKdfSalt, (byte) 0);
  }
}
