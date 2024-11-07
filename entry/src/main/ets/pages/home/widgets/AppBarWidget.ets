import { NavUtil } from '@darren/common';
import { AppStorageV2 } from '@kit.ArkUI';
import { BottomNavTabVO } from '../vo/BottomNavTabVO';
import { NavConstants } from '../../../constant/NavConstants';

/**
 * 顶部导航栏
 */
@ComponentV2
export struct AppBarWidget {
  @Local storageBottomNavTabVO: BottomNavTabVO = AppStorageV2.connect(BottomNavTabVO, () => new BottomNavTabVO(0, '控件', $r('sys.symbol.ohos_folder_badge_plus'), true))!;

  build() {
    Column() {
      // 状态栏高
      Row() {}.height(NavUtil.appBarHeightPX())
      // 标题栏
      Row() {
        Text(this.storageBottomNavTabVO.tabText).fontSize(18).fontWeight(FontWeight.Medium)
      }
      .justifyContent(FlexAlign.Center)
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height(NavConstants.APP_BAR_HEIGHT)
    .backgroundBlurStyle(BlurStyle.Thin, { colorMode: ThemeColorMode.LIGHT, adaptiveColor: AdaptiveColor.DEFAULT, scale: 1.0 })
    .position({ top: 0 })
    .zIndex(3)
  }
}