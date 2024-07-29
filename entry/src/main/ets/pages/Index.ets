import { NavUtil } from '@darren/common'

let appBarHeight: number = 90;
let bottomNavHeight: number = 80;
let swiperController: SwiperController = new SwiperController();

@Entry
@Component
struct Index {
  @State currentNavTab: NavTabEnum = NavTabEnum.COMPONENTS;
  build() {
    Column() {
      Stack() {
        // 顶部导航栏
        TopNavWidget()
        // Body内容区域
        BodyWidget()
        // 底部导航栏
        BottomNavWidget(currentNavTab)
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
      .height(appBarHeight - (px2vp(NavUtil.getInstance().getAppBarHeight())))
      .margin({top: NavUtil.getInstance().getAppBarHeightPX()})
    }
    .width('100%')
    .height(appBarHeight)
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
    Row() {
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
        .onClick(() => {
          currentNavTab(NavTabEnum.COMPONENTS);
          this.
        })

        Column() {
          SymbolGlyph($r('sys.symbol.ohos_circle'))
            .fontSize(26)
            .renderingStrategy(SymbolRenderingStrategy.SINGLE)
            .margin({top: 4, bottom: 2})
          Text('功能').height('30%').fontSize(12)
        }
        .width('33%')
        .height('100%')
        .onClick(() => {
          currentNavTab(NavTabEnum.FEATURE);
        })

        Column() {
          SymbolGlyph($r('sys.symbol.ranking'))
            .fontSize(26)
            .renderingStrategy(SymbolRenderingStrategy.SINGLE)
            .margin({top: 4, bottom: 2})
          Text('特性').height('30%').fontSize(12)
        }
        .width('33%')
        .height('100%')
        .onClick(() => {
          currentNavTab(NavTabEnum.SPECIAL);
        })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.SpaceAround)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(bottomNavHeight)
    .backgroundColor(Color.White)
    .position({bottom: 0})
    .padding({bottom: NavUtil.getInstance().getBottomRectHeightPX()})
    .zIndex(2)

  }
}

/**
 * Body内容区域
 */
@Component
struct BodyWidget {
  build() {
    Column() {
      // todo Swiper需要禁止手动左右滑动
      Swiper(swiperController) {
        Column(){
          Text('控件')
            .textAlign(TextAlign.Center)
            .fontSize(14)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .backgroundColor("$color:main_background")
        .padding({top: appBarHeight, bottom: bottomNavHeight})


        Column(){
          Text('功能')
            .textAlign(TextAlign.Center)
            .fontSize(14)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .backgroundColor("$color:main_background")
        .padding({top: appBarHeight, bottom: bottomNavHeight})

        Column(){
          Text('特性')
            .textAlign(TextAlign.Center)
            .fontSize(14)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .backgroundColor("$color:main_background")
        .padding({top: appBarHeight, bottom: bottomNavHeight})
      }
      .indicator(false)
      .loop(false)
    }
    .width('100%')
    .height('100%')
    .zIndex(1)
  }
}

function currentNavTab(navTabEnum: NavTabEnum): void {
  swiperController.changeIndex(navTabEnum.valueOf(), true);
}

enum NavTabEnum {
  COMPONENTS = 0,
  FEATURE = 1,
  SPECIAL = 2,
}
