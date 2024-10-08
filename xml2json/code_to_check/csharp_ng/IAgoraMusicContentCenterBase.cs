using System;

namespace Agora.Rtc
{
    ///
    /// <summary>
    /// The loading statuses of music assets.
    /// </summary>
    ///
    public enum PreloadStatusCode
    {
        ///
        /// <summary>
        /// 0: The preload of music assets is complete.
        /// </summary>
        ///
        kPreloadStatusCompleted = 0,

        ///
        /// <summary>
        /// 1: The preload of music assets fails.
        /// </summary>
        ///
        kPreloadStatusFailed = 1,

        ///
        /// <summary>
        /// 2: The music assets are preloading.
        /// </summary>
        ///
        kPreloadStatusPreloading = 2,

        kPreloadStatusRemoved = 3,
    };

    ///
    /// @ignore
    ///
    public enum MusicContentCenterStatusCode
    {
        ///
        /// @ignore
        ///
        kMusicContentCenterStatusOk = 0,

        ///
        /// @ignore
        ///
        kMusicContentCenterStatusErr = 1,

        kMusicContentCenterStatusErrGateway = 2,

        kMusicContentCenterStatusErrPermissionAndResource = 3,

        kMusicContentCenterStatusErrInternalDataParse = 4,

        kMusicContentCenterStatusErrMusicLoading = 5,

        kMusicContentCenterStatusErrMusicDecryption = 6,
    };

    ///
    /// @ignore
    ///
    public class MusicChartInfo
    {
        ///
        /// @ignore
        ///
        public string chartName;

        ///
        /// @ignore
        ///
        public int id;
    };

    public enum MUSIC_CACHE_STATUS_TYPE
    {
        MUSIC_CACHE_STATUS_TYPE_CACHED = 0,

        MUSIC_CACHE_STATUS_TYPE_CACHING = 1
    };

    public class MusicCacheInfo
    {
        public Int64 songCode;

        public MUSIC_CACHE_STATUS_TYPE status;

        public MusicCacheInfo()
        {
            songCode = 0;
            status = MUSIC_CACHE_STATUS_TYPE.MUSIC_CACHE_STATUS_TYPE_CACHED;
        }

        public MusicCacheInfo(Int64 songCode, MUSIC_CACHE_STATUS_TYPE status)
        {
            this.songCode = songCode;
            this.status = status;
        }
    };

    ///
    /// @ignore
    ///
    public class MvProperty
    {
        ///
        /// @ignore
        ///
        public string resolution;

        ///
        /// @ignore
        ///
        public string bandwidth;
    };

    ///
    /// <summary>
    /// The climax parts of the music.
    /// </summary>
    ///
    public class ClimaxSegment
    {
        ///
        /// <summary>
        /// The time (ms) when the climax part begins.
        /// </summary>
        ///
        public int startTimeMs;

        ///
        /// <summary>
        /// The time (ms) when the climax part ends.
        /// </summary>
        ///
        public int endTimeMs;
    };

    ///
    /// @ignore
    ///
    public class Music
    {
        ///
        /// @ignore
        ///
        public Int64 songCode;

        ///
        /// @ignore
        ///
        public string name;

        ///
        /// @ignore
        ///
        public string singer;

        ///
        /// @ignore
        ///
        public string poster;

        ///
        /// @ignore
        ///
        public string releaseTime;

        ///
        /// @ignore
        ///
        public int durationS;

        ///
        /// @ignore
        ///
        public int type;

        ///
        /// @ignore
        ///
        public int pitchType;
        ///
        /// @ignore
        ///
        public int lyricCount;

        ///
        /// @ignore
        ///
        public int[] lyricList;

        ///
        /// @ignore
        ///
        public int climaxSegmentCount;

        ///
        /// @ignore
        ///
        public ClimaxSegment[] climaxSegmentList;

        ///
        /// @ignore
        ///
        public int mvPropertyCount;

        ///
        /// @ignore
        ///
        public MvProperty[] mvPropertyList;
    }

    ///
    /// @ignore
    ///
    public class MusicCollection
    {
        ///
        /// @ignore
        ///
        public int count;
        ///
        /// @ignore
        ///
        public int total;
        ///
        /// @ignore
        ///
        public int page;
        ///
        /// @ignore
        ///
        public int pageSize;
        ///
        /// @ignore
        ///
        public Music[] music;
    };

    ///
    /// @ignore
    ///
    public class MusicContentCenterConfiguration
    {
        ///
        /// @ignore
        ///
        public string appId;

        ///
        /// @ignore
        ///
        public string token;

        ///
        /// @ignore
        ///
        public UInt64 mccUid;


        public UInt32 maxCacheSize;

        public MusicContentCenterConfiguration()
        {
            appId = "";
            token = "";
            mccUid = 0;
            maxCacheSize = 10;
        }

        public MusicContentCenterConfiguration(string appId, string token, UInt64 uid, UInt32 maxCacheSize)
        {
            this.appId = appId;
            this.token = token;
            this.mccUid = uid;
            this.maxCacheSize = maxCacheSize;
        }
    }
}