package io.agora.mediaplayer;
import io.agora.base.internal.CalledByNative;
import java.nio.ByteBuffer;

public interface IMediaPlayerCustomDataProvider {
  /**
   * @brief The player requests to read the data callback, you need to fill the specified length of
   * data into the buffer
   * @param buffer the buffer pointer that you need to fill data.
   * @param bufferSize the bufferSize need to fill of the buffer pointer.
   * @return you need return offset value if succeed. return 0 if failed.
   */
  @CalledByNative int onReadData(ByteBuffer buffer, int bufferSize);

  /**
   * @brief The Player seek event callback, you need to operate the corresponding stream seek
   * operation, You can refer to the definition of lseek() at
   * https://man7.org/linux/man-pages/man2/lseek.2.html
   * @param offset the value of seek offset.
   * @param whence the postion of start seeking, the directive whence as follows:
   * 0 - SEEK_SET : The file offset is set to offset bytes.
   * 1 - SEEK_CUR : The file offset is set to its current location plus offset bytes.
   * 2 - SEEK_END : The file offset is set to the size of the file plus offset bytes.
   * 65536 - AVSEEK_SIZE : Optional. Passing this as the "whence" parameter to a seek function
   * causes it to return the filesize without seeking anywhere.
   * @return
   * whence == 65536, return filesize if you need.
   * whence >= 0 && whence < 3 , return offset value if succeed. return -1 if failed.
   */
  @CalledByNative long onSeek(long offset, int whence);
}