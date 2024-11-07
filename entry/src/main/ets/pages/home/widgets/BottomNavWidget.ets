import { NavUtil } from '@darren/common';
import { AppStorageV2 } from '@kit.ArkUI';
import { BottomNavTabVO } from '../vo/BottomNavTabVO';
import { NavConstants } from '../../../constant/NavConstants';

/**
 * 底部导航栏
 * @param swiperController Swiper控制器
 */
@ComponentV2
export struct BottomNavWidget {
  @Require @Param swiperController: SwiperController
  @Local storageBottomNavTabVO: BottomNavTabVO = AppStorageV2.connect(BottomNavTabVO, () => new BottomNavTabVO(0, '控件', $r('sys.symbol.ohos_folder_badge_plus'), true))!;
  bottomTabVOList: Array<BottomNavTabVO>  = this.initBottomTabVOList()

  build() {
    Column() {
      // 导航栏图标
      Row() {
        ForEach(this.bottomTabVOList, (bottomTabVO: BottomNavTabVO) => {
          Column() {
            SymbolGlyph(bottomTabVO.tabIcon)
              .fontSize(26)
              .fontColor(bottomTabVO.currentStatus ? [$r('app.color.bottom_nav_current'), $r('app.color.bottom_nav_current'), $r('app.color.bottom_nav_current')] : [$r('app.color.bottom_nav_normal'), $r('app.color.bottom_nav_normal'), $r('app.color.bottom_nav_normal')])
              .renderingStrategy(SymbolRenderingStrategy.SINGLE)
              .margin({top: 4, bottom: 2})
            Text(bottomTabVO.tabText)
              .height('30%')
              .fontSize(12)
              .fontColor(bottomTabVO.currentStatus ? $r('app.color.item_title_font_current') : $r('app.color.item_title_font_normal'))
          }
          .layoutWeight(1)
          .height('100%')
          .onClick(() => {
            // 清除其他非选中Tab的状态
            this.bottomTabVOList.forEach((originBottomTabVO: BottomNavTabVO) => {
              originBottomTabVO === bottomTabVO ? originBottomTabVO.currentStatus = true : originBottomTabVO.currentStatus = false
            })
            // 滚动Swiper到选中页
            this.swiperController.changeIndex(bottomTabVO.tabIndex, true);
            // 更新AppStorage中选中Tab 数据
            // 对整个对象更新，触发不了UI刷新。这里使用更新某个属性的方式刷新UI
            // todo https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/arkts-new-local-V5#%E8%A7%82%E6%B5%8B%E5%AF%B9%E8%B1%A1%E6%95%B4%E4%BD%93%E5%8F%98%E5%8C%96
            this.storageBottomNavTabVO.currentStatus = bottomTabVO.currentStatus
            this.storageBottomNavTabVO.tabIndex = bottomTabVO.tabIndex
            this.storageBottomNavTabVO.tabIcon = bottomTabVO.tabIcon
            this.storageBottomNavTabVO.tabText = bottomTabVO.tabText
          })
        })
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.SpaceAround)
      .alignItems(VerticalAlign.Center)
      .backgroundColor("$color:bottom_bar_background")
      // 底部导航栏高
      Row() {}.height(NavUtil.bottomRectHeightPX())
    }
    .width('100%')
    .height(NavConstants.BOTTOM_NAV_HEIGHT)
    .backgroundBlurStyle(BlurStyle.Thin, { colorMode: ThemeColorMode.LIGHT, adaptiveColor: AdaptiveColor.DEFAULT, scale: 1.0 })
    .position({ bottom: 0 })
    .zIndex(2)
  }

  /**
   * 初始化底部导航栏Tab数据
   */
  private initBottomTabVOList(): Array<BottomNavTabVO> {
    let tabIconList: Array<Resource> = [
      $r('sys.symbol.ohos_folder_badge_plus'),
      $r('sys.symbol.ohos_circle'),
      $r('sys.symbol.ranking')
    ]
    let tabTextList: Array<string> = [
      "控件",
      "功能",
      "特性"
    ]
    let bottomNavTabVOList: Array<BottomNavTabVO> = new Array<BottomNavTabVO>();
    for (let index = 0; index < tabTextList.length; index++) {
      bottomNavTabVOList.push(new BottomNavTabVO(index, tabTextList[index], tabIconList[index], index === 0 ? true : false))
    }
    return bottomNavTabVOList;
  }
}