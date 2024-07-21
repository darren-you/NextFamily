import { vibrator } from '@kit.SensorServiceKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { Logger } from './Logger';

export class HapticFeedBack {
  private constructor() {
  }

  static start(hapticFeedbackEnum: HapticFeedbackEnum): void {
    let feedBackType = vibrator.HapticFeedback.EFFECT_SOFT;

    switch (hapticFeedbackEnum) {
      case HapticFeedbackEnum.SOFT:
        feedBackType = vibrator.HapticFeedback.EFFECT_SOFT;
        break
      case HapticFeedbackEnum.HARD:
        feedBackType = vibrator.HapticFeedback.EFFECT_HARD;
        break
      case HapticFeedbackEnum.SHARP:
        feedBackType = vibrator.HapticFeedback.EFFECT_SHARP;
        break
    }
    try {
      // 查询是否支持 haptic effect
      vibrator.isSupportEffect(feedBackType, (err: BusinessError, state: boolean) => {
        if (err) {
          Logger.error(`haptic error_0 Code: ${err.code}, message: ${err.message}`);
          return;
        }
        if (state) {
          try {
            // 触发马达振动
            vibrator.startVibration({
              type: 'preset',
              effectId: vibrator.HapticFeedback.EFFECT_SOFT,
              count: 1,
              intensity: 50,
            }, {
              usage: 'unknown'
            }, (error: BusinessError) => {
              if (error) {
                Logger.error(`haptic error_1 Code: ${error.code}, message: ${error.message}`);
              } else {

              }
            });
          } catch (error) {
            let e: BusinessError = error as BusinessError;
            Logger.error(`haptic error_2 Code: ${e.code}, message: ${e.message}`);
          }
        }
      })
    } catch (error) {
      let e: BusinessError = error as BusinessError;
      Logger.error(`haptic error_3 Code: ${e.code}, message: ${e.message}`);
    }
  }

}

export enum HapticFeedbackEnum {
  SOFT,
  HARD,
  SHARP,
}