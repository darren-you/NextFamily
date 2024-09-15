import { ListItemVO } from './vo/ListItemVO';
import { Logger } from '@darren/common';
import { NavConstants } from '../../../constant/NavConstants';
import { HMRouterMgr } from '@hadss/hmrouter';
import { PageConstants } from '../../../constant/PageConstants';
import { ListGroupVO } from './vo/ListGroupVO';

@Styles
function fullParent() {
  .width('100%').height('100%')
}

@Styles
function allBorder () {
  .border({ width: 0.5, color: Color.Grey, style: BorderStyle.Solid })
}

@ComponentV2
export struct ArkUIPage {
  groupVOList: Array<ListGroupVO> = this.initListData();

  @Builder
  groupItemHead(text: string) {
    Row() {
      Text(text)
        .fontSize(14)
        .fontColor(Color.Gray)
        .margin({ left: 16, top: 8, bottom: 8 })
    }
    .width('100%')
    .backgroundColor($r('app.color.main_background'))
    .justifyContent(FlexAlign.Start)
  }

  build() {
    Column() {
      List() {
        // 顶部搜索🔍
        ListItem() {
          Row() {
            TextInput({ placeholder: '搜索'})
              .fullParent()
              .placeholderColor('#9e9e9e')
              .showUnderline(false)
              .backgroundColor(Color.White)
              .onChange((value: string) => {

              })
          }
          .width('100%')
          .height(50)
          .padding(8)
        }

        // Group控件列表
        ForEach(this.groupVOList, (item: ListGroupVO) => {
          ListItemGroup({ header: this.groupItemHead(item.title) }) {
            ForEach(item.itemVOList, (listItemVO: ListItemVO, index: number) => {
              ListItem() {
                Column() {
                  Row() {
                    Row() {
                      SymbolGlyph(listItemVO.icon)
                        .fontSize(30)
                        .fontWeight(FontWeight.Bold)
                        .renderingStrategy(SymbolRenderingStrategy.MULTIPLE_COLOR)
                    }
                    .width(52)
                    .height(52)
                    .margin({ right: 8 })
                    .justifyContent(FlexAlign.Center)
                    //.globalBorder()

                    Column() {
                      Text(listItemVO.name)
                        .fontSize(16)
                        .fontWeight(FontWeight.Bold)
                        .margin({ bottom: 4 })
                      Text(listItemVO.desc)
                        .fontSize(14)
                        .fontColor(Color.Grey)
                        .maxLines(1)
                        .textOverflow( { overflow: TextOverflow.Ellipsis })
                    }
                    .layoutWeight(1)
                    .height('100%')
                    .justifyContent(FlexAlign.SpaceBetween)
                    .alignItems(HorizontalAlign.Start)
                    .padding({ top: 4, bottom: 4 })
                    //.globalBorder()
                  }
                  .width('100%')
                  .layoutWeight(1)
                  .padding({ left: 8, top: 4, right: 8, bottom: 4 })
                  //.globalBorder()

                  Row() {
                    Row() {}
                    .width(52)
                    .height(0.2)
                    .margin({ left: 8, right: 8 })
                    Row() {}
                    .width('100%')
                    .height(0.2)
                    .backgroundColor(Color.Grey)
                    .opacity(0.5)
                  }
                }
                .width('100%')
                .height(60)
                .justifyContent(FlexAlign.Start)
                .backgroundColor(Color.White)
              }
              .onClick(() => {
                HMRouterMgr.push({ pageUrl: listItemVO.page, param: listItemVO })
                Logger.debug('click item: ' + listItemVO.name)
              })
            })
          }
        })
      }
      .fullParent()
      .sticky(StickyStyle.Header)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring, { alwaysEnabled: true })
    }
    .fullParent()
    .justifyContent(FlexAlign.Start)
    .backgroundColor($r('app.color.main_background'))
    .padding({ top: NavConstants.APP_BAR_HEIGHT, bottom: NavConstants.BOTTOM_NAV_HEIGHT })
  }

  /**
   * 初始化ListGroup数据
   */
  private initListData(): Array<ListGroupVO> {
    let groupVOList = new Array<ListGroupVO>()

    // 文本与输入
    let textAndInputGroup = new Array<ListItemVO>()
    textAndInputGroup.push(new ListItemVO($r('sys.symbol.AI_translate'), "Text", "显示一段文本的组件。", PageConstants.TEXT_PAGE, 'https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/arkts-common-components-text-display-V5', 'https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-text-V5'));
    textAndInputGroup.push(new ListItemVO($r('sys.symbol.AI_flower'), "TextArea", "多行文本输入框组件，当输入的文本内容超过组件宽度时会自动换行显示。高度未设置时，组件无默认高度，自适应内容高度。宽度未设置时，默认撑满最大宽度。", PageConstants.TEXT_AREA_PAGE, '', ''));
    textAndInputGroup.push(new ListItemVO($r('sys.symbol.AI_play'), "TextInput", "单行文本输入框组件。", PageConstants.TEXT_INPUT_PAGE, '', ''));
    textAndInputGroup.push(new ListItemVO($r('sys.symbol.character_square'), "RichEditor", "支持图文混排和文本交互式编辑的组件。", PageConstants.RICH_EDITOR_PAGE, '', ''));
    textAndInputGroup.push(new ListItemVO($r('sys.symbol.AI_search'), "Search", "搜索框组件，适用于浏览器的搜索内容输入框等应用场景。", PageConstants.SEARCH_PAGE, '', ''));
    textAndInputGroup.push(new ListItemVO($r('sys.symbol.boutique_book'), "Span", "作为Text、ContainerSpan组件的子组件，用于显示行内文本的组件。", PageConstants.SPAN_PAGE, '', ''));
    textAndInputGroup.push(new ListItemVO($r('sys.symbol.bookmark_on_bookmark'), "ImageSpan", "Text、ContainerSpan组件的子组件，用于显示行内图片。", PageConstants.IMAGE_SPAN_PAGE, '', ''));
    textAndInputGroup.push(new ListItemVO($r('sys.symbol.bag'), "ContainerSpan", "Text组件的子组件，用于统一管理多个Span、ImageSpan的背景色及圆角弧度。", PageConstants.CONTAINER_SPAN_PAGE, '', ''));
    textAndInputGroup.push(new ListItemVO($r('sys.symbol.AI_keyboard'), "SymbolSpan", "作为Text组件的子组件，用于显示图标小符号的组件。", PageConstants.SYMBOL_SPAN_PAGE, '', ''));
    textAndInputGroup.push(new ListItemVO($r('sys.symbol.calendar_02'), "SymbolGlyph", "显示图标小符号的组件。", PageConstants.SYMBOL_GLYPH_PAGE, '', ''));
    textAndInputGroup.push(new ListItemVO($r('sys.symbol.application_relay'), "Hyperlink", "超链接组件，组件宽高范围内点击实现跳转。", PageConstants.HYPER_LINK_PAGE, '', ''));
    textAndInputGroup.push(new ListItemVO($r('sys.symbol.AI'), "RichText", "富文本组件，解析并显示HTML格式文本。", PageConstants.RICH_TEXT_PAGE, '', ''));
    textAndInputGroup.push(new ListItemVO($r('sys.symbol.a_3fingers_slash'), "SelectionMenu", "文本选择菜单，适用于富文本组件通过bindSelectionMenu绑定自定义文本选择菜单，建议绑定鼠标右键或者鼠标选中方式弹出，不支持作为普通组件单独使用。", PageConstants.SELECTION_MENU_PAGE, '', ''));
    textAndInputGroup.push(new ListItemVO($r('sys.symbol.AI_phone'), "属性字符串", "方便灵活应用文本样式的对象，可通过TextController中的setStyledString方法与Text组件绑定，可通过RichEditorStyledStringController中的setStyledString方法与RichEditor组件绑定。", PageConstants.TEXT_PARMA_PAGE, '', ''));
    textAndInputGroup.push(new ListItemVO($r('sys.symbol.calendar'), "文本组件公共接口", " ", PageConstants.TEXT_INTERFACE_PAGE, '', ''));


    groupVOList.push(new ListGroupVO("文本与输入", textAndInputGroup));

    return groupVOList
  }

}