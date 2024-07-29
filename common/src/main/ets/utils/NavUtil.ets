import { window } from '@kit.ArkUI';
import hilog from '@ohos.hilog';
import { BusinessError } from '@kit.BasicServicesKit';

export class NavUtil {
  private static DOMAIN = 0x0001;
  private static TAG = 'NavUtil';
  private static APP_BAR_HEIGHT = 'appBarHeight';
  private static BOTTOM_RECT_HEIGHT = 'bottomRectHeight';
  private static windowStage: window.WindowStage;
  private static instance: NavUtil;
  private constructor() {}

  public static getInstance(): NavUtil {
    if (!NavUtil.instance) {
      NavUtil.instance = new NavUtil();
    }
    return NavUtil.instance;
  }

  /**
   * 初始化
   * @param windowStage
   */
  public init(windowStage: window.WindowStage): void {
    NavUtil.windowStage = windowStage;
    // 获取顶部状态栏、底部导航条高度
    let windowClass: window.Window = NavUtil.windowStage.getMainWindowSync(); // 获取应用主窗口

    let appBarType = window.AvoidAreaType.TYPE_SYSTEM;
    let appBarAvoidArea = windowClass.getWindowAvoidArea(appBarType);
    let appBarHeight = appBarAvoidArea.topRect.height;
    AppStorage.setOrCreate(NavUtil.APP_BAR_HEIGHT, appBarHeight);

    let bottomRectType = window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR;
    let bottomRectAvoidArea = windowClass.getWindowAvoidArea(bottomRectType);
    let bottomRectHeight = bottomRectAvoidArea.bottomRect.height;
    AppStorage.setOrCreate(NavUtil.BOTTOM_RECT_HEIGHT, bottomRectHeight);

    hilog.info(NavUtil.DOMAIN, NavUtil.TAG, "顶部状态栏高: " + appBarHeight + " 底部导航条高: " + bottomRectHeight);
    hilog.info(NavUtil.DOMAIN, NavUtil.TAG, 'NavUtil初始化完成');
  }

  /**
   * 设置窗口全屏，应用沉浸式效果
   * https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/arkts-develop-apply-immersive-effects-V5#section171801550301
   * @param isLayoutFullScreen
   */
  public setWindowLayoutFullScreen(isLayoutFullScreen: boolean): void {
    let windowClass: window.Window = NavUtil.windowStage.getMainWindowSync(); // 获取应用主窗口
    windowClass.setWindowLayoutFullScreen(isLayoutFullScreen)
      .then(() => {
        hilog.info(NavUtil.DOMAIN, NavUtil.TAG, '设置窗口全屏成功');
      }).catch((err: BusinessError) => {
      hilog.info(NavUtil.DOMAIN, NavUtil.TAG, '设置窗口全屏错误: ' + err);
    });
  }

  /**
   * 获取状态栏高
   * @returns 状态栏高px
   */
  public getAppBarHeightPX(): string {
    return AppStorage.get<number>(NavUtil.APP_BAR_HEIGHT) + 'px';
  }

  /**
   * 获取底部导航条高
   * @returns 底部导航条px
   */
  public getBottomRectHeightPX(): string {
    return AppStorage.get<number>(NavUtil.BOTTOM_RECT_HEIGHT) + 'px';
  }

  /**
   * 获取状态栏高
   * @returns 状态栏高px
   */
  public getAppBarHeight(): number {
    return AppStorage.get<number>(NavUtil.APP_BAR_HEIGHT) ?? 0;
  }

  /**
   * 获取底部导航条高
   * @returns 底部导航条
   */
  public getBottomRectHeight(): number {
    return AppStorage.get<number>(NavUtil.BOTTOM_RECT_HEIGHT) ?? 0;
  }



}