import { AgreementDocDialogVO } from './AgreementDocDialogVO';
import { webview } from '@kit.ArkWeb';
import { CommonDialog } from '../CommonDialog';
import { NavUtil } from '../../utils/NavUtil';
import { Logger } from '../../utils/Logger';
import { DeviceScreenConstants } from '../../constant/DeviceScreenConstants';

@Component
export struct AgreementDocDialog {
  agreementDocDialogVO?: AgreementDocDialogVO
  @StorageProp('currentOrientation') currentOrientation: number = DeviceScreenConstants.DEVICE_SCREEN_LANDSCAPE
  @StorageProp('sdkFoldStatus') sdkFoldStatus: number = 0;
  webController: webview.WebviewController = new webview.WebviewController();
  @State type: number = 1;
  @State show: number = 1;
  @State progressVal: number = 0;
  @State isLoading: boolean = true;
  @State intervalLoading: number = -1;
  title: string = '';
  url: string = '';

  aboutToAppear() {
    this.initScreenInfo()
    this.intervalLoading = setInterval(() => {
      this.progressVal = this.progressVal >= 100 ?
        0 : (this.progressVal + 10);
    }, 100);

    Logger.debug("router.getParams()['show']:" + this.show + " router.getParams()['type']:" + this.type)
  }

  initScreenInfo() {
    let nowOrientation: number | null | undefined = AppStorage.get(DeviceScreenConstants.CURRENT_ORIENTATION)
    let nowFoldStatus: number | null | undefined = AppStorage.get('sdkFoldStatus')

    console.log('nowOrientation: ' + nowOrientation + ' nowFoldStatus: ' + nowFoldStatus)

    if (nowOrientation != null && nowOrientation != undefined) this.currentOrientation = nowOrientation
    if (nowFoldStatus != null && nowFoldStatus != undefined) this.sdkFoldStatus = nowFoldStatus

    Logger.debug('SafeArea 初始屏幕状态信息 orientation: ' + this.currentOrientation + ' fold: ' + this.sdkFoldStatus)
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Column() {
        // Title
        Column() {
          Stack() {
            Row() {
              Text(this.title)
                .fontSize(20)
                .fontColor(Color.Black)
            }.justifyContent(FlexAlign.Center).width('100%').height('100%')

            Row() {
              SymbolGlyph($r('sys.symbol.arrow_left'))
                .fontSize(24)
                .fontColor([Color.Black])
                .renderingStrategy(SymbolRenderingStrategy.SINGLE)
                .onClick(() => {
                  CommonDialog.getInstance().closeDialog(this.agreementDocDialogVO?.dialogId)
                })
            }.justifyContent(FlexAlign.Start).width('100%').height('100%').position({ left: 16})
          }
        }.width('100%').height(46)

        Web({ src: this.url, controller: this.webController })
          .zoomAccess(false)
          .layoutWeight(1)
          .margin({ left: 10, right: 10 })
          .onProgressChange((event) => {
            if (event != undefined && event.newProgress === 100) {
              this.isLoading = false;
              clearInterval(this.intervalLoading);
              this.intervalLoading = -1;
            }
          })
      }
    }
    .padding({top: this.top()})
    .height('100%')
    .width('100%')
    .backgroundColor(Color.White)
  }

  /**
   * 获取顶部避让区域高度
   * @returns {number}
   */
  top(): number | string {
    let defaultTop: number | string = NavUtil.appBarHeightPX()
    switch (this.sdkFoldStatus) {
      // Unknown | 直屏
      case 0:
      // 折叠屏 [展开、半折] 态
      case 1:
      case 3:
      // 折叠屏 折叠态
      case 2:
        if (this.currentOrientation === DeviceScreenConstants.DEVICE_SCREEN_PORTRAIT && NavUtil.FULL_SCREEN) {
          defaultTop = NavUtil.appBarHeightPX()
        }
        if (this.currentOrientation === DeviceScreenConstants.DEVICE_SCREEN_LANDSCAPE && NavUtil.FULL_SCREEN) {
          defaultTop = 0
        }
        Logger.debug('顶部避让区域: ' + defaultTop)
        break
      default:
        defaultTop = NavUtil.appBarHeightPX()
        Logger.debug('未知态默认 顶部避让区域: ' + defaultTop)
    }
    return defaultTop
  }
}

@Builder
export function AgreementDocDialogComponent(agreementDocDialogVO: AgreementDocDialogVO) {
  AgreementDocDialog({agreementDocDialogVO: agreementDocDialogVO})
}



