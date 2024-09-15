import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { NavUtil } from '@darren/common';
import { HMRouterMgr } from '@hadss/hmrouter';

export default class EntryAbility extends UIAbility {
  private static DOMAIN = 0x0000;
  private static TAG = 'EntryAbility';

  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    // 初始化路由框架
    // 文档: https://gitee.com/hadss/hmrouter
    HMRouterMgr.init({
      context: this.context
    })
    hilog.info(EntryAbility.DOMAIN, EntryAbility.TAG, '%{public}s', 'Ability onCreate');
  }

  onDestroy(): void {
    hilog.info(EntryAbility.DOMAIN, EntryAbility.TAG, '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(EntryAbility.DOMAIN, EntryAbility.TAG, '%{public}s', 'Ability onWindowStageCreate');

    windowStage.loadContent('pages/index/Index', (err) => {
      if (err.code) {
        hilog.error(EntryAbility.DOMAIN, EntryAbility.TAG, 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(EntryAbility.DOMAIN, EntryAbility.TAG, 'Succeeded in loading the content.');

      // 应用沉浸式效果
      NavUtil.init(windowStage);
      NavUtil.setFullScreen(true);
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(EntryAbility.DOMAIN, EntryAbility.TAG, '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(EntryAbility.DOMAIN, EntryAbility.TAG, '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(EntryAbility.DOMAIN, EntryAbility.TAG, '%{public}s', 'Ability onBackground');
  }
}
