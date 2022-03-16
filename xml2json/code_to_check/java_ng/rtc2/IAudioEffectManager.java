package io.agora.rtc2;

/// @cond
/**
 * Provides the methods to manage the audio effects.
 */
public interface IAudioEffectManager {
  /**
   * Gets the volume of the audio effects.
   *
   * @return
   * - Returns the volume of audio effects, if the method call is successful. The value ranges
   * between 0.0 and 100.0 (original volume).
   * - < 0: Failure.
   */
  public double getEffectsVolume();

  /**
   * Sets the volume of audio effects.
   *
   * @param volume The volume of audio effects. The value ranges between 0.0 and 100.0 (default).
   * @return <ul><li>0: Success.<li><0: Failure.</ul>
   */
  public int setEffectsVolume(double volume);

  /**
   * Sets the volume of the specified audio effect.
   *
   * @param soundId The ID of the audio effect.
   * @param volume The volume of the specified audio effect. The value ranges between 0.0 and 100.0
   *     (default).
   * @return <ul><li>0: Success.<li><0: Failure.</ul>
   */
  public int setVolumeOfEffect(int soundId, double volume);

  /**
   * Plays a specified audio effect.
   *
   * After calling {@link IAudioEffectManager#preloadEffect preloadEffect}, you can call
   * this method to play the specified audio effect for all users in
   * the channel.
   *
   * This method plays only one specified audio effect each time it is called.
   * To play multiple audio effects, call this method multiple times.
   *
   * @note
   * - Agora recommends playing no more than three audio effects at the same time.
   * - The ID and file path of the audio effect in this method must be the same
   * as that in the {@link IAudioEffectManager#preloadEffect preloadEffect} method.
   *
   * @param soundId The ID of the audio effect.
   * @param filePath The absolute path of the local audio effect file or the URL
   *                 of the online audio effect file. Supported audio formats: mp3, mp4, m4a, aac,
   *                 3gp, mkv and wav.
   * @param loop The number of times the audio effect loops:
   * - `-1`: Play the audio effect in an indefinite loop until you call
   * {@link IAudioEffectManager#stopEffect stopEffect} or
   * {@link IAudioEffectManager#stopAllEffects stopAllEffects}.
   * - `0`: Play the audio effect once.
   * - `1`: Play the audio effect twice.
   * @param pitch The pitch of the audio effect. The value ranges between 0.5 and 2.0.
   * The default value is `1.0` (original pitch). The lower the value, the lower the pitch.
   * @param pan The spatial position of the audio effect. The value ranges between -1.0 and 1.0:
   *                  - `-1.0`: The audio effect shows on the left.
   *                  - `0.0`: The audio effect shows ahead.
   *                  - `1.0`: The audio effect shows on the right.
   * @param gain The volume of the audio effect. The value ranges between 0.0 and 100.0.
   *             The default value is `100` (original volume).The lower the value, the lower the
   * volume of the audio effect.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public int playEffect(
      int soundId, String filePath, int loop, double pitch, double pan, double gain);
  /**
   * Plays a specified audio effect.
   *
   * After calling {@link IAudioEffectManager#preloadEffect preloadEffect}, you can call
   * this method to play the specified audio effect for all users in
   * the channel.
   *
   * This method plays only one specified audio effect each time it is called.
   * To play multiple audio effects, call this method multiple times.
   *
   * @note
   * - Agora recommends playing no more than three audio effects at the same time.
   * - The ID and file path of the audio effect in this method must be the same
   * as that in the {@link IAudioEffectManager#preloadEffect preloadEffect} method.
   *
   * @param soundId   The ID of the audio effect..
   * @param filePath  The absolute path of the local audio effect file or the URL
   *                  of the online audio effect file. Supported audio formats: mp3, mp4, m4a, aac,
   *                  3gp, mkv and wav.
   * @param loopCount The number of times the audio effect loops:
   * - `-1`: Play the audio effect in an indefinite loop until you call
   * {@link IAudioEffectManager#stopEffect stopEffect} or
   * {@link IAudioEffectManager#stopAllEffects stopAllEffects}.
   * - `0`: Play the audio effect once.
   * - `1`: Play the audio effect twice.
   * @param pitch     The pitch of the audio effect. The value ranges between 0.5 and 2.0.
   * The default value is `1.0` (original pitch). The lower the value, the lower the pitch.
   * @param pan       The spatial position of the audio effect. The value ranges between -1.0
   *     and 1.0:
   *                  - `-1.0`: The audio effect shows on the left.
   *                  - `0.0`: The audio effect shows ahead.
   *                  - `1.0`: The audio effect shows on the right.
   * @param gain      The volume of the audio effect. The value ranges between 0.0 and 100.0.
   *                  The default value is `100` (original volume).The lower the value, the lower
   * the volume of the audio effect.
   * @param publish   Sets whether to publish the specified audio effect to the remote
   *                  stream:
   *                  - True: Publish the audio effect to the remote.
   *                  - False: false: Do not publish the audio effect to the remote.
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public int playEffect(int soundId, String filePath, int loopCount, double pitch, double pan,
      double gain, boolean publish);

  /**
   * Plays a specified audio effect.
   *
   * After calling {@link IAudioEffectManager##preloadEffect() preloadEffect}, you can call
   * this method to play the specified audio effect for all users in
   * the channel.
   *
   * This method plays only one specified audio effect each time it is called.
   * To play multiple audio effects, call this method multiple times.
   *
   * @note
   * - Agora recommends playing no more than three audio effects at the same time.
   * - The ID and file path of the audio effect in this method must be the same
   * as that in the {@link IAudioEffectManager##preloadEffect() preloadEffect} method.
   *
   * @param soundId   The ID of the audio effect.
   * @param filePath  The absolute path of the local audio effect file or the URL
   *                  of the online audio effect file. Supported audio formats: mp3, mp4, m4a, aac,
   *                  3gp, mkv and wav.
   * @param loopCount The number of times the audio effect loops:
   * - `-1`: Play the audio effect in an indefinite loop until you call {@link
   * IAudioEffectManager##stopEffect() stopEffect} or {@link RtcEngine#stopAllEffects()
   * stopAllEffects}.
   * - `0`: Play the audio effect once.
   * - `1`: Play the audio effect twice.
   * @param pitch     The pitch of the audio effect. The value ranges between 0.5 and 2.0.
   * The default value is 1.0 (original pitch). The lower the value, the lower the pitch.
   * @param pan       The spatial position of the audio effect. The value ranges between -1.0
   * and 1.0:
   *                  - `-1.0`: The audio effect shows on the left.
   *                  - `0.0`: The audio effect shows ahead.
   *                  - `1.0`: The audio effect shows on the right.
   * @param gain      The volume of the audio effect. The value ranges between 0.0 and 100.0.
   *                  The default value is 100 (original volume). The lower the value, the lower
   * the volume of the audio effect.
   * @param publish   Sets whether to publish the specified audio effect to the remote
   *                  stream:
   *                  - True: Publish the audio effect to the remote.
   *                  - False: false: Do not publish the audio effect to the remote.
   * @param startPos  The start position
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public int playEffect(int soundId, String filePath, int loopCount, double pitch, double pan,
      double gain, boolean publish, int startPos);

  /**
   * Stops playing the specific audio effect.
   *
   * @param soundId The ID of the audio effect.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public int stopEffect(int soundId);

  /**
   * Stops playing all audio effects.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public int stopAllEffects();

  /**
   * Preloads a specified audio effect.
   *
   * This method preloads only one specified audio effect into the memory each time
   * it is called. To preload multiple audio effects, call this method multiple times.
   *
   * After preloading, you can call {@link IAudioEffectManager#playEffect playEffect}
   * to play the preloaded audio effect.
   *
   * @note
   * - To ensure smooth communication, limit the size of the audio effect file.
   * - Agora recommends calling this method before joining the channel.
   *
   * @param soundId  The ID of the audio effect.
   * @param filePath The absolute path of the local audio effect file or the URL
   * of the online audio effect file. Supported audio formats: mp3, mp4, m4a, aac,
   * 3gp, mkv and wav.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public int preloadEffect(int soundId, String filePath);

  /**
   * Preloads a specified audio effect.
   *
   * This method preloads only one specified audio effect into the memory each time
   * it is called. To preload multiple audio effects, call this method multiple times.
   *
   * After preloading, you can call {@link IAudioEffectManager##playEffect() playEffect} to play the
   * preloaded audio effect or call
   * {@link IAudioEffectManager##playAllEffects() playAllEffects} to play all the preloaded audio
   * effects.
   *
   * @note
   * - To ensure smooth communication, limit the size of the audio effect file.
   * - Agora recommends calling this method before joining the channel.
   *
   * @param soundId  The ID of the audio effect.
   * @param filePath The absolute path of the local audio effect file or the URL
   * @param startPos The start position
   * of the online audio effect file. Supported audio formats: mp3, mp4, m4a, aac,
   * 3gp, mkv and wav.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public int preloadEffect(int soundId, String filePath, int startPos);

  /**
   * Releases the specific preloaded audio effect from the memory.
   *
   * @param soundId The ID of the audio effect.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public int unloadEffect(int soundId);

  /**
   * Pauses playing the specified audio effect.
   *
   * @param soundId The ID of the audio effect.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public int pauseEffect(int soundId);

  /**
   * Pauses playing all audio effects.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public int pauseAllEffects();

  /**
   * Resumes playing the specific audio effect.
   *
   * @param soundId The ID of the audio effect.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public int resumeEffect(int soundId);

  /**
   * Resumes playing all audio effects.
   *
   * @return
   * - 0: Success.
   * - < 0: Failure.
   */
  public int resumeAllEffects();
}
/// @endcond
