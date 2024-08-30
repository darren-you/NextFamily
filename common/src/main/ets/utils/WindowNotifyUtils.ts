import { display, window } from '@kit.ArkUI';
import { Callback } from '@ohos.base';

export enum FOLD_STATUS_CODE {
  UNKNOWN = 0,
  EXPANDED = 1,
  FOLDED = 2,
  HALF_FOLDED = 3
}

export class WindowNotifyUtils {
  private constructor() {}
  public static register(windowClass: window.Window) {
    try {
      windowClass.on('windowSizeChange', (data: window.Size) => {
        console.info('windowSizeChange Data: ' + JSON.stringify(data));
        let ret = { "width": data.width, "height": data.height }
        console.error('windowSizeChange 通知变化后的分辨率: ' + JSON.stringify(ret));
        // JNIEvent.getInstance().onEvent(JNIEvent.RESOLUTION_CHANGE_WHILE_AOCC, JSON.stringify(ret))
        // JNIEvent.getInstance().onEvent(JNIEvent.NOTIFY_ORIENTATION_CHANGE, JSON.stringify(ret))
        //分辨率变化全局设置
      });
    } catch (exception) {
      console.error('Failed to enable the listener for window size changes. Cause: ' + JSON.stringify(exception));
    }
  }

  /**
   * 获取折叠屏当前屏幕状态
   */
  public static getFoldCode(): number{
    let screenStatusCode: number = FOLD_STATUS_CODE.UNKNOWN
    try {
      let code =  display.getFoldStatus();
      console.info('callback 折叠状态: ' + JSON.stringify(code));
      switch (code) {
        // 直屏
        case display.FoldStatus.FOLD_STATUS_UNKNOWN:
          screenStatusCode = FOLD_STATUS_CODE.UNKNOWN
          break
        // 折叠屏 展开态
        case display.FoldStatus.FOLD_STATUS_EXPANDED:
          screenStatusCode = FOLD_STATUS_CODE.EXPANDED
          break
        // 折叠屏 折叠态
        case display.FoldStatus.FOLD_STATUS_FOLDED:
          screenStatusCode = FOLD_STATUS_CODE.FOLDED
          break
        // 折叠屏 半折态
        case display.FoldStatus.FOLD_STATUS_HALF_FOLDED:
          screenStatusCode = FOLD_STATUS_CODE.HALF_FOLDED
          break
        default:
          screenStatusCode = FOLD_STATUS_CODE.UNKNOWN
      }
      AppStorage.setOrCreate('sdkFoldStatus', screenStatusCode)
    } catch (exception) {
      console.error('Failed to obtain the fold status. Code: ' + JSON.stringify(exception));
    }
    return screenStatusCode
  }

  /**
   * 折叠屏折叠状态回调
   * 首次启动默认不会触发回调，所以需要手动调用一次获取折叠状态并同步到AppStorage中
   */
  public static foldOnListener() {
    this.getFoldCode() // 手动调用同步到AppStorage中
    let screenStatusCode: number = FOLD_STATUS_CODE.UNKNOWN
    let callback: Callback<display.FoldStatus> = (data: display.FoldStatus) => {
      console.info('callback 折叠屏折叠状态: ' + JSON.stringify(data));
      switch (data) {
        // 直屏
        case display.FoldStatus.FOLD_STATUS_UNKNOWN:
          screenStatusCode = FOLD_STATUS_CODE.UNKNOWN
          break
        // 折叠屏 展开态
        case display.FoldStatus.FOLD_STATUS_EXPANDED:
          screenStatusCode = FOLD_STATUS_CODE.EXPANDED
          break
        // 折叠屏 折叠态
        case display.FoldStatus.FOLD_STATUS_FOLDED:
          screenStatusCode = FOLD_STATUS_CODE.FOLDED
          break
        // 折叠屏 半折态
        case display.FoldStatus.FOLD_STATUS_HALF_FOLDED:
          screenStatusCode = FOLD_STATUS_CODE.HALF_FOLDED
          break
        default:
          screenStatusCode = FOLD_STATUS_CODE.UNKNOWN
      }
      AppStorage.setOrCreate('sdkFoldStatus', screenStatusCode)
    };
    try {
      display.on('foldStatusChange', callback);
    } catch (exception) {
      console.error('Failed to register callback. Code: ' + JSON.stringify(exception));
    }
  }

  public static foldOffListener() {
    try {
      display.off('foldStatusChange');
    } catch (exception) {
      console.error('折叠屏 Failed to unregister callback. Code: ' + JSON.stringify(exception));
    }
  }
}
