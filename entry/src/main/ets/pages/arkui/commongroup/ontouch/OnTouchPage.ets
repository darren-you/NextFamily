import { Logger } from "@darren/common";
import { HMRouter, HMRouterMgr } from "@hadss/hmrouter";
import { ComponentCard } from "../../../../components/ComponentCard";
import { CustomAppBar } from "../../../../components/CustomAppBar";
import { NavConstants } from "../../../../constant/NavConstants";
import { PageConstants } from "../../../../constant/PageConstants";
import { ListItemVO } from "../../main/vo/ListItemVO";

@Styles
function fullParent() {
  .width('100%').height('100%')
}

@HMRouter({ pageUrl: PageConstants.ON_TOUCH_PAGE })
@ComponentV2
export struct OnTouchPage {
  listItemVO?: ListItemVO

  @Local eventType: string = ''
  @Local x: number = 0
  @Local y: number = 0
  @Local windowX: number = 0
  @Local windowY: number = 0
  @Local displayX: number = 0
  @Local displayY: number = 0
  @Local targetWidth: number = 0
  @Local targetHeight: number = 0

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
            Text('onTouch')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
            Text('当手指在组件上按下、滑动、抬起时触发。')
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
              .onTouch((event?: TouchEvent) => {
                if (event) {
                  if (event.type === TouchType.Down) {
                    this.eventType = 'Down'
                  }
                  if (event.type === TouchType.Up) {
                    this.eventType = 'Up'
                  }
                  if (event.type === TouchType.Move) {
                    this.eventType = 'Move'
                  }

                  this.x = event.touches[0].x
                  this.y = event.touches[0].y
                  this.windowX = event.touches[0].windowX
                  this.windowY = event.touches[0].windowY
                  this.displayX = event.touches[0].displayX
                  this.displayY = event.touches[0].displayY
                  this.targetWidth = Math.round(Number.parseFloat(event.target.area.width.toString()))
                  this.targetHeight = Math.round(Number.parseFloat(event.target.area.height.toString()))

                  this.timestamp = event.timestamp.toString()
                }
              })

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
              Text('Touch point info:').fontSize(16).fontWeight(FontWeight.Bold).margin({ top: 16 })

              Text('type: ' + this.eventType).margin({ top: 8, bottom: 8 })
              Text('触摸事件的类型。').fontColor(Color.Grey).fontSize(14)
              Row().width('100%').height(8)

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
    Logger.debug('OnTouchPage arg: ' + JSON.stringify(this.listItemVO))
  }
}