package io.agora.rtc2;

import org.json.JSONException;
import org.json.JSONObject;

import io.agora.rtc2.internal.Logging;
import io.agora.rtc2.live.LiveTranscoding;

/** Push-stream methods.
 *
 * <p>Before calling the methods listed in this section:
 * <ul>
 *     <li>Ensure that the CDN push-stream function is enabled by contacting Agora.
 *     <li>Ensure that only the user, who has called {@link RtcEngine#setClientRole(int) setClientRole} and set the user role as the host, can use the methods in this section.
 *     <li>Ensure that {@link RtcEngine#setLiveTranscoding() setLiveTranscoding} is called before {@link RtcEngine#addPublishStreamUrl() addPublishStreamUrl}.
 * </ul>
 *
 */
public class PublisherConfiguration {
    private JSONObject jsonObject;

    public boolean validate() {
        return jsonObject != null;
    }

    public String toJsonString() {
        if (validate()) {
            return jsonObject.toString();
        } else {
            return null;
        }
    }

    private PublisherConfiguration(Builder builder) {
        try {
            jsonObject = new JSONObject()
                    .put("owner", builder.params.owner)
                    .put("lifecycle", builder.params.lifecycle)
                    .put("defaultLayout", builder.params.defaultLayout)
                    .put("width", builder.params.width)
                    .put("height", builder.params.height)
                    .put("framerate", builder.params.framerate)
                    .put("bitrate", builder.params.bitrate)
                    .put("mosaicStream", builder.params.publishUrl)
                    .put("rawStream", builder.params.rawStreamUrl)
                    .put("extraInfo", builder.params.extraInfo);
            if (builder.params.injectStreamUrl != null &&
                    builder.params.injectStreamWidth != 0 &&
                    builder.params.injectStreamHeight != 0) {
                jsonObject.put("injectInfo", new JSONObject()
                        .put("injectStream", builder.params.injectStreamUrl)
                        .put("width", builder.params.injectStreamWidth)
                        .put("height", builder.params.injectStreamHeight));
            }
        } catch (JSONException e) {
            jsonObject = null;
            Logging.e("failed to create PublisherConfiguration");
        }
    }

    /** Builder class.
     * @deprecated
     *
     * <p>If you want to configure the push-stream, Agora recommends using the {@link RtcEngine#setLiveTranscoding(LiveTranscoding) setLiveTranscoding} method.
     *
     */
    public static class Builder {

        private PublisherParameters params;

        public Builder() {
            params = new PublisherParameters();
        }

        /** Sets the RTMP stream owner.
         *
         * <p>In the Builder Class, this method sets whether the current host is the RTMP stream owner.</p>
         *
         * @param isRoomOwner
         * <ul>
         *     <li>True: Yes (default), push-stream configuration.
         *     <li>False: No push-stream configuration.
         * </ul>
         * @return
         * <ul>
         *     <li>0: Success.
         *     <li><0: Failure.
         * </ul>
         */
        public Builder owner(boolean isRoomOwner) {
            this.params.owner = isRoomOwner;
            return this;
        }

        /** CDN push stream life cycle
         *
         * <p>You can choose:
         * <ul>
         *     <li>Bind to channel (STREAM_LIFE_CYCLE_BIND2CHANNEL) or
         *     <li>Bind to room owner (STREAM_LIFE_CYCLE_BIND2OWNER).
         * </ul>
         */
        public Builder streamLifeCycle(int lifecycle) {
            this.params.lifecycle = lifecycle;
            return this;
        }

        /** Sets the stream resolution.
         *
         * <p>In the Builder Class, this method sets the resolution of the output data stream set for CDN Live.
         *
         * @param width Width of the output data stream set for CDN Live. 360 is the default value.
         * @param height Height of the output data stream set for CDN Live. 640 is the default value.
         * @return <ul><li>0: Success.<li><0: Failure.</ul>
         */
        public Builder size(int width, int height) {
            this.params.width = width;
            this.params.height = height;
            return this;
        }

        /** Sets the stream's frame rate.
         *
         * <p>In the Builder class, this method sets the frame rate of the output data stream set for CDN Live.
         *
         * @param framerate Frame rate of the output data stream set for CDN Live. 15 fps is the default value.
         * @return <ul><li>0: Success.<li><0: Failure.</ul>
         */
        public Builder frameRate(int framerate) {
            this.params.framerate = framerate;
            return this;
        }

        /** Sets the stream's bitrate.
         *
         * <p>In the Builder class, this method sets the bitrate of the output data stream set for CDN Live.
         *
         * @param bitrate Bitrate of the output data stream set for CDN Live. 500 kbit/s is the default value.
         * @return <ul><li>0: Success.<li><0: Failure.</ul>
         */
        public Builder bitRate(int bitrate) {
            this.params.bitrate = bitrate;
            return this;
        }

        /** Sets the default layout.
         *
         * <p>In the Builder class, this method sets the default layout if you do not use flexible adjustment.
         *
         * @param layoutStyle <ul><li>0: Tile horizontally
       </li><li> 1: Layered windows
        </li><li>2: Tile vertically</li></ul>
         * @return <ul><li>0: Success.<li><0: Failure.</ul>
         */
        public Builder defaultLayout(int layoutStyle) {
            this.params.defaultLayout = layoutStyle;
            return this;
        }

        /** Sets the publishing URL.
         *
         * <p>In the Builder class, this method configures the push-stream address for the picture-in-picture layouts.
         *
         * @param url Configures the push-stream address for the picture-in-picture layouts. The default value is NULL.
         * @return <ul><li>0: Success.<li><0: Failure.</ul>
         */
        public Builder publishUrl(String url) {
            this.params.publishUrl = url;
            return this;
        }

        /** Sets the raw stream URL.
         *
         * <p>In the Builder class, this method sets the push-stream address of the original stream which does not require picture-blending.
         *
         * @param url Push-stream address of the original stream. The default value is NULL.
         * @return <ul><li>0: Success.<li><0: Failure.</ul>
         */
        public Builder rawStreamUrl(String url) {
            this.params.rawStreamUrl = url;
            return this;
        }

        /** Sets the inject stream.
         *
         * <p>In the Builder class, this method injects a stream to the current channel.
         *
         * @param url URL address of the stream to be injected to the channel.
         * @param width Width of the stream. N/A, set as 0.
         * @param height Height of the stream. N/A, set as 0.
         * @return <ul><li>0: Success.<li><0: Failure.</ul>
         */
        public Builder injectStream(String url, int width, int height) {
            if (url != null && width != 0 && height != 0) {
                this.params.injectStreamUrl = url;
                this.params.injectStreamWidth = width;
                this.params.injectStreamHeight = height;
            }
            return this;
        }

        /** Adds extra information.
         *
         * @param optionalInfo Reserved Field. The default value is NULL.
         * @return <ul><li>0: Success.<li><0: Failure.</ul>
         */
        public Builder extraInfo(String optionalInfo) {
            this.params.extraInfo = optionalInfo;
            return this;
        }

        public PublisherConfiguration build() {
            return new PublisherConfiguration(this);
        }
    }
}
