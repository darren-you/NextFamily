import { ListItemVO } from '../vo/ListItemVO';

@ComponentV2
export struct ListItemWidget {
  listItemVO?: ListItemVO

  build() {
    ListItem() {
      Row() {
        Image(this.listItemVO?.icon)
          .width(40)
          .height(40)
          .margin(5)
        Column() {
          Text(this.listItemVO?.name)
            .fontSize(16)
          Text(this.listItemVO?.desc)
            .fontSize(14)
            .fontColor(Color.Gray)
        }
      }
      .width('100%')
      .height(50)
      .justifyContent(FlexAlign.Start)
      .backgroundColor(Color.White)
    }
    .width('100%')
  }
}