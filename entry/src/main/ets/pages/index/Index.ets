import { HMDefaultGlobalAnimator, HMNavigation, HMRouterMgr } from '@hadss/hmrouter'
import { AttributeUpdater } from '@kit.ArkUI';
import { JumpInfoInterceptor } from '../../hmrouter/interceptors/JumpInfoInterceptor';
import { uiObserver } from '@kit.ArkUI';
import { PageConstants } from '../../constant/PageConstants';
import { RouterConstants } from '../../constant/RouterConstants';
import { AppStoragesKeys } from '../../constant/AppStorageKeys';
import { PageDurationLifecycle } from '../../hmrouter/lifecycle/PageDurationLifecycle';

class MyNavModifier extends AttributeUpdater<NavigationAttribute> {
  initializeModifier(instance: NavigationAttribute): void {
    instance.mode(NavigationMode.Stack);
    instance.navBarWidth('100%');
    instance.hideTitleBar(true);
    instance.hideToolBar(true);
  }
}

@Entry
@Component
struct Index {
  modifier: MyNavModifier = new MyNavModifier()
  private readonly refreshPages: Array<string> = [
    PageConstants.HOME_PAGE,
    PageConstants.TEXT_PAGE,
    'myAccount'
  ]

  aboutToAppear(): void {
    HMRouterMgr.registerGlobalInterceptor({
      interceptor: new JumpInfoInterceptor(),
      interceptorName: RouterConstants.INTERCEPTOR_JUMP_INFO,
      priority: 5,
    })

    HMRouterMgr.registerGlobalLifecycle({
      lifecycle: new PageDurationLifecycle(),
      lifecycleName: RouterConstants.LIFECYCLE_NAME,
      priority: 5,
    })

    uiObserver.on(RouterConstants.UI_OBSERVER_TYPE, this.getUIContext(), {
      navigationId: RouterConstants.NAVIGATION_ID_MAIN
    }, (info) => {
      if (this.refreshPages.includes((info.to as NavDestinationInfo).name.toString())) {
        AppStorage.setOrCreate(AppStoragesKeys.CURRENT_PAGE, (info.to as NavDestinationInfo).name.toString());
      }
    })
  }

  aboutToDisappear(): void {
    uiObserver.off(RouterConstants.UI_OBSERVER_TYPE, this.getUIContext(), {
      navigationId: RouterConstants.NAVIGATION_ID_MAIN
    })
  }

  build() {
    Column() {
      HMNavigation({
        navigationId: RouterConstants.NAVIGATION_ID_MAIN,
        homePageUrl: PageConstants.HOME_PAGE,
        options: {
          standardAnimator: HMDefaultGlobalAnimator.STANDARD_ANIMATOR,
          modifier: this.modifier
        }
      })
    }
    .height('100%')
    .width('100%')
    .backgroundColor($r('app.color.main_background'))
  }
}