import NavUtil from '../utils/NavUtil'
import { HapticFeedbackEnum, HapticFeedBack } from '../utils/HapticFeedBack';

@Entry
@Component
struct Index {
  build() {
    Column() {
      Stack() {
        // 顶部导航栏
        TopNavWidget()
        // Body内容区域
        BodyWidget()
        // 底部导航栏
        BottomNavWidget()
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(0xE5E5E5)
  }
}

/**
 * 顶部导航栏
 */
@Component
struct TopNavWidget {
  build() {
    Column() {
      // 标题栏
      Row() {
        Text('控件').fontSize(26).margin({left: 20}).fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .height(90 - (px2vp(NavUtil.getInstance().getAppBarHeight())))
      .margin({top: NavUtil.getInstance().getAppBarHeightPX()})
    }
    .width('100%')
    .height(90)
    .backgroundColor(Color.White)
    .position({top: 0})
    .zIndex(3)
  }
}

/**
 * 底部导航栏
 */
@Component
struct BottomNavWidget {
  build() {
    RelativeContainer() {
      RelativeContainer() {
        Row() {
          Column() {
            SymbolGlyph($r('sys.symbol.ohos_folder_badge_plus'))
              .fontSize(26)
              .fontColor([$r('app.color.bottom_nav_current'), $r('app.color.bottom_nav_current'), $r('app.color.bottom_nav_current')])
              .renderingStrategy(SymbolRenderingStrategy.SINGLE)
              .margin({top: 4, bottom: 2})
            Text('控件').height('30%').fontSize(12).fontColor(0x3B7AEA)
          }
          .width('33%')
          .height('100%')

          Column() {
            SymbolGlyph($r('sys.symbol.ohos_circle'))
              .fontSize(26)
              .renderingStrategy(SymbolRenderingStrategy.SINGLE)
              .margin({top: 4, bottom: 2})
            Text('功能').height('30%').fontSize(12)
          }
          .width('33%')
          .height('100%')

          Column() {
            SymbolGlyph($r('sys.symbol.ranking'))
              .fontSize(26)
              .renderingStrategy(SymbolRenderingStrategy.SINGLE)
              .margin({top: 4, bottom: 2})
            Text('特性').height('30%').fontSize(12)
          }
          .width('33%')
          .height('100%')

        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.SpaceAround)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .backgroundColor(Color.White)
      .margin({bottom: NavUtil.getInstance().getBottomRectHeightPX()})
      //.border({width: 1, color: Color.Black})
    }
    .width('100%')
    .height(80)
    .backgroundColor(Color.White)
    .position({bottom: 0})
    .zIndex(2)

  }
}

/**
 * Body内容区域
 */
@Component
struct BodyWidget {
  build() {
    RelativeContainer() {
      Text('Title')
    }
    .width('100%')
    .height('100%')
    .zIndex(1)
  }
}