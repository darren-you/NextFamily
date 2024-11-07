import { display } from '@kit.ArkUI';
import { Callback } from '@ohos.base';
import { Logger } from './Logger';

export enum FOLD_STATUS_CODE {
  UNKNOWN = 0,
  EXPANDED = 1,
  FOLDED = 2,
  HALF_FOLDED = 3
}

export class FoldStatusChangeNotifyUtil {
  private constructor() {}

  /**
   * 获取折叠屏当前折叠状态
   */
  public static getNowFoldStatusCode(): number{
    let foldStatusCode: number = FOLD_STATUS_CODE.UNKNOWN
    try {
      let code =  display.getFoldStatus();
      Logger.debug('callback 折叠状态: ' + JSON.stringify(code));
      switch (code) {
        // 直屏
        case display.FoldStatus.FOLD_STATUS_UNKNOWN:
          foldStatusCode = FOLD_STATUS_CODE.UNKNOWN
          break
        // 折叠屏 展开态
        case display.FoldStatus.FOLD_STATUS_EXPANDED:
          foldStatusCode = FOLD_STATUS_CODE.EXPANDED
          break
        // 折叠屏 折叠态
        case display.FoldStatus.FOLD_STATUS_FOLDED:
          foldStatusCode = FOLD_STATUS_CODE.FOLDED
          break
        // 折叠屏 半折态
        case display.FoldStatus.FOLD_STATUS_HALF_FOLDED:
          foldStatusCode = FOLD_STATUS_CODE.HALF_FOLDED
          break
        default:
          foldStatusCode = FOLD_STATUS_CODE.UNKNOWN
      }
      // sdkFoldStatus
      AppStorage.setOrCreate('sdkFoldStatus', foldStatusCode)
    } catch (exception) {
      Logger.debug('Failed to obtain the fold status. Code: ' + JSON.stringify(exception));
    }
    return foldStatusCode
  }

  /**
   * 折叠状态监听
   * 首次启动默认不会触发回调，所以需要手动调用一次获取折叠状态并同步到AppStorage中
   */
  public static register() {
    this.getNowFoldStatusCode()
    let screenStatusCode: number = FOLD_STATUS_CODE.UNKNOWN
    let callback: Callback<display.FoldStatus> = (data: display.FoldStatus) => {
      Logger.debug('callback 折叠屏折叠状态: ' + JSON.stringify(data));
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
      Logger.debug('register 折叠屏手机折叠状态监听');
    } catch (exception) {
      Logger.debug('register 折叠屏手机折叠状态监听 failed: ' + JSON.stringify(exception));
    }
  }

  /**
   * 取消折叠状态监听
   */
  public static unRegister() {
    try {
      display.off('foldStatusChange');
      Logger.debug('unregister 折叠屏手机折叠状态监听');
    } catch (exception) {
      Logger.debug('折叠屏 Failed to unRegister callback. Code: ' + JSON.stringify(exception));
    }
  }
}
