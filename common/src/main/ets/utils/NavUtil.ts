import { window } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';
import { Logger } from './Logger';

export class NavUtil {
  private static APP_BAR_HEIGHT = 'appBarHeight';
  private static BOTTOM_RECT_HEIGHT = 'bottomRectHeight';
  public static FULL_SCREEN = false;
  private static windowStage: window.WindowStage;
  private static instance: NavUtil;
  private constructor() {}

  protected static getInstance(): NavUtil {
    if (!NavUtil.instance) {
      NavUtil.instance = new NavUtil();
    }
    return NavUtil.instance;
  }

  /**
   * 初始化
   * @param windowStage
   */
  protected initNavUtil(windowStage: window.WindowStage): void {
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

    Logger.debug("顶部状态栏高: " + appBarHeight + " 底部导航条高: " + bottomRectHeight);
    Logger.debug('NavUtil初始化完成');
  }

  /**
   * 设置窗口全屏，应用沉浸式效果
   * https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/arkts-develop-apply-immersive-effects-V5#section171801550301
   * @param isLayoutFullScreen
   */
  protected setWindowLayoutFullScreen(isLayoutFullScreen: boolean): void {
    let windowClass: window.Window = NavUtil.windowStage.getMainWindowSync(); // 获取应用主窗口
    windowClass.setWindowLayoutFullScreen(isLayoutFullScreen)
      .then(() => {
        Logger.debug('设置窗口全屏成功');
      }).catch((err: BusinessError) => {
      Logger.debug('设置窗口全屏错误: ' + err);
    });
  }

  /**
   * 获取状态栏高
   * @returns 状态栏高px
   */
  protected getAppBarHeightPX(): string {
    return AppStorage.get<number>(NavUtil.APP_BAR_HEIGHT) + 'px';
  }

  /**
   * 获取底部导航条高
   * @returns 底部导航条px
   */
  protected getBottomRectHeightPX(): string {
    return AppStorage.get<number>(NavUtil.BOTTOM_RECT_HEIGHT) + 'px';
  }

  /**
   * 获取状态栏高
   * @returns 状态栏高px
   */
  protected getAppBarHeight(): number {
    return AppStorage.get<number>(NavUtil.APP_BAR_HEIGHT) ?? 0;
  }

  /**
   * 获取底部导航条高
   * @returns 底部导航条
   */
  protected getBottomRectHeight(): number {
    return AppStorage.get<number>(NavUtil.BOTTOM_RECT_HEIGHT) ?? 0;
  }

  public static init(windowStage: window.WindowStage): void {
    NavUtil.getInstance().initNavUtil(windowStage);
  }

  public static setFullScreen(isFullScreen: boolean): void {
    NavUtil.getInstance().setWindowLayoutFullScreen(isFullScreen);
  }

  public static appBarHeightPX(): string {
    return NavUtil.getInstance().getAppBarHeightPX();
  }

  public static bottomRectHeightPX(): string {
    return NavUtil.getInstance().getBottomRectHeightPX();
  }

  public static appBarHeight(): number {
    return NavUtil.getInstance().getAppBarHeight();
  }

  public static bottomRectHeight(): number {
    return NavUtil.getInstance().getBottomRectHeight();
  }

}