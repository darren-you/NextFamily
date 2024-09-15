import { NavConstants } from '../../constant/NavConstants'

@ComponentV2
export struct FeaturesPage {
  build() {
    Column(){
      Text('特性')
        .textAlign(TextAlign.Center)
        .fontSize(14)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundColor("$color:main_background")
    .padding({ top: NavConstants.APP_BAR_HEIGHT, bottom: NavConstants.BOTTOM_NAV_HEIGHT })
  }
}