import { Logger, WindowSizeChangeNotifyUtil, FoldStatusChangeNotifyUtil } from '@darren/common'
import { AppBarWidget } from './widgets/AppBarWidget';
import { BodyWidget } from './widgets/BodyWidget';
import { BottomNavWidget } from './widgets/BottomNavWidget';
import { HMRouter } from '@hadss/hmrouter';
import { PageConstants } from '../../constant/PageConstants';

let swiperController: SwiperController = new SwiperController();

@HMRouter({ pageUrl: PageConstants.HOME_PAGE, singleton: true })
@ComponentV2
export struct HomePage {
  build() {
    Column() {
      Stack() {
        // 顶部导航栏
        AppBarWidget()
        // Body内容区域
        BodyWidget({ swiperController })
        // 底部导航栏
        BottomNavWidget({ swiperController })
      }
      .width('100%')
      .height('100%')
      .backgroundColor("$color:main_background")
    }
    .width('100%')
    .height('100%')
    .backgroundColor("$color:main_background")
  }

  aboutToAppear(): void {
    Logger.enabledPrint = true
    // 注册屏幕状态变化监听
    WindowSizeChangeNotifyUtil.register();
    // 折叠屏折叠状态监听
    FoldStatusChangeNotifyUtil.register()
  }

  aboutToDisappear(): void {
    WindowSizeChangeNotifyUtil.unRegister();
    FoldStatusChangeNotifyUtil.unRegister()
  }
}
