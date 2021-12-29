# EduClassroomUIStore 介绍

自 2.0.0 版本起，灵动课堂桌面端使用 UI Store 和 Container 组件来实现业务功能组件。每种课堂类型都对应一个 UI Store。`agora-classroom-sdk/src/infra/stores/` 目录下包含以下 UI Store：
- 一对一互动教学：`agora-classroom-sdk/src/infra/stores/one-on-one/index.ts` 中的 `Edu1v1ClassUIStore`。
- 小班课：`agora-classroom-sdk/src/infra/stores/interactive/index.ts` 中的 `EduInteractiveUIClassStore`
- 大班课：`agora-classroom-sdk/src/infra/stores/lecture/index.ts` 中的 `EduLectureUIStore`

以上班型的 UI Store 都继承自 `agora-edu-core` 提供的`EduClassroomUIStore`。`EduClassroomUIStore` 提供了所有的基础能力，包含灵动课堂各个 UI 组件模块对应的 Store。原则上各个子 UI Store 应该保持独立，避免出现耦合。

本页介绍各个子 UI Store。

## EduShareUIStore

`EduShareUIStore` 提供弹窗、通知功能。主要包含 `dialogQueue`（模态框相关）、 `toastQueue`（提示通知相关）、 `classroomViewportSize`（视口尺寸信息）。可结合`agora-classroom-sdk` 下的 `<ToastContainer />` 组件实现通知提示功能。

具体用法参见对应API文档与 `<ToastContainer />` 组件。addToast添加通知，removeToast移除通知。

**自定义ShareUIStore功能案例**：所有班型都是默认最多同时出现3条通知，如果大班课想修改为可以最多出现5条通知,其余班型不变，则可以重写大班课下`EduLectureUIStore`下的`shareUIStore`.找到大班课的`agora-classroom-sdk/src/infra/stores/lecture`目录，然后新增share-ui.ts文件。在文件内定义一个`LectureShareUIStore`类，继承于`agora-edu-core`下的`EduShareUIStore`,重写addToast方法，具体代码如下
      
      ```ts
        import { EduShareUIStore, ToastTypeEnum } from 'agora-edu-core';
        import { action } from 'mobx'
        import { v4 as uuidv4 } from 'uuid';
      
        export class LectureShareUIStore extends EduShareUIStore {
        @action.bound
          addToast(desc: string, type?: ToastTypeEnum) {
            const id = uuidv4();
            this.toastQueue.push({ id, desc, type });
            //大于5个的时候才移除多余的toast
            if (this.toastQueue.length > 5) {
              this.toastQueue = this.toastQueue.splice(1, this.toastQueue.length);
            }
            return id;
          }
        }
      ```
      如果引入`ToastTypeEnum`报错，则需要在`agora-edu-core/src/stores/ui/index.ts`内新增导出，代码`export type { ToastType, ToastTypeEnum } from './common/share-ui';`
      然后在`agora-classroom-sdk/src/infra/stores/lecture/index.ts`内，引入`import { LectureShareUIStore } from './share-ui';`，将EduLectureUIStore的construct内新增`this._shareUIStore = new LectureShareUIStore();`具体代码如下
      
      ```ts
      import { EduClassroomStore, EduClassroomUIStore } from 'agora-edu-core';
      import { LectureBoardUIStore } from './board-ui';
      import { LectureRosterUIStore } from './roster';
      import { LectureRoomStreamUIStore } from './stream-ui';
      //引入LectureShareUIStore
      import { LectureShareUIStore } from './share-ui';
      
      export class EduLectureUIStore extends EduClassroomUIStore {
        constructor(store: EduClassroomStore) {
          super(store);
          //重写_shareUIStore
          this._shareUIStore = new LectureShareUIStore();
          this._streamUIStore = new LectureRoomStreamUIStore(store, this.shareUIStore);
          this._rosterUIStore = new LectureRosterUIStore(store, this.shareUIStore);
          this._boardUIStore = new LectureBoardUIStore(store, this.shareUIStore);
        }
      
        get streamUIStore() {
          return this._streamUIStore as LectureRoomStreamUIStore;
        }
      
        get rosterUIStore() {
          return this._rosterUIStore as LectureRosterUIStore;
        }
      }
      
      ```
      这样就完成了对大班课下ShareUIStore的addToast的重写。其他班型的各个store下的各个功能方法重写步骤可以参考该案例。
    * **自定义toastUI的案例** 如果想让toast的的宽度最小改为300px。则可以找到`<ToastContainer/>`组件,可以发现该组件调用了`agora-scenario-ui-kit`下的`<Toast/>`组件，找到该组件的目录`agora-scenario-ui-kit/src/components/toast`,修改index.css下`.toast { min-width: 300px; }`即可。修改其他contaiter组件的流程可以参考该案例
    
    * 配合`agora-classroom-sdk`下的`<DialogContainer />`组件，可以提供弹窗功能。调用addDialog可以添加弹窗，removeDialog可以移除弹窗，具体详情可以参考对应的API文档。
    * addWindowResizeEventListenerAndSetNavBarHeight 提供监听窗口大小的功能
  * `boardUIStore`： 主要给`<WhiteboardContainer/>`使用，负责白板相关的功能，包括白板的挂载、卸载、连接、断开、重连、设置高度等等，用法如下
    ```ts
    ...
    const {
      readyToMount,//是否准备好挂载
      mount,  //挂载
      unmount,//卸载
      rejoinWhiteboard,//重连
      connectionLost,//是否白板连接中断
      boardHeight,//白板高度
      joinWhiteboardWhenConfigReady,//等待白板配置就绪后连接白板
      leaveWhiteboard,//离开白板
    } = boardUIStore;
    
    useEffect(() => {
      //当白板配置就绪自动连接
      joinWhiteboardWhenConfigReady();
      return () => {
        leaveWhiteboard();
      };
    }, [leaveWhiteboard, joinWhiteboardWhenConfigReady]);
    ...
    return (
      ...
      {readyToMount ? <div ref={(dom) => {
        if (dom) {
          mount(dom);
        } else {
          unmount();
        }
      }}></div> : null}
      ...
      {connectionLost ? <button onClick={rejoinWhiteboard}>RejoinWhiteboard</button> : null}
      ...
      )
    ```
  * `cloudUIStore`：主要是在`<PersonalResourcesContainer/>`组件和`<PublicResourcesContainer/>`组件下使用，提供了个公共课件列表、上传课件、上传进度、查询个人课件列表、选中课件、删除个人课件、打开课件等功能。具体详情参考对应的API文档。
    显示列表：
    ```ts
    ...
    const { cloudUIStore } = useStore();
    //文件类型、大小、打开课件、公共课件列表
    const {fileNameToType, formatFileSize openResource, publicResources } = cloudUIStore;
    ...
    return （
    ...
    {
      [...publicResources].map(([key, { resourceName, updateTime, size, resourceUuid }]) => (
        <div key={key} onClick={()=>{openResource(resourceUuid)}}>
          <div>{resourceName}</div>
          <div>{updateTime}<div>
          <div>{formatFileSize(size)}</div>
          <div>{updateTime}</div>
        </div>
      ))
    }
    ...
    )
    ```
    上传：
    ```ts
    ...
    // 上传课件
    cosnt { uploadPersonalResource } = cloudUIStore;
      const triggerUpload = () => {
        if (fileRef.current) {
          fileRef.current.click();
        }
      };
    
      const handleUpload = async (evt: ChangeEvent<HTMLInputElement>) => {
        try {
          const files = evt.target.files || [];
          if (files?.length) {
            //显示上传进度
            setShowUploadModal(true);
            const taskArr = [];
            for (let file of files) {
              //加入上传队列
              taskArr.push(uploadPersonalResource(file));
            }
            //开始上传
            await Promise.all(taskArr);
            finishUpload();
          }
        } catch (e) {
          //关闭进度
          setShowUploadModal(false);
          throw e;
        } finally {
          fileRef.current!.value = '';
        }
      };
        <input
          ref={fileRef}
          id="upload-image"
          accept=".bmp,.jpg,.png,.gif,.pdf,.jpeg,.pptx,.ppt,.doc,.docx,.mp3,.mp4"
          onChange={handleUpload}
          multiple
          type="file"></input>
        <Button type="primary" onClick={triggerUpload}>
          {transI18n('cloud.upload')}
        </Button>
    ...
    ```
  * handUpUIStore：主要在`<HandsUpContainer />`组件下使用。提供了挥手列表、是否有用户在挥手、挥手用户数、学生上台、学生下台、学生挥手等功能。
    老师端例子
    ```ts
    export const WaveArmListContainer = observer(() => {
      const { handUpUIStore } = useStore();
      //学生上台
      const { onPodium } = handUpUIStore;
      //学生挥手列表
      const { userWaveArmList } = handUpUIStore;
      return <StudentsWaveArmList userWaveArmList={userWaveArmList} onClick={onPodium} />;
    });
    ```
    学生端例子
    ```ts
    export const WaveArmSenderContainer = observer(() => {
      const { handUpUIStore } = useStore();
      const { waveArm, teacherUuid } = handUpUIStore;
      const waveArmDuration = async (duration: 3 | -1) => {
        await waveArm(teacherUuid, duration);
      };
      return <WaveArmSender waveArmDuration={waveArmDuration} />;
    });
    ```

  * `deviceSettingUIStore`: 主要负责设备相关的功能，包括摄像头设备信息，麦克风设备信息，扬声器设备等，具体用法参见API。
    * 摄像头镜像
    ```tsx
    export const CameraMirrorCheckBox = observer(() => {
      const {
        deviceSettingUIStore: { setMirror, isMirror },
      } = useStore(); // 设置镜像，当前镜像值(是否镜像)
    
      return (
        <CheckBox
          checked={isMirror}
          onChange={(e: any) => {
            setMirror(e.target.checked);
          }}
        />
      );
    });
    ```
    * 麦克风设备
    ```tsx
    export const MicrophoneSelect = observer(() => {
      const {
        deviceSettingUIStore: { setRecordingDevice, currentRecordingDeviceId, recordingDevicesList },
      } = useStore(); // 设置麦克风设备，当前麦克风设备，麦克风设备列表
    
      return (
        <Select
          value={currentRecordingDeviceId}
          onChange={(value) => {
            setRecordingDevice(value);
          }}
          options={recordingDevicesList}></Select>
      );
    });
    ```
  * `navigationBarUIStore`: 主要负责导航栏相关的功能，包括教室时间信息，教室状态，网络质量状态，顶部导航栏按钮列表等，具体用法参见API。
    * 网络信号
    ```tsx
    export const SignalContent = observer(() => {
      const { navigationBarUIStore } = useStore();
      // 网络信号，延迟，丢包率，cpu
      const { networkQualityLabel, delay, packetLoss, cpuLabel } = navigationBarUIStore;
      return (
        <>
          <table>
            <tr>
              <td className="biz-col label left">{transI18n('signal.status')}:</td>
              <td className="biz-col value left">{networkQualityLabel}</td>
              <td className="biz-col label right">{transI18n('signal.delay')}:</td>
              <td className="biz-col value right">{delay}</td>
            </tr>
            <tr>
              <td className="biz-col label left">{transI18n('signal.lose')}:</td>
              <td className="biz-col value left">{packetLoss}</td>
              <td className="biz-col label right">{'CPU'}:</td>
              <td className="biz-col value right">{cpuLabel}</td>
            </tr>
          </table>
        </>
      );
    });
    ```
    * 顶部导航栏按钮
    ```tsx
    export const NavigationBar = observer(() => {
      const { navigationBarUIStore } = useStore();
      // actions 顶部导航栏按钮
      const { navigationTitle, actions, isBeforeClass, startClass } = navigationBarUIStore;
    
      return (
        <Header className="biz-header">
          ....
          <div className="header-actions">
            {actions.map((a) => (
              <NavigationBarAction key={a.iconType} action={a} />
            ))}
          </div>
        </Header>
      );
    });
    ```
  * `toolbarUIStore`: 主要负责工具栏相关的功能，包括选中工具，设置画笔粗细，老师工具栏列表等，具体用法参见API。
    * 工具栏画笔
    ```tsx
    export const PensContainer = observer((props: PensContainerProps) => {
      const { toolbarUIStore } = useStore();
      const {
        setTool, // 选中工具
        selectedPenTool, // 当前激活的画笔类工具
        isPenToolActive, // 画笔工具是否激活
        currentColor, // 选中的画笔颜色
        strokeWidth, // 选中的画笔粗细
        changeStroke, // 设置画笔粗细
        changeHexColor, // 设置画笔颜色，支持 Hex 色值
        defaultPens, // 默认画笔（目前有4种画笔可供选择）
        defaultColors, // 默认颜色 （目前12种颜色可供选择）
        paletteMap, // 调色板（demo背景色是白色，画笔选择白色后为了显示颜色，设置了个map，目前只对特殊的白色进行了处理）
      } = toolbarUIStore;

      // 国际化配置label
      const mapLineSelectorToLabel: Record<string, string> = {
        pen: 'scaffold.pencil',
        square: 'scaffold.rectangle',
        circle: 'scaffold.circle',
        line: 'scaffold.straight',
      };
    
      return (
        <Pens
          pens={defaultPens}
          colors={defaultColors}
          paletteMap={paletteMap}
          value="pen"
          label={t(mapLineSelectorToLabel[selectedPenTool])}
          icon="pen"
          activePen={selectedPenTool}
          onClick={setTool}
          isActive={isPenToolActive}
          colorSliderMin={1}
          colorSliderMax={31}
          strokeWidthValue={strokeWidth}
          colorSliderStep={0.3}
          onSliderChange={changeStroke}
          activeColor={currentColor}
          onColorClick={(value: any) => {
            changeHexColor(value);
          }}
        />
      );
    });
    ```
  * `layoutUIStore`: 主要负责布局相关的功能，包括教室加载状态等，具体用法参见API。
    * 加载容器
    ```tsx
    export const LoadingContainer = observer(() => {
      const { layoutUIStore } = useStore();
      const { loading } = layoutUIStore; // 获取教室加载状态
      return loading ? <PageLoading /> : null;
    });
    ```
  * `notificationUIStore`: 主要负责通知相关的功能，包括教室状体通知，根据课堂状态获取时长等，具体用法参见API。
    * 处理些事件监听，通过shareUIStore通知用户信息，以addClassStateNotification举例子
    ```ts
    /**
    * add class state notification
    * @param state
    * @param minutes
    */
    protected addClassStateNotification(state: ClassState, minutes: number) {
      const transMap = {
        [ClassState.ongoing]: 'toast.time_interval_between_end',
        [ClassState.afterClass]: 'toast.time_interval_between_close',
      } as Record<ClassState, string>;
    
      const text = transI18n(transMap[state as ClassState], {
        reason: `${minutes}`,
      });
    
      // 通知shareUIStore，用toast提示用户
      this.shareUIStore.addToast(text);
    }
    ```

  * `trackUIStore`: 主要负责轨迹同步相关的功能，包括设置组件轨迹同步信息, 移除组件轨迹同步信息等，具体用法参见API。
    * 轨迹移动范围
    ```tsx
    export const TrackArea = ({ top = 0, boundaryName }: { top?: number; boundaryName: string }) => {
      const { trackUIStore } = useStore();
    
      useEffect(() => {
        // 重新计算轨迹同步上下文参数
        trackUIStore.updateTrackContext(boundaryName);
      }, []);
      return (
        <div
          className={`${boundaryName} w-full absolute`}
          style={{ height: `calc( 100% - ${top}px )`, top, zIndex: -1 }}
        />
      );
    };
    ```

    * widget，extapp轨迹同步
    ```tsx
    export const WidgetTrack: React.FC<TrackSyncingProps> = observer((props) => {
      const { trackUIStore } = useStore();
    
      // 组件轨迹同步信息，设置组件轨迹同步信息
      const { widgetTrackById, setWidgetTrackById } = trackUIStore;
    
      return <TrackCore {...props} setTrackById={setWidgetTrackById} trackById={widgetTrackById} />;
    });
    
    export const ExtAppTrack: React.FC<TrackSyncingProps> = observer((props) => {
      const { trackUIStore } = useStore();
    
      // 组件轨迹同步信息，设置组件轨迹同步信息
      const { extAppTrackById, setExtAppTrackById } = trackUIStore;
    
      return <TrackCore {...props} setTrackById={setExtAppTrackById} trackById={extAppTrackById} />;
    });    
    ```

  * `extAppUIStore`: 主要负责扩展应用相关的功能，包括当前打开的 ExtApp，更新 ExtApp 属性等，具体用法参见API。
    * extApp
    ```tsx
    export const ExtAppContainer = observer(() => {
      const { extAppUIStore } = useStore();
    
      /**
       * canClose - 当前用户是否拥有 ExtApp 的关闭权限
       * canDrag - 当前用户是否拥有 ExtApp 的移动权限
       * shutdownApp - 关闭 ExtApp
       * activeApps - 当前打开的 ExtApp
       * updateTrackState - 更新 ExtApp 的轨迹信息
       * mount - 挂载 ExtApp 到 DOM
      */ 
      const { canClose, canDrag, shutdownApp, activeApps, updateTrackState, mount } = extAppUIStore;
    
      return (
        <React.Fragment>
          {activeApps.map((extApp) => (
            <ExtApp
              key={extApp.appIdentifier}
              extApp={extApp}
              canClose={canClose}
              canDrag={canDrag}
              onClose={shutdownApp}
              onResize={updateTrackState}
              mount={mount}
            />
          ))}
        </React.Fragment>
      );
    });    
    ```




  * `rosterUIStore`: 主要负责花名册相关的功能，包括轮播，花名册学生列表，花名册功能按钮点击等，具体用法参见API。
    * 花名册容器
    ```tsx
    export const RosterContainer: FC<RosterContainerProps> = observer(({ onClose }) => {
      const { rosterUIStore } = useStore();
      const {
        teacherName, // 老师姓名
        setKeyword, // 设置检索字符串
        searchKeyword, // 检索字符串
        rosterFunctions: functions, // 花名册功能列表
        carouselProps, // 轮播组件属性
        uiOverrides,// 重写ui样式
      } = rosterUIStore;
    
      const { width } = uiOverrides;
      return (
        <Roster
          width={width}
          bounds="classroom-track-bounds"
          hostname={teacherName}
          keyword={searchKeyword}
          carouselProps={carouselProps}
          functions={functions}
          onClose={onClose}
          onKeywordChange={setKeyword}>
          <RosterTableContainer />
        </Roster>
      );
    });
    ```

  * `streamUIStore`: 主要负责流相关的功能，包括老师流信息，学生流信息，本地设备状态等，具体用法参见API。
    * 本地远端音量
    ```tsx
    const LocalStreamPlayerVolume = observer(({ stream }: { stream: EduStreamUI }) => {
      const { streamUIStore } = useStore();
      const { localVolume, localMicOff } = streamUIStore; // 本地音量， 本地麦克风关闭状态
    
      const isMicMuted = localMicOff ? true : stream.isMicMuted;
    
      return (
        <AudioVolume
          isMicMuted={isMicMuted}
          currentVolume={Math.floor(localVolume)}
          className={stream.micIconType}
        />
      );
    });
    
    const RemoteStreamPlayerVolume = observer(({ stream }: { stream: EduStreamUI }) => {
      const { streamUIStore } = useStore();
      const { remoteStreamVolume } = streamUIStore; // 远端流音量
    
      const volumePercentage = remoteStreamVolume(stream);
    
      return (
        <AudioVolume
          isMicMuted={stream.isMicMuted}
          currentVolume={Math.floor(volumePercentage)}
          className={stream.micIconType}
        />
      );
    });
    ```

    * 本地远端工具栏
    ```tsx
    const LocalStreamPlayerTools = observer(() => {
      const { streamUIStore } = useStore();
      const { localStreamTools, toolbarPlacement } = streamUIStore; // 本地流工具栏，工具栏位置
    
      return localStreamTools.length > 0 ? (
        <div className={`video-player-tools`}>
          {localStreamTools.map((tool, key) => (
            <Tooltip key={key} title={tool.toolTip} placement={toolbarPlacement}>
              <span>
                <SvgIcon
                  canHover={tool.interactable}
                  style={tool.style}
                  // hoverType={tool.hoverIconType}
                  type={tool.iconType}
                  size={22}
                  onClick={tool.interactable ? tool.onClick : () => {}}
                />
              </span>
            </Tooltip>
          ))}
        </div>
      ) : (
        <></>
      );
    });
    
    const RemoteStreamPlayerTools = observer(({ stream }: { stream: EduStreamUI }) => {
      const { streamUIStore } = useStore();
      const { remoteStreamTools, toolbarPlacement } = streamUIStore; // 远端工具栏，工具栏位置
      const toolList = remoteStreamTools(stream);
    
      return toolList.length > 0 ? (
        <div className={`video-player-tools`}>
          {toolList.map((tool, idx) => (
            <Tooltip key={`${idx}`} title={tool.toolTip} placement={toolbarPlacement}>
              <span>
                <SvgIcon
                  canHover={tool.interactable}
                  style={tool.style}
                  // hoverType={tool.hoverIconType}
                  type={tool.iconType}
                  size={22}
                  onClick={tool.interactable ? tool.onClick : () => {}}
                />
              </span>
            </Tooltip>
          ))}
        </div>
      ) : (
        <></>
      );
    });    
    ```

  * `pretestUIStore`: 主要预检设备相关的功能，包括设备列表，设备状态，美颜功能等，具体用法参见API。 

    * 设置美颜
    ```tsx
    const BeautyCheckBox = observer(() => {
      const {
        pretestUIStore: { setBeauty, isBeauty }, // 设置美颜，是否开启美颜
      } = useStore();
      return (
        <CheckBox
          style={{ width: 12, height: 12 }}
          checked={isBeauty}
          onChange={(e: any) => {
            setBeauty(e.target.checked);
          }}
        />
      );
    });
    ```
    
    * 调整美颜参数
    ```tsx
    const BeautyControllerBar = observer(() => {
      if (EduRteEngineConfig.platform !== EduRteRuntimePlatform.Electron) return null;
      const {
        pretestUIStore: {
          isBeauty, // 是否开启美颜
          setActiveBeautyType, // 设置美颜类型
          activeBeautyValue, // 美颜调整参数类型
          setActiveBeautyValue, // 设置美颜参数（0-100）
          activeBeautyTypeIcon, // 激活美颜类型
        },
      } = useStore();
    
      return (
        <CSSTransition in={isBeauty} timeout={300} unmountOnExit classNames="beauty-bar-animate">
          <div className="beauty-bar">
            <div className="beauty-bar-left">
              {['whitening', 'buffing', 'ruddy'].map((item: any) => (
                <Tooltip
                  title={transI18n(`media.${item}`)}
                  placement="top"
                  color="rgba(0,0,0,0.6)"
                  overlayInnerStyle={{ color: '#fff' }}>
                  <Icon
                    className={classnames('beauty-type-icon')}
                    type={activeBeautyTypeIcon(item)}
                    key={item}
                    size={22}
                    onClick={() => setActiveBeautyType(item as BeautyType)}
                  />
                </Tooltip>
              ))}
            </div>
            <BeautySider value={activeBeautyValue} onChange={setActiveBeautyValue} />
          </div>
        </CSSTransition>
      );
    });
    ```