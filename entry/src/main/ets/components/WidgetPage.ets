import { ListItemVO } from './list/ListItemVO';
import { Logger, NavUtil } from '@darren/common';

let appBarHeight: number = 90;
let bottomNavHeight: number = 80;

@Styles
function globalBorder () {
  .border({ width: 0.5, color: Color.Grey, style: BorderStyle.Solid })
}

@ComponentV2
export struct WidgetPage {
  listData: Array<ListItemVO> = this.initListData();

  build() {
    Column() {
      List() {
        ForEach(this.listData, (listItemVO: ListItemVO) => {
          ListItem() {
            Row() {
              Image($rawfile('img/we_chat.png'))
                .width(52)
                .height(52)
                .margin({ right: 8 })
                .globalBorder()

              Column() {
                Text(listItemVO.name)
                  .fontSize(18)
                  .fontWeight(FontWeight.Bold)
                  .margin({ top: 4, bottom: 4 })
                Text(listItemVO.desc)
                  .fontSize(14)
                  .fontColor(Color.Grey)
                  .maxLines(1)
                  .textOverflow( { overflow: TextOverflow.Ellipsis })
                  .margin({ bottom: 4})
              }
              .layoutWeight(1)
              .height('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(HorizontalAlign.Start)
              .globalBorder()
            }
            .height(60)
            .justifyContent(FlexAlign.Start)
            .padding({ left: 8, top: 4, right: 8, bottom: 4 })
            .globalBorder()
            .backgroundColor(Color.White)
          }
          .onClick(() => {
            Logger.debug('click item: ' + listItemVO.name)
          })
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.Grey)
      .edgeEffect(EdgeEffect.Spring, { alwaysEnabled: true })

    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Start)
    .backgroundColor("$color:main_background")
    .padding({top: appBarHeight, bottom: bottomNavHeight})
  }

  /**
   * 初始化List数据
   */
  protected initListData(): Array<ListItemVO> {
    let listData = new Array<ListItemVO>()

    for (let i = 0; i < 10; i++) {
      listData.push(new ListItemVO($r('sys.symbol.ohos_circle'), "List", "列表是一种复杂的容器，当列表项达到一定数量，内容超过屏幕大小时，可以自动提供滚动功能。它适合用于呈现同类数据类型或数据类型集，例如图片和文本。在列表中显示数据集合是许多应用程序中的常见要求（如通讯录、音乐列表、购物清单等）。"));
      listData.push(new ListItemVO($r('sys.symbol.car_side_rear_open_1'), "Row", "Row是一种垂直方向的线性布局，可以添加多个子组件，子组件会垂直排列。"));
      listData.push(new ListItemVO($r('sys.symbol.camera_s'), "Column", "Column是一种水平方向的线性布局，可以添加多个子组件，子组件会水平排列。"));
    }

    return listData
  }

}