import { Logger } from "@darren/common"
import { HMRouter, HMRouterMgr } from "@hadss/hmrouter"
import { PageConstants } from "../../../../constant/PageConstants"
import { ListItemVO } from "../../main/vo/ListItemVO"
import { promptAction } from "@kit.ArkUI"
import { NavConstants } from "../../../../constant/NavConstants"
import { ComponentCard } from "../../../../components/ComponentCard"
import { CustomAppBar } from "../../../../components/CustomAppBar"

@Styles
function fullParent() {
  .width('100%').height('100%')
}

@HMRouter({ pageUrl: PageConstants.COMPONENT_LIFECYCLE_PAGE })
@ComponentV2
export struct ComponentLifecyclePage {
  listItemVO?: ListItemVO

  @Local isShow: boolean = true
  @Local changeAppear: string = 'Change component appear'
  _myText: string = 'Text for onAppear'

  build() {
    Stack() {
      CustomAppBar({ title: this.listItemVO?.name, barBackgroundColor: Color.Transparent }).zIndex(1)
      List() {
        ListItem() {
          Row() {}.width('100%').height(NavConstants.APP_BAR_HEIGHT)
        }
        ListItem() {
          ComponentCard({ listItemVO: this.listItemVO })
        }
        ListItem() {
          Column() {
            Text('onAttach').margin({ top: 8, bottom: 8 })
            Text('组件挂载至组件树时触发此回调。').fontColor(Color.Grey).fontSize(14)
            Row().width('100%').height(8)

            Text('onDetach').margin({ top: 8, bottom: 8 })
            Text('组件从组件树卸载时触发此回调。').fontColor(Color.Grey).fontSize(14)
            Row().width('100%').height(8)

            Text('onAppear').margin({ top: 8, bottom: 8 })
            Text('组件挂载显示后触发此回调。').fontColor(Color.Grey).fontSize(14)
            Row().width('100%').height(8)

            Text('onDisAppear').margin({ top: 8, bottom: 8 })
            Text('组件卸载消失时触发此回调。').fontColor(Color.Grey).fontSize(14)
            Row().width('100%').height(8)
          }
          .alignItems(HorizontalAlign.Start)
          .padding({ left: 16 })
        }
        ListItem() {
          Column() {
            if (this.isShow) {
              Text(this._myText).fontSize(26).fontWeight(FontWeight.Bold)
                .onAttach(() => {
                  Logger.debug('ComponentLifecyclePage text component > onAttach')
                  promptAction.showToast({
                    message: 'The text is onAttach',
                    duration: 2000
                  })
                })
                .onDetach(() => {
                  Logger.debug('ComponentLifecyclePage text component > onDetach')
                  promptAction.showToast({
                    message: 'The text is onDetach',
                    duration: 2000
                  })
                })
                .onAppear(() => {
                  Logger.debug('ComponentLifecyclePage text component > onAppear')
                  promptAction.showToast({
                    message: 'The text is onAppear',
                    duration: 2000
                  })
                })
                .onDisAppear(() => {
                  Logger.debug('ComponentLifecyclePage text component > onDisAppear')
                  promptAction.showToast({
                    message: 'The text is onDisAppear',
                    duration: 2000
                  })
                })
            }
            Button(this.changeAppear)
              .onClick(() => {
                this.isShow = !this.isShow
              }).margin(15)
          }.padding(30).width('100%')
        }
      }
      .fullParent()
      .edgeEffect(EdgeEffect.Spring, { alwaysEnabled: true })
    }
    .alignContent(Alignment.TopStart)
    .fullParent()
    .backgroundColor($r('app.color.main_background'))
  }

  aboutToAppear(): void {
    this.listItemVO = HMRouterMgr.getCurrentParam() as ListItemVO
    Logger.debug('OnClickPage arg: ' + JSON.stringify(this.listItemVO))
  }
}