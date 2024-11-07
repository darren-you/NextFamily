import { HMAnimatorHandle } from "@hadss/hmrouter"
import { OpacityOption } from "@hadss/hmrouter"
import { ScaleOption } from "@hadss/hmrouter"
import { TranslateOption } from "@hadss/hmrouter"
import { IHMAnimator } from "@hadss/hmrouter"
import { HMAnimator } from "@hadss/hmrouter"

@HMAnimator({ animatorName: 'liveCommentsAnimator' })
export class liveCommentsAnimator implements IHMAnimator {
  effect(enterHandle: HMAnimatorHandle, exitHandle: HMAnimatorHandle): void {
    // 入场动画
    enterHandle.start((translateOption: TranslateOption, scaleOption: ScaleOption,
      opacityOption: OpacityOption) => {
      translateOption.y = '100%'
    })
    enterHandle.finish((translateOption: TranslateOption, scaleOption: ScaleOption,
      opacityOption: OpacityOption) => {
      translateOption.y = '0'
    })
    enterHandle.duration = 500

    // 出场动画
    exitHandle.start((translateOption: TranslateOption, scaleOption: ScaleOption,
      opacityOption: OpacityOption) => {
      translateOption.y = '0'
    })
    exitHandle.finish((translateOption: TranslateOption, scaleOption: ScaleOption,
      opacityOption: OpacityOption) => {
      translateOption.y = '100%'
    })
    exitHandle.duration = 500
  }
}