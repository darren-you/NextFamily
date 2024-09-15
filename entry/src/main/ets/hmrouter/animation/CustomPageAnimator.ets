import { HMAnimator, HMAnimatorHandle, IHMAnimator, OpacityOption, ScaleOption, TranslateOption } from '../../../../../oh_modules/@hadss/hmrouter'

@HMAnimator({ animatorName: 'CustomPageAnimator' })
export class CustomPageAnimator implements IHMAnimator {
  static PAGE_ANIMATOR: IHMAnimator.Effect = new IHMAnimator.Effect({
    direction: IHMAnimator.Direction.RIGHT_TO_LEFT,
    opacity: { opacity: 0.5 }
  })

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
    enterHandle.duration = 5000

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