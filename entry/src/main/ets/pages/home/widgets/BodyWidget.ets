import { ArkUIPage } from '../../arkui/main/ArkUIPage';
import { FunPage } from '../../fun/FunPage';
import { FeaturesPage } from '../../features/FeaturesPage';

/**
 * Body内容区域
 * @param swiperController Swiper控制器
 */
@ComponentV2
export struct BodyWidget {
  @Require @Param swiperController: SwiperController

  build() {
    Column() {
      Swiper(this.swiperController) {
        ArkUIPage()
        FunPage()
        FeaturesPage()
      }
      .disableSwipe(true) // 禁止手动左右滑动
      .indicator(false)
      .loop(false)
    }
    .width('100%')
    .height('100%')
    .zIndex(1)
  }
}