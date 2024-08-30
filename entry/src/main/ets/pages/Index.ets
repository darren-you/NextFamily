import { AppStorageV2 } from '@kit.ArkUI';
import { NavUtil } from '@darren/common'

let appBarHeight: number = 90;
let bottomNavHeight: number = 80;
let swiperController: SwiperController = new SwiperController();

@Entry
@ComponentV2
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
@ComponentV2
struct TopNavWidget {
  @Local currentNavTabState: NavTabState = AppStorageV2.connect(NavTabState, () => new NavTabState())!;

  build() {
    Column() {
      // 标题栏
      Row() {
        Text(this.currentNavTabState.titleText).fontSize(26).margin({left: 20}).fontWeight(FontWeight.Bold)
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
@ComponentV2
struct BottomNavWidget {
  @Local currentNavTabState: NavTabState = AppStorageV2.connect(NavTabState, () => new NavTabState())!;

  build() {
    Row() {
      Row() {
        Column() {
          SymbolGlyph($r('sys.symbol.ohos_folder_badge_plus'))
            .fontSize(26)
            .fontColor(this.currentNavTabState.currentNavTab === 0 ? [$r('app.color.bottom_nav_current'), $r('app.color.bottom_nav_current'), $r('app.color.bottom_nav_current')] : [$r('app.color.bottom_nav_normal'), $r('app.color.bottom_nav_normal'), $r('app.color.bottom_nav_normal')])
            .renderingStrategy(SymbolRenderingStrategy.SINGLE)
            .margin({top: 4, bottom: 2})
          Text('控件')
            .height('30%')
            .fontSize(12)
            .fontColor(this.currentNavTabState.currentNavTab === 0 ? $r('app.color.item_title_font_current') : $r('app.color.item_title_font_normal'))
        }
        .width('33%')
        .height('100%')
        .onClick(() => {
          currentNavTab(0);
          this.currentNavTabState.currentNavTab = 0;
          this.currentNavTabState.titleText = "控件";
        })

        Column() {
          SymbolGlyph($r('sys.symbol.ohos_circle'))
            .fontSize(26)
            .fontColor(this.currentNavTabState.currentNavTab === 1 ? [$r('app.color.bottom_nav_current'), $r('app.color.bottom_nav_current'), $r('app.color.bottom_nav_current')] : [$r('app.color.bottom_nav_normal'), $r('app.color.bottom_nav_normal'), $r('app.color.bottom_nav_normal')])
            .renderingStrategy(SymbolRenderingStrategy.SINGLE)
            .margin({top: 4, bottom: 2})
          Text('功能')
            .height('30%')
            .fontSize(12)
            .fontColor(this.currentNavTabState.currentNavTab === 1 ? $r('app.color.item_title_font_current') : $r('app.color.item_title_font_normal'))
        }
        .width('33%')
        .height('100%')
        .onClick(() => {
          currentNavTab(1);
          this.currentNavTabState.currentNavTab = 1;
          this.currentNavTabState.titleText = "功能";
        })

        Column() {
          SymbolGlyph($r('sys.symbol.ranking'))
            .fontSize(26)
            .fontColor(this.currentNavTabState.currentNavTab === 2 ? [$r('app.color.bottom_nav_current'), $r('app.color.bottom_nav_current'), $r('app.color.bottom_nav_current')] : [$r('app.color.bottom_nav_normal'), $r('app.color.bottom_nav_normal'), $r('app.color.bottom_nav_normal')])
            .renderingStrategy(SymbolRenderingStrategy.SINGLE)
            .margin({top: 4, bottom: 2})
          Text('特性')
            .height('30%')
            .fontSize(12)
            .fontColor(this.currentNavTabState.currentNavTab === 2 ? $r('app.color.item_title_font_current') : $r('app.color.item_title_font_normal'))
        }
        .width('33%')
        .height('100%')
        .onClick(() => {
          currentNavTab(2);
          this.currentNavTabState.currentNavTab = 2;
          this.currentNavTabState.titleText = "特性";
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
      Swiper(swiperController) {
        Column(){
          Text('控件')
            .textAlign(TextAlign.Center)
            .fontSize(14)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .backgroundColor(Color.Green)
        .padding({top: appBarHeight, bottom: bottomNavHeight})

        Column(){
          Text('功能')
            .textAlign(TextAlign.Center)
            .fontSize(14)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .backgroundColor(Color.Blue)
        .padding({top: appBarHeight, bottom: bottomNavHeight})

        Column(){
          Text('特性')
            .textAlign(TextAlign.Center)
            .fontSize(14)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .backgroundColor(Color.Yellow)
        .padding({top: appBarHeight, bottom: bottomNavHeight})
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

// Swiper切换选中Page
function currentNavTab(navTabEnum: number): void {
  swiperController.changeIndex(navTabEnum.valueOf(), true);
}

// 数据中心
@ObservedV2
export class NavTabState {
  @Trace currentNavTab: number = 0;
  @Trace titleText: string = "控件";
}
