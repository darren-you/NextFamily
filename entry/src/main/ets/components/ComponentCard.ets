import { ListItemVO } from '../pages/arkui/main/vo/ListItemVO'

@ComponentV2
export struct ComponentCard {
  @BuilderParam listItemVO: ListItemVO

  build() {
    ListItem() {
      Row() {
        Column() {
          Text(this.listItemVO.desc).fontSize(16)
          if (this.listItemVO.guide !== '') {
            Hyperlink(this.listItemVO.guide, '\n指南') {} .color(Color.Blue)
          }
          Hyperlink(this.listItemVO.api, '\nAPI参考') {}.color(Color.Blue)
        }
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .padding(16)
      .borderRadius(16)
      .justifyContent(FlexAlign.Start)
      .alignItems(VerticalAlign.Top)
      .backgroundColor(Color.White)
    }
    .padding(16)
  }
}