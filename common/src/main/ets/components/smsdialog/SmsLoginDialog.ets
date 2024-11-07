import { promptAction } from '@kit.ArkUI'
import { THIRD_LOGIN_TYPE } from './ThirdLoginEnum'
import { ThirdLoginVO } from './ThirdLoginVO'
import { SmsLoginDialogVO } from './SmsLoginDialogVO'
import { CommonDialog } from '../CommonDialog'
import { AgreementDocDialogVO } from '../agreementdialog/AgreementDocDialogVO'
import { AgreementDocDialogComponent } from '../agreementdialog/AgreementDocDialog'
import { Logger } from '../../utils/Logger'
import { DeviceScreenConstants } from '../../constant/DeviceScreenConstants'
import { PhoneNumberUtil } from '../../utils/PhoneNumberUtil'
import { VerifyCodeUtil } from '../../utils/VerifyCodeUtil'

/**
 * 第三方登录
 */
@Component
struct ThirdLoginComponent {
  @Link agreementState: boolean
  thirdLoginCallback?: (thirdLoginType: THIRD_LOGIN_TYPE) => void
  private thirdLoginList: ThirdLoginVO[] = [new ThirdLoginVO(THIRD_LOGIN_TYPE.WECHAT, '微信', $rawfile('img/we_chat.png'))]

  build() {
    Column() {
      Row() {
        Row() {}.backgroundColor('#9e9e9e').height(1).width(50)
        Text('其他登录方式').fontSize(14).fontColor('#757575').margin({left: 8, right: 8})
        Row() {}.backgroundColor('#9e9e9e').height(1).width(50)
      }.margin({top: 16, bottom: 12})

      Row() {
        // 登录方式不多未使用List
        Stack() {
          Circle({ width: 40, height: 40 })
            .fill(Color.Transparent)
            .stroke('#9e9e9e')
            .strokeWidth(1)
          Image(this.thirdLoginList[0].thirdLoginTypeIcon)
            .width(30).height(30)
        }
        .onClick(() => {
          this.useThirdLogin(this.thirdLoginList[0].thirdLoginType)
        })
      }
      .width('100%')
      .height('14%')
      .justifyContent(FlexAlign.Center)
      .margin({bottom: 4})
    }
  }

  /**
   * 选择第三方登录
   */
  useThirdLogin(thirdLoginType: THIRD_LOGIN_TYPE): void {
    if (this.agreementState == false) {
      promptAction.showToast({
        message: '请先阅读并同意服务条款',
        duration: 2000,
      })
      return
    }
    switch (thirdLoginType) {
      case THIRD_LOGIN_TYPE.WECHAT:
        this.thirdLoginCallback?.(thirdLoginType)
        // todo 使用微信登录具体实现
        break
      default :
        Logger.debug('Unknown thirdLogin type')
        return
    }
  }
}

/**
 * 用户协议
 */
@Component
struct AgreementComponent {
  @Link agreementState: boolean

  build() {
    Row() {
      Checkbox()
        .select(this.agreementState)
        .onChange((selectStatus: boolean) => {
          Logger.debug('selectStatus = ' + selectStatus)
          this.agreementState = selectStatus
        })
      Text(' 我已阅读并同意').fontSize(12).fontColor('#6c6c6c')
      Text('《用户协议》').fontSize(12).fontColor(Color.Blue).onClick(() => {
        showAgreementDocDialog(1, 0)
      })
      Text('、').fontSize(12).fontColor(Color.Blue)
      Text('《隐私政策》').fontSize(12).fontColor(Color.Blue).onClick(() => {
        showAgreementDocDialog(2, 0)
      })
    }.margin({top: 10, bottom: 10})
  }
}

@Component
export struct SmsLoginDialog {
  @StorageProp('currentBreakpoint') currentBreakpoint: string = 'md';
  @StorageProp('currentOrientation') currentOrientation: number = DeviceScreenConstants.DEVICE_SCREEN_LANDSCAPE
  @StorageProp('sdkFoldStatus') sdkFoldStatus: number = 0;

  SMS_COUNTDOWN_TIME: number = 60
  @State phoneNumberValue: string = ''
  @State verifyCodeValue: string = ''
  @State requestSmsCodeTimer: number = this.SMS_COUNTDOWN_TIME

  @State phoneNumberState: boolean = false
  @State verifyCodeState: boolean = false
  @State agreementState: boolean = false

  smsLoginDialogVO?: SmsLoginDialogVO

  build() {
    Column() {
      Stack() {
        Text('验证码登录').fontSize(20).margin({ top: 16, bottom: 8})
        Row() {
          SymbolGlyph($r('sys.symbol.xmark'))
            .fontSize(24)
            .fontColor([Color.Black])
            .renderingStrategy(SymbolRenderingStrategy.SINGLE)
            .onClick(() => {
              CommonDialog.getInstance().closeDialog(this.smsLoginDialogVO?.dialogId)
              this.smsLoginDialogVO?.cancelCallback?.()
              // todo 通知游戏用户取消登录
            })
        }.justifyContent(FlexAlign.End).width('100%').position({ top: 16, right: 16 })
      }.height('12%').margin({bottom: 8})

      Row() {
        TextInput({ placeholder: '请输入手机号', text: this.phoneNumberValue }).height(60).width('90%')
          .placeholderColor('#9e9e9e')
          //.height('14%')
          .height('20%')
          .showUnderline(true)
          .onChange((value: string) => {
            this.phoneNumberValue = value
            this.phoneNumberState = PhoneNumberUtil.isValidPhoneNumber(value)
          })
      }.margin({left: 16, right: 16})

      Stack() {
        Row() {
          TextInput({ placeholder: '请输入验证码', text: this.verifyCodeValue }).height(60).width('90%')
            .placeholderColor('#9e9e9e')
            .showUnderline(true)
            .maxLength(4)
            //.height('14%')
            .height('20%')
            .onChange((value: string) => {
              this.verifyCodeValue = value
              this.verifyCodeState = VerifyCodeUtil.checkVerifyCode(value)
            })
        }.margin({left: 16, right: 16})

        Row() {
          Text(this.requestSmsCodeTimer == this.SMS_COUNTDOWN_TIME ? '获取验证码' : `重新获取(${this.requestSmsCodeTimer})s`)
            .fontColor((this.phoneNumberState && this.agreementState && this.requestSmsCodeTimer == this.SMS_COUNTDOWN_TIME) ? Color.Blue : '#9e9e9e')
            .onClick(() => {
              this.requestSmsCode(this.phoneNumberValue)
            })
        }
        //.height('14%')
        .height('20%')
        .position({right: 16})
      }

      Row() {
        Button('验证码登录', {stateEffect: false})
          //.height('14%')
          .height('20%')
          .width('100%')
          .backgroundColor((this.agreementState && this.phoneNumberState && this.verifyCodeState) ? '#0a56ed' : '#EDEDED')
          .fontColor((this.agreementState && this.phoneNumberState && this.verifyCodeState) ? Color.White : '#cccccc')
          .fontSize(20)
          .stateEffect(this.agreementState && this.phoneNumberState && this.verifyCodeState)
          .onClick(() => {
            if ((this.agreementState && this.phoneNumberState && this.verifyCodeState) == false) return
            this.smsLoginDialogVO?.smsLoginCallback?.(this.phoneNumberValue, this.verifyCodeValue)
          })
      }.margin({left: 30, top: 16, right: 30, bottom: 16})

      // 第三方登录
      //ThirdLoginComponent({agreementState: this.agreementState, thirdLoginCallback: this.smsLoginDialogVO?.thirdLoginCallback})

      // 底部用户协议
      AgreementComponent({agreementState: this.agreementState})
    }
    .backgroundColor(Color.White)
    .borderRadius(12)
    .width(this.getWidth())
    .height(this.getHeight())
  }

  getWidth(): Length {
    Logger.debug('getWidth 折叠状态: ' + this.sdkFoldStatus + ' 屏幕方向: ' + this.currentOrientation)
    let defaultWidth = '50%'
    switch (this.sdkFoldStatus) {
      // Unknown | 直屏
      case 0:
        this.currentOrientation === DeviceScreenConstants.DEVICE_SCREEN_PORTRAIT ? defaultWidth = '80%' : defaultWidth = '50%'
        Logger.debug('Unknown | 直屏 宽: ' + defaultWidth)
        break
      // 折叠屏 [展开、半折] 态
      case 1:
      case 3:
        this.currentOrientation === DeviceScreenConstants.DEVICE_SCREEN_PORTRAIT ? defaultWidth = '55%' : defaultWidth = '50%'
        Logger.debug('折叠屏 [展开、半折] 态 宽: ' + defaultWidth)
        break
      // 折叠屏 折叠态
      case 2:
        this.currentOrientation === DeviceScreenConstants.DEVICE_SCREEN_PORTRAIT ? defaultWidth = '90%' : defaultWidth = '50%'
        Logger.debug('折叠屏 折叠态 宽: ' + defaultWidth)
        break
      default:
        defaultWidth = '50%'
        Logger.debug('未知态默认 宽: ' + defaultWidth)
    }
    return defaultWidth
  }

  getHeight(): Length {
    Logger.debug('getHeight 折叠状态: ' + this.sdkFoldStatus + ' 屏幕方向: ' + this.currentOrientation)
    let defaultHeight = '50%'
    switch (this.sdkFoldStatus) {
      // Unknown | 直屏
      case 0:
        //this.currentOrientation === BreakpointConstants.PORTRAIT ? defaultHeight = '30%' : defaultHeight = '90%'
        this.currentOrientation === DeviceScreenConstants.DEVICE_SCREEN_PORTRAIT ? defaultHeight = '35%' : defaultHeight = '75%'
        Logger.debug('Unknown | 直屏 高: ' + defaultHeight)
        break
      // 折叠屏 [展开、半折] 态
      case 1:
      case 3:
        //this.currentOrientation === BreakpointConstants.PORTRAIT ? defaultHeight = '45%' : defaultHeight = '50%'
        this.currentOrientation === DeviceScreenConstants.DEVICE_SCREEN_PORTRAIT ? defaultHeight = '35%' : defaultHeight = '40%'
        Logger.debug('折叠屏 [展开、半折] 态 高: ' + defaultHeight)
        break
      // 折叠屏 折叠态
      case 2:
        //this.currentOrientation === BreakpointConstants.PORTRAIT ? defaultHeight = '45%' : defaultHeight = '90%'
        this.currentOrientation === DeviceScreenConstants.DEVICE_SCREEN_PORTRAIT ? defaultHeight = '35%' : defaultHeight = '80%'
        Logger.debug('折叠屏 折叠态 高: ' + defaultHeight)
        break
      default:
        defaultHeight = '50%'
        Logger.debug('未知态默认 高: ' + defaultHeight)
    }
    return defaultHeight
  }

  /**
   * 获取验证码
   */
  requestSmsCode(phoneNumber: string): void {
    Logger.debug('requestSmsCode phoneNumber: ' + phoneNumber)
    let toastContent: string | null = null
    // 手机号码错误
    if (PhoneNumberUtil.isValidPhoneNumber(this.phoneNumberValue) == false) toastContent = '请输入正确的手机号码'
    // 未勾选服务条款
    if (this.agreementState == false) toastContent = '请先阅读并同意服务条款'
    if (toastContent != null) {
      promptAction.showToast({
        message: toastContent,
        duration: 2000,
      })
      return
    }
    // 60秒倒计时内
    if (this.requestSmsCodeTimer != this.SMS_COUNTDOWN_TIME) return

    // 开始请求获取验证码...
    try {
      // todo 伪代码请求验证码，成功与失败状态响应
      let requestSmsCodeResponse = true

      if (requestSmsCodeResponse) {
        // todo 请求成功后实现
        promptAction.showToast({
          message: '验证码已下发',
          duration: 2000,
        })

        this.smsLoginDialogVO?.requestSmsCodeCallback?.(phoneNumber, true, '请求验证码成功返回数据')
        // 获取成功，重新获取验证码倒计时
        let smsRetryCountDown = setInterval(() => {
          if (this.requestSmsCodeTimer != 0) {
            this.requestSmsCodeTimer --
            Logger.debug('sms count down: ' + this.requestSmsCodeTimer);
          } else {
            clearInterval(smsRetryCountDown)
            this.requestSmsCodeTimer = this.SMS_COUNTDOWN_TIME
            Logger.debug('sms count rest');
          }
        }, 1000);

        // todo 请求失败、验证码错误过期处理
      } else {
        this.smsLoginDialogVO?.requestSmsCodeCallback?.(phoneNumber, false, null)
        // 获取失败，toast
        promptAction.showToast({
          message: '获取失败',
          duration: 2000,
        })
      }
    }
    catch (error) {
      this.smsLoginDialogVO?.requestSmsCodeCallback?.(phoneNumber, false, null)
      // 获取错误
      Logger.debug('requestSmsCode error: ' + error)
      promptAction.showToast({
        message: '获取失败: ' + error,
        duration: 2000,
      })
    }
  }

  aboutToAppear(): void {
    let nowBreakpoint: string | null | undefined = AppStorage.get(DeviceScreenConstants.CURRENT_BREAKPOINT)
    let nowOrientation: number | null | undefined = AppStorage.get(DeviceScreenConstants.CURRENT_ORIENTATION)
    let nowFoldStatus: number | null | undefined = AppStorage.get('sdkFoldStatus')

    console.log('nowBreakpoint: ' + nowBreakpoint + ' nowOrientation: ' + nowOrientation + ' nowFoldStatus: ' + nowFoldStatus)


    if (nowBreakpoint != null && nowBreakpoint != undefined) this.currentBreakpoint = nowBreakpoint
    if (nowOrientation != null && nowOrientation != undefined) this.currentOrientation = nowOrientation
    if (nowFoldStatus != null && nowFoldStatus != undefined) this.sdkFoldStatus = nowFoldStatus

    Logger.debug('初始化屏幕状态信息 breakpoint: ' + this.currentBreakpoint + ' orientation: ' + this.currentOrientation + ' fold: ' + this.sdkFoldStatus)
  }

}

@Builder
export function SmsLoginDialogComponent(smsLoginDialogVO: SmsLoginDialogVO) {
  SmsLoginDialog({ smsLoginDialogVO: smsLoginDialogVO })
}

function showAgreementDocDialog(type: number, show: number) {
  CommonDialog
    .setView<AgreementDocDialogVO>(wrapBuilder(AgreementDocDialogComponent))
    .setArgs(new AgreementDocDialogVO(type, show))
    .setOptions({
      transition: TransitionEffect.IDENTITY
    })
    .show()
}
