import { HMRouter } from '@hadss/hmrouter'
import { CustomAppBar } from '../../../../components/CustomAppBar'
import { PageConstants } from '../../../../constant/PageConstants'
import { ListItemVO } from '../../main/vo/ListItemVO'
import { HMRouterMgr } from '@hadss/hmrouter'
import { Logger } from '@darren/common'
import { JSON } from '@kit.ArkTS'
import { NavConstants } from '../../../../constant/NavConstants'
import { ComponentCard } from '../../../../components/ComponentCard'

@Styles
function fullParent() {
  .width('100%').height('100%')
}

@HMRouter({ pageUrl: PageConstants.ON_CLICK_PAGE })
@ComponentV2
export struct OnClickPage {
  listItemVO?: ListItemVO

  @Local x: number = 0
  @Local y: number = 0
  @Local windowX: number = 0
  @Local windowY: number = 0
  @Local displayX: number = 0
  @Local displayY: number = 0

  // target 触发事件的元素对象显示区域
  @Local targetWidth: Length = 0
  @Local targetHeight: Length = 0
  @Local parentX: Length | undefined = 0
  @Local parentY: Length | undefined = 0
  @Local globalX: Length | undefined = 0
  @Local globalY: Length | undefined = 0

  @Local timestamp: string = ''

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
        // 控件详细信息
        ListItem() {
          Column() {
            Text('onClick')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
            Text('点击动作触发该回调。')
              .fontSize(14)
              .fontColor(Color.Grey)
              .margin({ top: 8, bottom: 8 })

            Stack() {
              // Click broad
              Row() {
              }
              .width('100%')
              .height(200)
              .backgroundColor(Color.Grey)
              .onClick((event?: ClickEvent) => {
                if(event){
                  this.windowX = event.windowX
                  this.windowY = event.windowY
                  this.x = event.x
                  this.y = event.y
                  this.displayX = event.displayX
                  this.displayY = event.displayY

                  this.targetWidth = event.target.area.width
                  this.targetHeight = event.target.area.height
                  this.parentX = event.target.area.position.x
                  this.parentY = event.target.area.position.y
                  this.globalX = event.target.area.globalPosition.x
                  this.globalY = event.target.area.globalPosition.y

                  this.timestamp = event.timestamp.toString()
                }
              }, 20)

              // Click point
              Row() {
              }
              .width(5)
              .height(5)
              .borderRadius(5)
              .backgroundColor(Color.Red)
              .offset({ x: this.x - 1.5, y: this.y })
              .zIndex(1)
            }
            .width('100%')
            .height(200)
            .alignContent(Alignment.TopStart)

            // click result info
            Column() {
              Text('Click point info:').fontSize(16).fontWeight(FontWeight.Bold).margin({ top: 16 })

              Text('x: ' + Math.round(this.x)).margin({ top: 8, bottom: 8 })
              Text('点击位置相对于被点击元素左边缘的X坐标。').fontColor(Color.Grey).fontSize(14)
              Row().width('100%').height(8)

              Text('y: ' + Math.round(this.y)).margin({ top: 8, bottom: 8 })
              Text('点击位置相对于被点击元素原始区域左上角的Y坐标。').fontColor(Color.Grey).fontSize(14)
              Row().width('100%').height(8)

              Text('windowX: ' + Math.round(this.windowX)).margin({ top: 8, bottom: 8 })
              Text('点击位置相对于应用窗口左上角的X坐标。').fontColor(Color.Grey).fontSize(14)
              Row().width('100%').height(8)

              Text('windowY: ' + Math.round(this.windowY)).margin({ top: 8, bottom: 8 })
              Text('点击位置相对于应用窗口左上角的Y坐标。').fontColor(Color.Grey).fontSize(14)
              Row().width('100%').height(8)

              Text('displayX: ' + Math.round(this.displayX)).margin({ top: 8, bottom: 8 })
              Text('点击位置相对于应用屏幕左上角的X坐标。').fontColor(Color.Grey).fontSize(14)
              Row().width('100%').height(8)

              Text('displayY: ' + Math.round(this.displayY)).margin({ top: 8, bottom: 8 })
              Text('点击位置相对于应用屏幕左上角的Y坐标。').fontColor(Color.Grey).fontSize(14)
              Row().width('100%').height(8)

              Text('targetWidth: ' + Math.round(parseFloat(this.targetWidth.toString())) + ' ,targetHeight:' + Math.round(parseFloat(this.targetWidth.toString()))).margin({ top: 8, bottom: 8 })
              Text('目标元素的宽、高').fontColor(Color.Grey).fontSize(14)
              Row().width('100%').height(8)

              Text('parentX: ' + Math.round(parseFloat(this.parentX?.toString())) + ' ,parentY:' + Math.round(parseFloat(this.parentY?.toString()))).margin({ top: 8, bottom: 8 })
              Text('目标元素左上角相对父元素左上角的位置').fontColor(Color.Grey).fontSize(14)
              Row().width('100%').height(8)

              Text('globalX: ' + Math.round(parseFloat(this.globalX?.toString())) + ' ,globalY:' + Math.round(parseFloat(this.globalY?.toString()))).margin({ top: 8, bottom: 8 })
              Text('目标元素左上角相对页面左上角的位置').fontColor(Color.Grey).fontSize(14)
              Row().width('100%').height(8)

              Text('timestamp: ' + this.timestamp).margin({ top: 8, bottom: 8 })
            }
            .alignItems(HorizontalAlign.Start)
          }
          .alignItems(HorizontalAlign.Start)
          .padding({ left: 16, right: 16 })
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
