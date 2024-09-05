import { CommonDialog, NavUtil, SmsLoginDialogComponent, SmsLoginDialogVO } from '@darren/common'

@ComponentV2
export struct WidgetContent {
  build() {
    Column(){
      // SMS Login
      Button() {
        Text('验证码登录').fontColor(Color.White).fontSize(10)
      }
      .width('26%')
      .height(36)
      .backgroundColor(Color.Green)
      .padding({left: 4, top: 2, right: 4, bottom: 2})
      .margin({left: 16})
      .onClick(() => {

        showSmsLoginDialog()
      });
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundColor("$color:main_background")
    .padding({top: NavUtil.appBarHeightPX(), bottom: NavUtil.bottomRectHeightPX()})
  }
}

function showSmsLoginDialog(): void {
  CommonDialog
    .setView<SmsLoginDialogVO>(wrapBuilder(SmsLoginDialogComponent))
    .setArgs(
      new SmsLoginDialogVO()
        .setCancelCallback(() => console.log('Canceled'))
        .setRequestSmsCodeCallback((phoneNumber, requestState, smsCode) => console.log(`SMS code requested for ${phoneNumber}: ${smsCode}`))
        .setSmsLoginCallback((phoneNumber, verifyCode) => console.log(`Logged in with ${phoneNumber} and code ${verifyCode}`))
        .setThirdLoginCallback((type) => console.log(`Logged in with third-party type: ${type}`))
    )
    .setOptions({
      alignment: DialogAlignment.Center,
      autoCancel: false,
      onWillDismiss: (action: DismissDialogAction) => {
        // 返回手势 || 点击外部
        if (action.reason == DismissReason.PRESS_BACK || action.reason == DismissReason.TOUCH_OUTSIDE) {
          //action.dismiss()
        }
      },
    })
    .show()
}