import mediaQuery from '@ohos.mediaquery';
import { DeviceScreenConstants } from '../constant/DeviceScreenConstants';
import { display, window } from '@kit.ArkUI';
import { Logger } from './Logger';

export class WindowSizeChangeNotifyUtil {
  private screenSize: string = '';
  private smListener?: mediaQuery.MediaQueryListener;
  private mdListener?: mediaQuery.MediaQueryListener;
  private lgListener?: mediaQuery.MediaQueryListener;
  private orientationListener?: mediaQuery.MediaQueryListener;
  private constructor() {}
  private static instance: WindowSizeChangeNotifyUtil;

  public static getInstance(): WindowSizeChangeNotifyUtil {
    if (!WindowSizeChangeNotifyUtil.instance) {
      WindowSizeChangeNotifyUtil.instance = new WindowSizeChangeNotifyUtil();
    }
    return WindowSizeChangeNotifyUtil.instance;
  }

  private updateScreenSize(screenSize: string): void {
    if (this.screenSize !== screenSize) {
      Logger.debug('callback 屏幕尺寸改变: ' + screenSize)
      this.screenSize = screenSize;
      AppStorage.setOrCreate<string>(DeviceScreenConstants.CURRENT_BREAKPOINT, this.screenSize);
    }
  }

  private isScreenSM = (mediaQueryResult: mediaQuery.MediaQueryResult) => {
    if (mediaQueryResult.matches) {
      this.updateScreenSize(DeviceScreenConstants.DEVICE_SCREEN_SM);
    }
  }

  private isScreenMD = (mediaQueryResult: mediaQuery.MediaQueryResult) => {
    if (mediaQueryResult.matches) {
      this.updateScreenSize(DeviceScreenConstants.DEVICE_SCREEN_MD);
    }
  }

  private isScreenLG = (mediaQueryResult: mediaQuery.MediaQueryResult) => {
    if (mediaQueryResult.matches) {
      this.updateScreenSize(DeviceScreenConstants.DEVICE_SCREEN_LG);
    }
  }

  /**
   * 获取屏幕当前方向状态
   * AsyncCallback
   */
  public static getScreenOrientation(): number {
    let currentOrientation: number = DeviceScreenConstants.DEVICE_SCREEN_LANDSCAPE

    try {
      window.getLastWindow(AppStorage.get('Context'), (err, win) => {
        // 获取当前屏幕的枚举值
        let rotation: number = display.getDefaultDisplaySync().orientation
        let cutOutInfo = win.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM_GESTURE)
        Logger.debug('屏幕方向: ' + rotation + ' 数据: ' + JSON.stringify(cutOutInfo))
        // 根据module.json5中配置的orientation策略，获取到的rotation对应屏幕方向可能会不同
        if (window.Orientation.AUTO_ROTATION) {
          if (rotation == 0) {
            currentOrientation = DeviceScreenConstants.DEVICE_SCREEN_PORTRAIT
            Logger.debug("正向竖屏");
          } else if (rotation == 1) {
            currentOrientation = DeviceScreenConstants.DEVICE_SCREEN_LANDSCAPE
            Logger.debug("正向横屏");
          } else if (rotation == 2) {
            currentOrientation = DeviceScreenConstants.DEVICE_SCREEN_PORTRAIT
            Logger.debug("反向竖屏");
          } else {
            currentOrientation = DeviceScreenConstants.DEVICE_SCREEN_LANDSCAPE
            Logger.debug("反向横屏");
          }
        }
      })
    } catch (e) {
      Logger.debug('获取屏幕方向状态失败：' + JSON.stringify(e));
    }
    AppStorage.setOrCreate('currentOrientation', currentOrientation)

    return currentOrientation;
  }

  /**
   * 横竖屏变化监听回调
   * 首次启动也会默认触发一次，所以可以将横、竖屏状态自动同步到AppStorage中
   */
  private onOrientation = (mediaQueryResult: mediaQuery.MediaQueryResult) => {
    let currentOrientation = DeviceScreenConstants.CURRENT_ORIENTATION
    if (mediaQueryResult.matches) {
      AppStorage.setOrCreate<number>(currentOrientation, DeviceScreenConstants.DEVICE_SCREEN_LANDSCAPE);
      Logger.debug('callback 切换为横屏: ' + AppStorage.get<number>(currentOrientation))
    } else {
      AppStorage.setOrCreate(currentOrientation, DeviceScreenConstants.DEVICE_SCREEN_PORTRAIT);
      Logger.debug('callback 切换为竖屏: ' + AppStorage.get<number>(currentOrientation))
    }
  }

  // public static register(windowClass: window.Window) {
  //   try {
  //     windowClass.on('windowSizeChange', (data: window.Size) => {
  //       Logger.debug('windowSizeChange Data: ' + JSON.stringify(data));
  //       let ret = { "width": data.width, "height": data.height }
  //       Logger.debug('windowSizeChange 通知变化后的分辨率: ' + JSON.stringify(ret));
  //     });
  //   } catch (exception) {
  //     Logger.debug('Failed to enable the listener for window size changes. Cause: ' + JSON.stringify(exception));
  //   }
  // }

  public registerImpl() {
    // 屏幕尺寸变化监听
    this.smListener = mediaQuery.matchMediaSync(DeviceScreenConstants.DEVICE_SCREEN_RANGE_SM);
    this.smListener.on('change', this.isScreenSM);
    this.mdListener = mediaQuery.matchMediaSync(DeviceScreenConstants.DEVICE_SCREEN_RANGE_MD);
    this.mdListener.on('change', this.isScreenMD);
    this.lgListener = mediaQuery.matchMediaSync(DeviceScreenConstants.DEVICE_SCREEN_RANGE_LG);
    this.lgListener.on('change', this.isScreenLG);
    // 屏幕方向变化监听
    this.orientationListener = mediaQuery.matchMediaSync(DeviceScreenConstants.DEVICE_SCREEN_ORIENTATION);
    this.orientationListener.on('change', this.onOrientation)
    Logger.debug("register 屏幕尺寸、方向变化监听")
  }

  public unRegisterImpl() {
    this.smListener?.off('change', this.isScreenSM);
    this.mdListener?.off('change', this.isScreenMD);
    this.lgListener?.off('change', this.isScreenLG);
    this.orientationListener?.off('change', this.onOrientation)
    Logger.debug('unregister 屏幕尺寸、方向变化监听');
  }

  /**
   * 屏幕尺寸变化监听
   */
  public static register() {
    WindowSizeChangeNotifyUtil.getInstance().registerImpl();
  }

  /**
   * 屏幕尺寸变化监听取消
   */
  public static unRegister() {
    WindowSizeChangeNotifyUtil.getInstance().unRegisterImpl();
  }
}