import NavUtil from '../utils/NavUtil'
import { HapticFeedbackEnum, HapticFeedBack } from '../utils/HapticFeedBack';

@Entry
@Component
struct Index {
  build() {
    RelativeContainer() {
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
      .backgroundColor(Color.Blue)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.Gray)
  }
}

/**
 * 顶部导航栏
 */
@Component
struct TopNavWidget {
  build() {
    RelativeContainer() {
      // 标题栏
      RelativeContainer() {
        Text('StatusBar').margin({left: 20})
      }
      .width('100%')
      .backgroundColor(Color.White)
      .margin({top: NavUtil.getInstance().getAppBarHeightPX()})
      .border({width: 1, color: Color.Black})
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
          Text('UI')
          Text('Sensor') {
          }.onClick(() => {
            HapticFeedBack.start(HapticFeedbackEnum.HARD);
          })
          Text('Other')
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
    .backgroundColor(Color.Orange)
    .zIndex(1)
  }
}