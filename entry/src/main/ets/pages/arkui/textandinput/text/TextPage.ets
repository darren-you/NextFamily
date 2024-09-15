import { HMRouter } from '@hadss/hmrouter'
import { CustomAppBar } from '../../../../components/CustomAppBar'
import { PageConstants } from '../../../../constant/PageConstants'
import { ListItemVO } from '../../content/vo/ListItemVO'
import { HMRouterMgr } from '@hadss/hmrouter'
import { Logger } from '@darren/common'
import { JSON } from '@kit.ArkTS'
import { NavConstants } from '../../../../constant/NavConstants'
import { ComponentCard } from '../../../../components/ComponentCard'

@Styles
function fullParent() {
  .width('100%').height('100%')
}

@Styles
function allBorder () {
  .border({ width: 0.5, color: Color.Grey, style: BorderStyle.Solid })
}

@HMRouter({ pageUrl: PageConstants.TEXT_PAGE })
@ComponentV2
export struct TextPage {
  listItemVO?: ListItemVO

  build() {
    Stack() {
      CustomAppBar({ title: this.listItemVO?.name, barBackgroundColor: Color.Transparent })
      Column() {
        Row() {}.width('100%').height(NavConstants.APP_BAR_HEIGHT)
        List() {
          ComponentCard({ listItemVO: this.listItemVO })
          ListItem() {
            Column() {
              Text('textAlign')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
              Text('设置文本段落在水平方向的对齐方式。')
                .fontSize(14)
                .fontColor(Color.Grey)
                .margin({ top: 8, bottom: 8 })
            }
            .alignItems(HorizontalAlign.Start)
            .padding({ left: 8, right: 8 })
          }
          .padding({ left: 16, right: 16 })
        }
        .fullParent()
        .edgeEffect(EdgeEffect.Spring, { alwaysEnabled: true })
      }
    }
    .fullParent()
    .backgroundColor($r('app.color.main_background'))
  }

  aboutToAppear(): void {
    this.listItemVO = HMRouterMgr.getCurrentParam() as ListItemVO
    Logger.debug('TextPage arg: ' + JSON.stringify(this.listItemVO))
  }
}
