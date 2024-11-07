import { NavUtil } from '@darren/common'
import { NavConstants } from '../constant/NavConstants'
import { HMRouterMgr } from '@hadss/hmrouter'

@Styles
function globalBorder() {
  .border({ width: 0.5, color: Color.Grey, style: BorderStyle.Solid })
}

@ComponentV2
export struct CustomAppBar {
  @BuilderParam title: string
  @BuilderParam barBackgroundColor: ResourceColor

  build() {
    Column() {
      // 状态栏高
      Row() {}.height(NavUtil.appBarHeightPX())
      // 标题栏
      Row() {
        Button({ buttonStyle: ButtonStyleMode.TEXTUAL }) {
          SymbolGlyph($r('sys.symbol.chevron_left'))
            .fontSize(30)
            .fontWeight(300)
            .renderingStrategy(SymbolRenderingStrategy.MULTIPLE_COLOR)
        }
        .onClick(() => {
          HMRouterMgr.pop({
            navigationId: 'mainNavigationId',
          })
        })
        .width(40)
        .height(40)
        .borderRadius(40)
        .backgroundColor('#ffe7e4e4')
        .margin({ left: 16, right: 12 })
        .id('returnButton')

        Text(this.title).fontSize(20).fontWeight(FontWeight.Bolder)
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height(NavConstants.APP_BAR_HEIGHT)
    .backgroundBlurStyle(BlurStyle.Thin, { colorMode: ThemeColorMode.LIGHT, adaptiveColor: AdaptiveColor.DEFAULT, scale: 1.0 })
    .backgroundColor(this.barBackgroundColor ?? $r('app.color.main_background'))
    .position({ top: 0 })
    .zIndex(999)
  }
}