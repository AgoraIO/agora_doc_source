---
title: Native SDK 相关
platform: Native SDK 相关
updatedAt: 2018-11-02 12:05:43
---
## Crash问题处理
SDK crash问题属于稳定性问题，具体处理方案请参见《音视频核心问题专项》中“稳定性”章节：稳定性（LinShuo）

## 连通性问题处理
客户端掉线问题排查及处理方案

## 错误码汇总

### Audio音频错误码

SDK 2.1 以后用户可以收到onError／onWarning，用户只会看到高级错误提示，具体参见：ADM/VDM Error Code

以下是内部的错误码，这些错误码发生时候可以在Log和Argus查到，但是不再通过回调通知用户：

CE_CHANNEL_NOT_VALID                                                           =8002//频道号不合法【处理方法】：确认频道号
CE_FUNC_NOT_SUPPORTED                                                        =8003//该功能不支持
CE_INVALID_LISTNR                                                                       =8004//无效参数【处理方法】：确认参数有效性
CE_INVALID_ARGUMENT                                                               =8005//无效参数【处理方法】：确认参数有效性
CE_INVALID_PORT_NMBR                                                             =8006//无效端口【处理方法】：反馈给SDK
CE_NOT_SUPPORTED                                                                     =8011//不支持
CE_CHANNEL_NOT_CREATED                                                       =8013//频道未创建【处理方法】：反馈给SDK
CE_MAX_ACTIVE_CHANNELS_REACHED                                      =8014//无可用频道【处理方法】：反馈给SDK
CE_REC_CANNOT_PREPARE_HEADER                                           =8015//录音失败【处理方法】：确认竞品
CE_REC_CANNOT_ADD_BUFFER                                                   =8016//录音失败【处理方法】：确认竞品
CE_PLAY_CANNOT_PREPARE_HEADER                                         =8017//播放失败【处理方法】：确认竞品
CE_ALREADY_SENDING                                                                 =8018//接口重复调用【处理方法】：反馈给SDK
CE_INVALID_IP_ADDRESS                                                              =8019//无效IP地址【处理方法】：反馈给SDK
CE_ALREADY_PLAYING                                                                  =8020//接口重复调用【处理方法】：反馈给SDK
CE_NOT_ALL_VERSION_INFO                                                        =8021//版本信息不全【处理方法】：反馈给SDK
CE_DTMF_OUTOF_RANGE                                                             =8022//参数错误【处理方法】：反馈给SDK
CE_INVALID_CHANNELS                                                                =8023//无效频道【处理方法】：反馈给SDK
CE_ENCRYPT_NOT_INITED                                                             =8025//加密未初始化【处理方法】：反馈给SDK
CE_NOT_INITED                                                                              =8026//未初始化【处理方法】：反馈给SDK
CE_NOT_SENDING                                                                         =8027//未发送【处理方法】：反馈给SDK
CE_EXT_TRANSPORT_NOT_SUPPORTED                                      =8028//第三方传输不支持【处理方法】：反馈给SDK
CE_EXTERNAL_TRANSPORT_ENABLED                                         =8029//第三方传输已开启【处理方法】：反馈给SDK
CE_STOP_RECORDING_FAILED                                                      =8030//停止录音失败【处理方法】：反馈给音频组
CE_INVALID_RATE                                                                          =8031//无效码率【处理方法】：反馈给SDK
CE_INVALID_PACKET                                                                      =8032//无效网络数据包【处理方法】：反馈给SDK
CE_NO_GQOS                                                                                 =8033//无QS【处理方法】：反馈给SDK
CE_INVALID_TIMESTAMP                                                              =8034//无效时间戳【处理方法】：反馈给SDK
CE_RECEIVE_PACKET_TIMEOUT                                                     =8035//接收数据包超时【处理方法】：反馈给SDK
CE_STILL_PLAYING_PREV_DTMF                                                   =8036//DTMF尚未播放完成【处理方法】：反馈给SDK
CE_INIT_FAILED_WRONG_EXPIRY                                                 =8037//
CE_SENDING                                                                                   =8038//接口重复调用【处理方法】：反馈给SDK
CE_ENABLE_IPV6_FAILED                                                               =8039//IPV6使用失败【处理方法】：反馈给SDK
CE_FUNC_NO_STEREO                                                                   =8040//不支持立体声【处理方法】：反馈给音频组
// Range 8041-8080 is not used
CE_NOT_ALL_INFO                                                                         =8083//信息不全【处理方法】：反馈给SDK
CE_CANNOT_SET_SEND_CODEC                                                    =8084//编码设置失败【处理方法】：反馈给SDK
CE_CODEC_ERROR                                                                         =8085//编码错误【处理方法】：反馈给音频组
CE_NETEQ_ERROR                                                                          =8086//NETEQ错误【处理方法】：反馈给SDK
CE_RTCP_ERROR                                                                             =8087//RTCP错误【处理方法】：反馈给SDK
CE_INVALID_OPERATION                                                              =8088//无效操作【处理方法】：反馈给SDK
CE_CPU_INFO_ERROR                                                                    =8089//CPU信息错误【处理方法】：反馈给SDK
CE_SOUNDCARD_ERROR                                                               =8090//声卡错误【处理方法】：反馈给音频组
CE_SEND_ERROR                                                                            =8092//发送失败【处理方法】：反馈给SDK
CE_CANNOT_REMOVE_CONF_CHANNEL                                     =8093//移除会议频道失败【处理方法】：反馈给SDK
CE_SET_FEC_FAILED                                                                        =8095//设置FEC错误【处理方法】：反馈给SDK
CE_CANNOT_GET_PLAY_DATA                                                    =8096//无法获取播放数据【处理方法】：反馈给SDK
CE_APM_ERROR                                                                             =8097//APM错误【处理方法】：反馈给SDK
CE_NOT_PLAYING                                                                          =8100//未播放【处理方法】：反馈给SDK
CE_SOCKETS_NOT_INITED                                                             =8101//网络未始化【处理方法】：反馈给SDK
CE_CANNOT_GET_SOCKET_INFO                                                  =8102//无法获取网路信息【处理方法】：反馈给SDK
CE_INVALID_MULTICAST_ADDRESS                                             =8103//无效多网卡地址【处理方法】：反馈给SDK
CE_DESTINATION_NOT_INITED                                                   =8104//网路未初始化【处理方法】：反馈给SDK
CE_RECEIVE_SOCKETS_CONFLICT                                                 =8105//网络接收冲突【处理方法】：反馈给SDK
CE_SEND_SOCKETS_CONFLICT                                                     =8106//网络冲突【处理方法】：反馈给SDK
CE_TYPING_NOISE_WARNING                                                      =8107//键盘声告警【处理方法】：反馈给SDK
CE_SATURATION_WARNING                                                         =8108//溢出告警【处理方法】：反馈给SDK
CE_NOISE_WARNING                                                                     =8109//噪声过大【处理方法】：反馈给SDK
CE_CANNOT_GET_SEND_CODEC                                                  =8110//获取不到发送codec【处理方法】：反馈给频谱组
CE_CANNOT_GET_REC_CODEC                                                     =8111//获取不到接收codec【处理方法】：反馈给音频组
CE_ALREADY_INITED                                                                      =8112//重复调用接口【处理方法】：反馈给SDK
CE_CANNOT_SET_SECONDARY_SEND_CODEC                            =8113//无法设置冗余codec【处理方法】：反馈给SDK
CE_CANNOT_GET_SECONDARY_SEND_CODEC                           =8114//无法获取冗余codec【处理方法】：反馈给SDK
CE_CANNOT_REMOVE_SECONDARY_SEND_CODEC                   =8115//无法删除冗余codec【处理方法】：反馈给SDK
CE_TYPING_NOISE_OFF_WARNING                                              =8116//键盘噪声消失
// Errors causing limited functionality
CE_RTCP_SOCKET_ERROR                                                              =9001//RTCP包错误【处理方法】：反馈给SDK
CE_MIC_VOL_ERROR                                                                       =9002//麦克风音量错误【处理方法】：确认竞品
CE_SPEAKER_VOL_ERROR                                                              =9003//扬声器音量错误【处理方法】：确认竞品
CE_CANNOT_ACCESS_MIC_VOL                                                    =9004//无法获取麦克风音量【处理方法】：确认竞品
CE_CANNOT_ACCESS_SPEAKER_VOL                                           =9005//无法获取扬声器音量【处理方法】：确认竞品
CE_GET_MIC_VOL_ERROR                                                              =9006//获取麦克风音量出错【处理方法】：确认竞品
CE_GET_SPEAKER_VOL_ERROR                                                      =9007//获取扬声器音量出错【处理方法】：确认竞品
CE_THREAD_RTCP_ERROR                                                             =9008//RTCP线程错误【处理方法】：反馈给SDK
CE_CANNOT_INIT_APM                                                                 =9009//APM初始化失败【处理方法】：反馈给SDK
CE_SEND_SOCKET_TOS_ERROR                                                     =9010//网络发送优先级设置失败【处理方法】：反馈给SDK
CE_CANNOT_RETRIEVE_DEVICE_NAME                                        =9013//获取设备名称失败【处理方法】：反馈给SDK
CE_SRTP_ERROR                                                                             =9014//加密失败【处理方法】：反馈给SDK
// 9015 is not used
CE_INTERFACE_NOT_FOUND                                                        =9016//未找到接口【处理方法】：反馈给SDK
CE_TOS_GQOS_CONFLICT                                                             =9017//网络优先级设置冲突【处理方法】：反馈给SDK
CE_CANNOT_ADD_CONF_CHANNEL                                            =9018//会议加入频道失败【处理方法】：反馈给SDK
CE_BUFFER_TOO_SMALL                                                               =9019//Buffer太小【处理方法】：反馈给SDK
// 9022 is not used
CE_RTP_KEEPALIVE_FAILED                                                           =9023//RTP保持失败【处理方法】：反馈给SDK
CE_SEND_DTMF_FAILED                                                                =9024//DTMF发送失败【处理方法】：反馈给SDK
CE_CANNOT_RETRIEVE_CNAME                                                   =9025//无法获取私有名称【处理方法】：反馈给SDK
CE_DECRYPTION_FAILED                                                               =9026//解密失败【处理方法】：反馈给SDK
CE_ENCRYPTION_FAILED                                                               =9027//加密失败【处理方法】：反馈给SDK
CE_GQOS_ERROR                                                                           =9029//网络优先级出错【处理方法】：反馈给SDK
CE_BINDING_SOCKET_TO_LOCAL_ADDRESS_FAILED                  =9030//网络错误【处理方法】：反馈给SDK
CE_TOS_INVALID                                                                            =9031//无效参数【处理方法】：反馈给SDK
CE_TOS_ERROR                                                                              =9032//优先级设置错误【处理方法】：反馈给SDK
CE_CANNOT_INIT_ADM                                                                 =9034//ADM失败【处理方法】：反馈给SDK
CE_CANNOT_INIT_ACM                                                                 =9035//ACM【处理方法】：反馈给SDK
// Critical errors that stops voice functionality
CE_PLAY_UNDEFINED_SC_ERR                                                      =10001//播放设备错误【处理方法】：反馈给SDK
CE_REC_CANNOT_OPEN_SC                                                          =10002//采集设备打开失败【处理方法】：反馈给SDK
CE_SOCKET_ERROR                                                                        =10003//网络错误【处理方法】：反馈给SDK
CE_ERR_ADM_WIN_WAVE_INVALHANDLE                                   =10004//音频设备无效句柄【处理方法】：确认竞品
CE_ERR_ADM_WIN_WAVE_NODRIVER                                         =10005//无音频驱动【处理方法】：确认竞品
CE_ERR_ADM_WIN_WAVE_NOMEM                                             =10006//内存不够【处理方法】：反馈给SDK
CE_WAVERR_UNPREPARED                                                           =10007//缓冲区未准备好【处理方法】：反馈给SDK
CE_WAVERR_STILLPLAYING                                                          =10008//播放未停止【处理方法】：反馈给SDK
CE_UNDEFINED_SC_ERR                                                                =10009//播放音频设备错误【处理方法】：反馈给SDK
CE_UNDEFINED_SC_REC_ERR                                                        =10010//录音设备错误【处理方法】：确认竞品
CE_THREAD_ERROR                                                                       =10011//线程错误【处理方法】：反馈给SDK
CE_CANNOT_START_RECORDING                                               =10012//启动录音失败【处理方法】：确认竞品
CE_PLAY_CANNOT_OPEN_SC                                                        =10013//无法打开音频设备【处理方法】：确认竞品
CE_NO_WINSOCK_2                                                                       =10014//缺少网络堆栈【处理方法】：反馈给SDK
CE_SEND_SOCKET_ERROR                                                             =10015//发送网络失败【处理方法】：反馈给SDK
CE_BAD_FILE                                                                                   =10016//无效文件【处理方法】：反馈给SDK
CE_NOT_AUTHORISED                                                                   =10018//无权限【处理方法】：反馈给SDK
CE_BAD_ARGUMENT                                                                     =10021//无效参数【处理方法】：反馈给SDK
CE_LINUX_API_ONLY                                                                      =10022//API错误【处理方法】：反馈给SDK
CE_REC_DEVICE_REMOVED                                                           =10023//录音设备不存在【处理方法】：确认竞品
CE_NO_MEMORY                                                                           =10024//无内存【处理方法】：反馈给SDK
CE_BAD_HANDLE                                                                           =10025//无效句柄【处理方法】：反馈给SDK
CE_RTP_RTCP_MODULE_ERROR                                                    =10026//RTCP模块错误【处理方法】：反馈给SDK
CE_AUDIO_CODING_MODULE_ERROR                                         =10027//编码模块错误【处理方法】：反馈给音频组
CE_AUDIO_DEVICE_MODULE_ERROR                                           =10028//设备模块错误【处理方法】：反馈给音频组
CE_CANNOT_START_PLAYOUT                                                     =10029//启动播放失败【处理方法】：反馈给音频组
CE_CANNOT_STOP_RECORDING                                                  =10030//停止录音设备失败【处理方法】：反馈给SDK
CE_CANNOT_STOP_PLAYOUT                                                       =10031//停止播放设备失败【处理方法】：反馈给音频组
CE_CANNOT_INIT_CHANNEL                                                        =10032//初始化频道失败【处理方法】：反馈给SDK
CE_RECV_SOCKET_ERROR                                                             =10033//网络错误【处理方法】：反馈给SDK
CE_SOCKET_TRANSPORT_MODULE_ERROR                                 =10034//网络模块错误【处理方法】：反馈给SDK
CE_AUDIO_CONF_MIX_MODULE_ERROR                                     =10035//混音模块错误【处理方法】：反馈给音频组
CE_NULL_FILE_POINTER                                                                 =10036//无效文件输入【处理方法】：反馈给SDK
CE_OBJ_CREATE_ERROR                                                                =10037//对象创建失败【处理方法】：反馈给SDK
CE_OBJ_INIT_ERROR                                                                      =10038//对象初始化失败【处理方法】：反馈给SDK
CE_OBJ_FREE_ERROR                                                                     =10039//对象释放失败【处理方法】：反馈给SDK
ERR_FAILED                                                                         = -1,//未知错误【处理方法】：反馈SDK
ERR_INVALID_ARGUMENT                                                    = 2,//无效的参数【处理方法】：收集LOG反馈音频组
ERR_NOT_READY                                                                = -3,//尚未加入频道【处理方法】：反馈SDK
ERR_NOT_SUPPORTED                                                        = 4,//功能不支持
ERR_REFUSED                                                                    = 5,//服务请求失败【处理方法】：收集LOG反馈音频组
ERR_BUFFER_TOO_SMALL                                                     = 6,//Buffer过小【处理方法】：收集LOG反馈音频组
ERR_NOT_INITIALIZED                                                          = 7,//初始化失败 【处理方法】：收集LOG反馈音频组
ERR_INVALID_VIEW                                                             = 8,//无效窗口【处理方法】：建议客户排查
ERR_INVALID_VENDOR_KEY                                                  = 101,//无效的KEY 【处理方法】：确认KEY的正确性
ERR_INVALID_CHANNEL_NAME                                            = 102,//无效的频道名 【处理方法】：确认频道名正确性
ERR_NO_AVAILABLE_CHANNEL                                             = 103,//无可用频道 【处理方法】：反馈媒体后台处理
ERR_LOOKUP_CHANNEL_TIMEOUT                                        = 104,//加入频道超时 【处理方法】：确认网络是否正常
ERR_LOOKUP_CHANNEL_REJECTED                                      = 105,//拒绝加入频道 【处理方法】：确认ClientRole是否一致
ERR_OPEN_CHANNEL_TIMEOUT                                            = 106,//创建 频道超时 【处理方法】：确认网络是否正常
ERR_OPEN_CHANNEL_REJECTED                                           = 107,// 创建频道失败 【处理方法】：确认ClientRole是否一致
ERR_LOAD_MEDIA_ENGINE                                                  = 1001,//获取媒体引擎失败【处理方法】：收集LOG反馈音频组
ERR_START_CALL                                                                 = 1002,//启动失败【处理方法】：收集LOG反馈音频组
ERR_START_CAMERA                                                           = 1003,//打开摄像头失败【处理方法】：收集LOG反馈视频组
ERR_START_VIDEO_RENDER                                                  = 1004,//渲染视频失败【处理方法】：收集LOG反馈视频组
ERR_ADM_GENERAL                                                           = 1005,//音频设备错误【处理方法】：确认竞品是否正常
ERR_ADM_JAVA_RESOURCE                                                 = 1006,//JAVA无可用资源 【处理方法】：确认内存是否够用，重启设备
ERR_ADM_SAMPLE_RATE                                                     = 1007,//采样频率不对 【处理方法】：收集LOG和机型反馈音频组
ERR_ADM_INIT_PLAYOUT                                                     = 1008,//播放设备初始化失败 【处理方法】：收集LOG反馈音频组
ERR_ADM_START_PLAYOUT                                                 = 1009,//播放设备启动失败 【处理方法】：收集LOG 反馈音频组
ERR_ADM_STOP_PLAYOUT                                                    = 1010,//播放设备停止失败 【处理方法】：收集LOG反馈音频组
ERR_ADM_INIT_RECORDING                                                 = 1011,//采集设备初始化失败 【处理方法】：收集LOG反馈音频组
ERR_ADM_START_RECORDING                                             = 1012,//采集设备启动失败 【处理方法】：收集LOG反馈音频组
ERR_ADM_STOP_RECORDING                                               = 1013,//采集设备停止失败 【处理方法】：收集LOG反馈音频组
ERR_ADM_RUNTIME_PLAYOUT_WARNING                             = 1014,//播放告警【处理方法】：收集LOG和机型反馈音频组
ERR_ADM_RUNTIME_PLAYOUT_ERROR                                  = 1015,//播放出错【处理方法】：收集LOG和机型反馈音频组
ERR_ADM_RUNTIME_RECORDING_WARNING                         = 1016,//录音告警【处理方法】：收集LOG和机型反馈音频组
ERR_ADM_RUNTIME_RECORDING_ERROR                              = 1017,//录音出错【处理方法】：收集LOG和机型反馈音频组
ERR_ADM_RECORD_AUDIO_FAILED                                       = 1018,//音频采集失败【处理方法】：确认权限是否打开，或者是否被第三方占用
ERR_ADM_RECORD_AUDIO_IS_ACTIVE                               = 1033//设备被占用【处理方法】：确认权限是否打开，或者是否被第三方占用
ERR_ADM_INIT_LOOPBACK                                                  = 1022,//LOOPBACK初始化失败【处理方法】：收集LOG反馈音频组
ERR_ADM_START_LOOPBACK                                                = 1023,// LOOPBACK初始化启动失败【处理方法】：收集LOG反馈音频组
ERR_ADM_STOP_LOOPBACK                                                = 1024, // LOOPBACK初始化停止失败【处理方法】：收集LOG反馈音频组
// 1025, as warning for interruption of adm on ios
// 1026, as warning for route change of adm on ios
ERR_ADM_NO_PERMISSION                                                 = 1027,//无录音权限 【处理方法】：检查录音权限是否打开或者被第三方应用占用
// Android platform errors
// JNI errors
ERR_ADM_ANDROID_JNI_JAVA_RESOURCE                             = 1101, //JAVA无可用资源 【处理方法】：确认内存是否够用，重启设备
ERR_ADM_ANDROID_JNI_INIT_SAMPLE_RATE                          = 1102, //采样频率不对 【处理方法】：收集LOG和机型反馈音频组
ERR_ADM_ANDROID_JNI_INIT_MAX_VOLUME                         = 1103,//无音频设置权限【处理方法】：确认音频设置权限
ERR_ADM_ANDROID_JNI_CREATE_RECORD_THREAD                = 1104,//线程初始化失败【处理方法】：收集LOG和机型反馈音频组
ERR_ADM_ANDROID_JNI_CREATE_PLAYBACK_THREAD             = 1105,//播放线程初始化失败【处理方法】：收集LOG和机型反馈音频组
ERR_ADM_ANDROID_JNI_START_RECORD_THREAD                 = 1106,//线程启动失败【处理方法】：收集LOG和机型反馈音频组
ERR_ADM_ANDROID_JNI_START_PLAYBACK_THREAD              = 1107,//播放线程启动失败【处理方法】：收集LOG和机型反馈音频组
ERR_ADM_ANDROID_JNI_NO_RECORD_FREQUENCY               = 1108,//采集频率错误【处理方法】：收集LOG和机型反馈音频组
ERR_ADM_ANDROID_JNI_NO_PLAYBACK_FREQUENCY             = 1109//播放频率错误【处理方法】：收集LOG和机型反馈音频组
ERR_ADM_ANDROID_JNI_JAVA_INIT_PLAYBACK                       = 1110,//播放初始化失败【处理方法】：收集LOG和机型反馈音频组
ERR_ADM_ANDROID_JNI_JAVA_START_RECORD                      = 1111,//录音启动失败【处理方法】：收集LOG和机型反馈音频组
ERR_ADM_ANDROID_JNI_JAVA_START_PLAYBACK                   = 1112,//播放启动失败【处理方法】：收集LOG和机型反馈音频组
ERR_ADM_ANDROID_JNI_JAVA_STOP_RECORD                       = 1113,//录音终止失败【处理方法】：收集LOG和机型反馈音频组
ERR_ADM_ANDROID_JNI_JAVA_STOP_PLAYBACK                     = 1114,//播放终止失败【处理方法】：收集LOG和机型反馈音频组
ERR_ADM_ANDROID_JNI_JAVA_RECORD_ERROR                   = 1115//录音失败【处理方法】：确认权限，确认网络
// iOS platform errors
ERR_ADM_IOS_INPUT_NOT_AVAILABLE                                    = 1201,//无法获取音频输入设备【处理方法】：收集LOG和机型反馈音频组
ERR_ADM_IOS_CREATE_INSTANCE_FAIL                                    = 1208,//IOS-VPIO创建失败【处理方法】：收集LOG和机型反馈音频组
ERR_ADM_IOS_VPIO_INIT_FAIL                                                = 1210,//VPIO初始化失败【处理方法】：收集LOG和机型反馈音频组
ERR_ADM_IOS_VPIO_STOP_FAIL                                              = 1211,//VPIO终止失败【处理方法】：收集LOG和机型反馈音频组
ERR_ADM_IOS_VPIO_REINIT_FAIL                                             = 1213,//VPIO重新初始化失败【处理方法】：收集LOG和机型反馈音频组
ERR_ADM_IOS_VPIO_RESTART_FAIL                                         = 1214,//VPIO重新启动失败【处理方法】：收集LOG和机型反馈音频组
ERR_ADM_IOS_SET_INPUT_FORMAT_FAIL                                 = 1217,//设置音频输入格式失败【处理方法】：收集LOG和机型反馈音频组
ERR_ADM_IOS_SET_OUTPUT_FORMAT_FAIL                              = 1218,//设置音频输出格式失败【处理方法】：收集LOG和机型反馈音频组
ERR_ADM_WIN_CORE_INIT                                                    = 1301,//ADM初始化失败 【处理方法】：收集LOG反馈音频组
ERR_ADM_WIN_CORE_TERMINATE                                          = 1302, //ADM终止失败 【处理方法】：收集LOG反馈音频组
ERR_ADM_WIN_CORE_INIT_RECORDING                                  = 1303, //ADM采集设备初始化失败 【处理方法】：收集LOG反馈音频组
ERR_ADM_WIN_CORE_RECORDING_DEVICE_NULL                     = 1304, //ADM无音频采集设备 【处理方法】：确认系统是否存在音频采集设备
ERR_ADM_WIN_CORE_CREATE_CAPTURE_STREAM                    = 1305, //ADM创建采集数据流失败 【处理方法】：收集LOG反馈音频组
ERR_ADM_WIN_CORE_INIT_PLAYOUT                                      = 1306, //ADM播放设备初始化失败 【处理方法】：收集LOG反馈音频组
ERR_ADM_WIN_CORE_INIT_PLAYOUT_NULL                             = 1307, //ADM无音频播放设备 【处理方法】：确认系统是否存在音频播放设备
ERR_ADM_WIN_CORE_CREATE_RENDER_STREAM                     = 1308,//ADM创建播放数据流失败【处理方法】：收集LOG反馈音频组
ERR_ADM_WIN_CORE_START_RECORDING                               = 1309,//ADM启动采集失败 【处理方法】：收集LOG反馈音频组
ERR_ADM_WIN_CORE_DMO_PLAYING                                     = 1310,//系统AEC启动失败【处理方法】：收集LOG反馈音频组
ERR_ADM_WIN_CORE_CREATE_REC_THREAD                            = 1311,//创建采集线程失败 【处理方法】：收集LOG反馈音频组
ERR_ADM_WIN_CORE_CREATE_VOLGET_THREAD                      = 1312,//创建获取系统音量线程失败 【处理方法】：收集LOG反馈音频组
ERR_ADM_WIN_CORE_CREATE_VOLSET_THREAD                      = 1313,//创建设置系统音量线程失败【处理方法】：收集LOG反馈音频组
ERR_ADM_WIN_CORE_CAPTURE_NOT_STARTUP                       = 1314,//采集线程未启动 【处理方法】：收集LOG反馈音频组
ERR_ADM_WIN_CORE_CLOSE_CAPTURE_THREAD                      = 1315,//关闭采集线程失败 【处理方法】：收集LOG反馈音频组
ERR_ADM_WIN_CORE_CLOSE_VOLGET_THREAD                        = 1316,//关闭获取系统音量线程失败【处理方法】：收集LOG反馈音频组
ERR_ADM_WIN_CORE_CLOSE_VOLSET_THREAD                        = 1317,//关闭设置系统音量线程失败【处理方法】：收集LOG反馈音频组
ERR_ADM_WIN_CORE_START_PLAYOUT                                   = 1318,//启动播放设备失败【处理方法】：收集LOG反馈音频组
ERR_ADM_WIN_CORE_CREATE_RENDER_THREAD                     = 1319,//创建播放线程失败【处理方法】：收集LOG反馈音频组
ERR_ADM_WIN_CORE_RENDER_NOT_STARTUP                        = 1320,//播放线程未启动【处理方法】：收集LOG反馈音频组
ERR_ADM_WIN_CORE_CLOSE_RENDER_THREAD                       = 1321,//关闭播放线程失败【处理方法】：收集LOG反馈音频组
ERR_ADM_WIN_CORE_CAPTURE_ABNORMAL                        = 1325,//采集数据异常【处理方法】：收集LOG反馈音频组
ERR_ADM_WIN_CORE_BASE                                        = 1700,//chenzhong
// WAVE API
ERR_ADM_WIN_WAVE_INIT                                                   = 1351,//ADM初始化失败【处理方法】：收集LOG反馈音频组
ERR_ADM_WIN_WAVE_TERMINATE                                         = 1352,//ADM终止失败【处理方法】：收集LOG反馈音频组
ERR_ADM_WIN_WAVE_INIT_RECORDING                                 = 1353,//ADM初始化采集设备失败【处理方法】：收集LOG反馈音频组
ERR_ADM_WIN_WAVE_INIT_MICROPHONE                              = 1354,//ADM初始化麦克风失败【处理方法】：收集LOG反馈音频组
ERR_ADM_WIN_WAVE_INIT_PLAYOUT                                     = 1355,//ADM初始化播放设备失败【处理方法】：收集LOG反馈音频组
ERR_ADM_WIN_WAVE_INIT_SPEAKER                                      = 1356,//ADM初始化扬声器失败【处理方法】：收集LOG反馈音频组
ERR_ADM_WIN_WAVE_START_RECORDING                              = 1357,//ADM启动采集失败【处理方法】：收集LOG反馈音频组
ERR_ADM_WIN_WAVE_START_PLAYOUT                                  = 1358,//ADM启动播放失败【处理方法】：收集LOG反馈音频组
ERR_ADM_WIN_WAVE_BASE                                       = 1750,//chenzhong
ERR_ADM_WIN_WAVE_ERROR                                                =(ERR_ADM_WIN_WAVE_BASE + 1), //未知错误【处理方法】：收集LOG反馈音频组
ERR_ADM_WIN_WAVE_BADDEVICEID                                         =(ERR_ADM_WIN_WAVE_BASE + 2), //无效设备ID【处理方法】：确认竞品是否正常
ERR_ADM_WIN_WAVE_NOTENABLED                                        =(ERR_ADM_WIN_WAVE_BASE + 3),  //驱动异常【处理方法】：确认竞品是否正常
ERR_ADM_WIN_WAVE_ALLOCATED                                           =(ERR_ADM_WIN_WAVE_BASE + 4), //驱动异常【处理方法】：确认竞品是否正常
ERR_ADM_WIN_WAVE_INVALHANDLE                                        =(ERR_ADM_WIN_WAVE_BASE + 5),  //驱动设备无效【处理方法】：确认竞品是否正常
ERR_ADM_WIN_WAVE_NODRIVER                                            =(ERR_ADM_WIN_WAVE_BASE + 6),  //无驱动设备【处理方法】：确认竞品是否正常
ERR_ADM_WIN_WAVE_NOMEM                                              =(ERR_ADM_WIN_WAVE_BASE + 7), //内存分配错误【处理方法】：确认竞品是否正常
ERR_ADM_WIN_WAVE_NOTSUPPORTED                                     =(ERR_ADM_WIN_WAVE_BASE + 8), //无效函数【处理方法】：确认竞品是否正常
ERR_ADM_WIN_WAVE_BADERRNUM                                        =(ERR_ADM_WIN_WAVE_BASE + 9), //无效参数【处理方法】：确认竞品是否正常
ERR_ADM_WIN_WAVE_INVALFLAG                                            =(ERR_ADM_WIN_WAVE_BASE + 10),//无效标志位【处理方法】：确认竞品是否正常
ERR_ADM_WIN_WAVE_INVALPARAM                                        =(ERR_ADM_WIN_WAVE_BASE + 11),//无效参数【处理方法】：确认竞品是否正常
ERR_ADM_WIN_WAVE_HANDLEBUSY                                        =(ERR_ADM_WIN_WAVE_BASE + 12), //设备无法使用【处理方法】：确认竞品是否正常
/* simultaneously on another */
/* thread (eg callback) */
ERR_ADM_WIN_WAVE_INVALIDALIAS                                         =(ERR_ADM_WIN_WAVE_BASE + 13), //无效参数【处理方法】：确认竞品是否正常
ERR_ADM_WIN_WAVE_BADDB                                                =(ERR_ADM_WIN_WAVE_BASE + 14),//错误的注册数据库【处理方法】：确认竞品是否正常
ERR_ADM_WIN_WAVE_KEYNOTFOUND                                      =(ERR_ADM_WIN_WAVE_BASE + 15),//找不到注册表【处理方法】：确认竞品是否正常
ERR_ADM_WIN_WAVE_READERROR                                          =(ERR_ADM_WIN_WAVE_BASE + 16),//读注册表错误【处理方法】：确认竞品是否正常
ERR_ADM_WIN_WAVE_WRITEERROR                                         =(ERR_ADM_WIN_WAVE_BASE + 17),//写注册表错误【处理方法】：确认竞品是否正常
ERR_ADM_WIN_WAVE_DELETEERROR                                         =(ERR_ADM_WIN_WAVE_BASE + 18),// 注册表删除错误【处理方法】：确认竞品是否正常
ERR_ADM_WIN_WAVE_VALNOTFOUND                                     =(ERR_ADM_WIN_WAVE_BASE + 19), //找不到注册值【处理方法】：确认竞品是否正常
ERR_ADM_WIN_WAVE_NODRIVERCB                                         =(ERR_ADM_WIN_WAVE_BASE + 20),//驱动无回调【处理方法】：确认竞品是否正常
ERR_ADM_WIN_WAVE_MOREDATA                                          =(ERR_ADM_WIN_WAVE_BASE + 21), //返回数据多于预期【处理方法】：确认竞品是否正常
ERR_ADM_WIN_WAVE_BADFORMAT                                         =(ERR_ADM_WIN_WAVE_BASE + 32),// 数据格式不正确【处理方法】：确认竞品是否正常
ERR_ADM_WIN_WAVE_STILLPLAYING                                          =(ERR_ADM_WIN_WAVE_BASE + 33),// 播放无法停止【处理方法】：确认竞品是否正常
ERR_ADM_WIN_WAVE_UNPREPARED                                        =(ERR_ADM_WIN_WAVE_BASE + 34),// 数据未准备好【处理方法】：确认竞品是否正常
// DSHOW API
ERR_ADM_WIN_DSHOW_INIT                                                   = 1401,//ADM初始化失败【处理方法】：收集LOG反馈音频组
ERR_ADM_WIN_DSHOW_INIT_RECORDING                                = 1402,//ADM采集设备失败【处理方法】：收集LOG反馈音频组
ERR_ADM_WIN_DSHOW_INIT_PLAYOUT                                    = 1403,//ADM初始化播放设备失败【处理方法】：收集LOG反馈音频组
ERR_ADM_WIN_DSHOW_START_RECORDING                             = 1404,//ADM启动采集失败【处理方法】：收集LOG反馈音频组
ERR_ADM_WIN_DSHOW_START_PLAYOUT                                 = 1405,//ADM启动播放失败【处理方法】：收集LOG反馈音频组
// VDM error code starts from 1500
ERR_VDM_CAMERA_NOT_AUTHORIZED                                    = 1501,//无摄像头权限【处理方法】：确认摄像头权限
// VCM error code
ERR_VCM_UNKNOWN_ERROR                                                 = 1600,//未知错误【处理方法】：收集LOG反馈视频组
ERR_VCM_ENCODER_INIT_ERROR                                              = 1601,//编码初始化失败【处理方法】：收集LOG反馈视频组
ERR_VCM_ENCODER_ENCODE_ERROR                                       = 1602,//编码失败【处理方法】：收集LOG反馈视频组
ERR_VCM_ENCODER_SET_ERROR                                              = 1603,//编码参数设置失败【处理方法】：收集LOG反馈视频组
enum WARNING_CODE_TYPE
WARN_ADM_RECORD_AUDIO_SILENCE                                 = 1019,//采集无声音【处理方法】：确认麦克风是否静音，确认系统录音机录音是否正常
WARN_ADM_PLAYOUT_ABNORMAL_FREQUENCY                  = 1020,//播放频率异常【处理方法】：确认是否存在Disable Audio或者重新加入频道
WARN_ADM_RECORD_ABNORMAL_FREQUENCY                    = 1021,//采集频率异常【处理方法】：确认是否存在Disable Audio或者重新加入频道
// The recorded audio level is too low to be heard
WARN_ADM_RECORD_AUDIO_LOWLEVEL                              = 1031,//采集音量过小【处理方法】：确认麦克风是否静音，麦克风增强是否打开
WARN_ADM_PLAYOUT_AUDIO_LOWLEVEL                            = 1032,//播放音量过小【处理方法】：确认对端麦克风是否静音，麦克风增强是否打开
ERR_ADM_RECORD_AUDIO_IS_OCCUPIED                               = 1033, //设备被占用【处理方法】：确认权限是否打开或者是否被第三方占用
// No captrue/render data ready event on Windows
WARN_ADM_WINDOWS_NO_DATA_READY_EVENT               = 1040,//无音频回调【处理方法】：收集LOG反馈音频组
WARN_APM_HOWLING_STATE                                             = 1051,//啸叫状态【处理方法】：确认两端距离是否足够远
WARN_ADM_WIN_CORE_NO_RECORDING_DEVICE                   = 1322,//无音频采集设备【处理方法】：确认麦克风是否正常
WARN_ADM_WIN_CORE_NO_PLAYOUT_DEVICE                       = 1323,//无音频播放设备【处理方法】：收集扬声器是否正常
 AUDIO_FILE_OPEN_ERROR                                                         =701,//文件打开失败【处理方法】：确认文件是否存在，路径名称是否正确

Signaling信令错误码
GENERAL_E = 1000
GENERAL_E_FAILED = 1001
GENERAL_E_UNKNOWN = 1002
GENERAL_E_NOT_LOGIN = 1003非网络原因，可能是token过期或者错误
GENERAL_E_WRONG_PARAM = 1004LOGIN_E_OTHER = 200
LOGIN_E_NET = 201
LOGIN_E_FAILED = 202
LOGIN_E_CANCEL = 203
LOGIN_E_TOKENEXPIRED = 204
LOGIN_E_OLDVERSION = 205
LOGIN_E_TOKENWRONG = 206
LOGIN_E_TOKEN_KICKED = 207
LOGIN_E_ALREADY_LOGIN = 208
LOGOUT_E_OTHER = 100
LOGOUT_E_USER = 101
LOGOUT_E_NET = 102
LOGOUT_E_KICKED = 103
LOGOUT_E_PACKET = 104
LOGOUT_E_TOKENEXPIRED = 105
LOGOUT_E_OLDVERSION = 106
LOGOUT_E_TOKENWRONG = 107
LOGOUT_E_ALREADY_LOGOUT = 108
INVITE_E_OTHER = 700------对方不在线或者没响应20s就统一报这个错不会有703，一般客户端和服务器失联2分钟会被踢下去
INVITE_E_REINVITE = 701
INVITE_E_NET = 702
INVITE_E_PEEROFFLINE = 703
INVITE_E_TIMEOUT = 704
INVITE_E_CANTRECV = 705
JOINCHANNEL_E_OTHER = 300
SENDMESSAGE_E_OTHER = 400
SENDMESSAGE_E_TIMEOUT = 401
QUERYUSERNUM_E_OTHER = 500
QUERYUSERNUM_E_TIMEOUT = 501
QUERYUSERNUM_E_BYUSER = 502
LEAVECHANNEL_E_OTHER = 600
LEAVECHANNEL_E_KICKED = 601
LEAVECHANNEL_E_BYUSER = 602
LEAVECHANNEL_E_LOGOUT = 603
LEAVECHANNEL_E_DISCONN = 604

