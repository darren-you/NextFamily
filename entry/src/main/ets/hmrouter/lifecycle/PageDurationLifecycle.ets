/*
 *   Copyright (c) 2024 Huawei Device Co., Ltd.
 *   Licensed under the Apache License, Version 2.0 (the "License");
 *   you may not use this file except in compliance with the License.
 *   You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 *   Unless required by applicable law or agreed to in writing, software
 *   distributed under the License is distributed on an "AS IS" BASIS,
 *   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *   See the License for the specific language governing permissions and
 *   limitations under the License.
 */

import { IHMLifecycle, HMLifecycleContext } from '@hadss/hmrouter';
import { Logger } from '@darren/common/src/main/ets/utils/Logger';

export class PageDurationLifecycle implements IHMLifecycle {
  public static isDebug = false

  onPrepare(ctx: HMLifecycleContext): void {
    if (PageDurationLifecycle.isDebug) Logger.debug(`navID: ${ctx.navContext?.navDestinationId} pageURL: ${ctx.navContext?.pathInfo.name} param: ${ctx.navContext?.pathInfo.param} state: onPrepare`)
  }

  onAppear(ctx: HMLifecycleContext): void {
    if (PageDurationLifecycle.isDebug) Logger.debug(`navID: ${ctx.navContext?.navDestinationId} pageURL: ${ctx.navContext?.pathInfo.name} param: ${ctx.navContext?.pathInfo.param} state: onAppear`)
  }

  onDisAppear(ctx: HMLifecycleContext): void {
    if (PageDurationLifecycle.isDebug) Logger.debug(`navID: ${ctx.navContext?.navDestinationId} pageURL: ${ctx.navContext?.pathInfo.name} param: ${ctx.navContext?.pathInfo.param} state: onDisAppear`)
  }

  onShown(ctx: HMLifecycleContext): void {
    if (PageDurationLifecycle.isDebug) Logger.debug(`navID: ${ctx.navContext?.navDestinationId} pageURL: ${ctx.navContext?.pathInfo.name} param: ${ctx.navContext?.pathInfo.param} state: onShown`)
  }

  onHidden(ctx: HMLifecycleContext): void {
    if (PageDurationLifecycle.isDebug) Logger.debug(`navID: ${ctx.navContext?.navDestinationId} pageURL: ${ctx.navContext?.pathInfo.name} param: ${ctx.navContext?.pathInfo.param} state: onHidden`)
  }

  onWillAppear(ctx: HMLifecycleContext): void {
    if (PageDurationLifecycle.isDebug) Logger.debug(`navID: ${ctx.navContext?.navDestinationId} pageURL: ${ctx.navContext?.pathInfo.name} param: ${ctx.navContext?.pathInfo.param} state: onWillAppear`)
  }

  onWillDisappear(ctx: HMLifecycleContext): void {
    if (PageDurationLifecycle.isDebug) Logger.debug(`navID: ${ctx.navContext?.navDestinationId} pageURL: ${ctx.navContext?.pathInfo.name} param: ${ctx.navContext?.pathInfo.param} state: onWillDisappear`)
  }

  onWillShow(ctx: HMLifecycleContext): void {
    if (PageDurationLifecycle.isDebug) Logger.debug(`navID: ${ctx.navContext?.navDestinationId} pageURL: ${ctx.navContext?.pathInfo.name} param: ${ctx.navContext?.pathInfo.param} state: onWillShow`)
  }

  onWillHide(ctx: HMLifecycleContext): void {
    if (PageDurationLifecycle.isDebug) Logger.debug(`navID: ${ctx.navContext?.navDestinationId} pageURL: ${ctx.navContext?.pathInfo.name} param: ${ctx.navContext?.pathInfo.param} state: onWillHide`)
  }

  onReady(ctx: HMLifecycleContext): void {
    if (PageDurationLifecycle.isDebug) Logger.debug(`navID: ${ctx.navContext?.navDestinationId} pageURL: ${ctx.navContext?.pathInfo.name} param: ${ctx.navContext?.pathInfo.param} state: onReady`)
  }

  onBackPressed(ctx: HMLifecycleContext): boolean {
    if (PageDurationLifecycle.isDebug) Logger.debug(`navID: ${ctx.navContext?.navDestinationId} pageURL: ${ctx.navContext?.pathInfo.name} param: ${ctx.navContext?.pathInfo.param} state: onBackPressed`)
    return false
  }
}