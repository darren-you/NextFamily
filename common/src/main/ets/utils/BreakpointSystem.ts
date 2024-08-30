/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
 * Licensed under the Apache License,Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import mediaQuery from '@ohos.mediaquery';
import { BreakpointConstants } from '../constant/BreakpointConstants';
import { display, window } from '@kit.ArkUI';

declare interface BreakPointTypeOption<T> {
  sm?: T
  md?: T
  lg?: T
  xl?: T
  xxl?: T
}

export class BreakPointType<T> {
  options: BreakPointTypeOption<T>

  constructor(option: BreakPointTypeOption<T>) {
    this.options = option
  }

  getValue(currentBreakPoint: string): T {
    return this.options[currentBreakPoint] as T
  }
}

export class BreakpointSystem {
  private currentBreakpoint: string = '';
  private smListener?: mediaQuery.MediaQueryListener;
  private mdListener?: mediaQuery.MediaQueryListener;
  private lgListener?: mediaQuery.MediaQueryListener;
  private orientationListener?: mediaQuery.MediaQueryListener;

  private updateCurrentBreakpoint(breakpoint: string) {
    if (this.currentBreakpoint !== breakpoint) {
      console.log('callback 屏幕尺寸改变: ' + breakpoint)
      this.currentBreakpoint = breakpoint;
      AppStorage.setOrCreate<string>(BreakpointConstants.CURRENT_BREAKPOINT, this.currentBreakpoint);
    }
  }

  private isBreakpointSM = (mediaQueryResult: mediaQuery.MediaQueryResult) => {
    if (mediaQueryResult.matches) {
      this.updateCurrentBreakpoint(BreakpointConstants.BREAKPOINT_SM);
    }
  }

  private isBreakpointMD = (mediaQueryResult: mediaQuery.MediaQueryResult) => {
    if (mediaQueryResult.matches) {
      this.updateCurrentBreakpoint(BreakpointConstants.BREAKPOINT_MD);
    }
  }

  private isBreakpointLG = (mediaQueryResult: mediaQuery.MediaQueryResult) => {
    if (mediaQueryResult.matches) {
      this.updateCurrentBreakpoint(BreakpointConstants.BREAKPOINT_LG);
    }
  }

  /**
   * 获取屏幕当前方向状态
   * AsyncCallback
   */
  public static getScreenOrientation(): number {
    let currentOrientation: number = BreakpointConstants.LANDSCAPE

    try {
      window.getLastWindow(AppStorage.get('Context'), (err, win) => {
        // 获取当前屏幕的枚举值
        let rotation: number = display.getDefaultDisplaySync().orientation
        let cutOutInfo = win.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM_GESTURE)
        console.log('屏幕方向: ' + rotation + ' 数据: ' + JSON.stringify(cutOutInfo))
        // 根据module.json5中配置的orientation策略，获取到的rotation对应屏幕方向可能会不同
        if (window.Orientation.AUTO_ROTATION) {
          if (rotation == 0) {
            currentOrientation = BreakpointConstants.PORTRAIT
            console.log("正向竖屏");
          } else if (rotation == 1) {
            currentOrientation = BreakpointConstants.LANDSCAPE
            console.log("正向横屏");
          } else if (rotation == 2) {
            currentOrientation = BreakpointConstants.PORTRAIT
            console.log("反向竖屏");
          } else {
            currentOrientation = BreakpointConstants.LANDSCAPE
            console.log("反向横屏");
          }
        }
      })
    } catch (e) {
      console.log('获取屏幕方向状态失败：' + JSON.stringify(e));
    }
    AppStorage.setOrCreate('currentOrientation', currentOrientation)

    return currentOrientation;
  }

  /**
   * 横竖屏变化监听回调
   * 首次启动也会默认触发一次，所以可以将横、竖屏状态自动同步到AppStorage中
   */
  private onOrientation = (mediaQueryResult: mediaQuery.MediaQueryResult) => {
    if (mediaQueryResult.matches) {
      AppStorage.setOrCreate<number>(BreakpointConstants.CURRENT_ORIENTATION, BreakpointConstants.LANDSCAPE);
      console.log('callback 切换为横屏: ' + AppStorage.get<number>(BreakpointConstants.CURRENT_ORIENTATION))
    } else {
      AppStorage.setOrCreate(BreakpointConstants.CURRENT_ORIENTATION, BreakpointConstants.PORTRAIT);
      console.log('callback 切换为竖屏: ' + AppStorage.get<number>(BreakpointConstants.CURRENT_ORIENTATION))
    }
  }

  public register() {
    // 屏幕尺寸变化监听
    this.smListener = mediaQuery.matchMediaSync(BreakpointConstants.RANGE_SM);
    this.smListener.on('change', this.isBreakpointSM);
    this.mdListener = mediaQuery.matchMediaSync(BreakpointConstants.RANGE_MD);
    this.mdListener.on('change', this.isBreakpointMD);
    this.lgListener = mediaQuery.matchMediaSync(BreakpointConstants.RANGE_LG);
    this.lgListener.on('change', this.isBreakpointLG);
    // 屏幕方向变化监听
    this.orientationListener = mediaQuery.matchMediaSync(BreakpointConstants.ORIENTATION);
    this.orientationListener.on('change', this.onOrientation)
  }

  public unregister() {
    this.smListener?.off('change', this.isBreakpointSM);
    this.mdListener?.off('change', this.isBreakpointMD);
    this.lgListener?.off('change', this.isBreakpointLG);
    this.orientationListener?.off('change', this.onOrientation)
  }
}