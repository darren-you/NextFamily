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
  @Local isEditing: boolean = false;
  @Local selectItem: number = -1;
  @Local itemExpanded: boolean = false;
  groupVOList: Array<ListGroupVO> = this.initListData();

  @Builder
  groupItemHead(text: string, index: number) {
    Row() {
      Image($r('app.media.expanded'))
        .width(12)
        .height(12)
        .margin({ left: 10 })
        .rotate({
          x: 0,
          y: 0,
          z: 1,
          centerX: '50%',
          centerY: '50%',
          angle: this.selectItem == index ? 90 : 0
        })
      Text(text)
        .fontSize(14)
        .fontColor($r('app.color.text_primary'))
        .margin({ left: 8, top: 8, bottom: 8 })
    }
    .width('100%')
    .backgroundColor($r('app.color.white'))
    .justifyContent(FlexAlign.Start)
    .onClick(() => {
      animateTo({
        duration: 200,
        onFinish: () => {
          console.info('animation end');
        }
      }, () => {
        if (this.selectItem == index && this.itemExpanded) {
          this.selectItem = -1
          this.itemExpanded = false
        } else {
          this.selectItem = index;
          this.itemExpanded = true
        }
      })
    })
  }

  build() {
    Column() {
      List() {
        // 顶部导航栏占位
        ListItem() {}
        .width('100%')
        .height(NavConstants.APP_BAR_HEIGHT)

        // 顶部搜索🔍
        ListItem() {
          Row() {
            TextInput({ placeholder: this.isEditing ? null : '搜索' })
              .fullParent()
              .placeholderColor('#9e9e9e')
              .showUnderline(false)
              .textAlign(this.isEditing ? TextAlign.Start : TextAlign.Center)
              .borderRadius(4)
              .backgroundColor($r('app.color.main_background'))
              .onChange((value: string) => {
                Logger.debug('onChange > > > value: ' + value)
              })
              .onEditChange((isEditing: boolean) => {
                this.isEditing = isEditing
                Logger.debug('isEditing > > > isEditing: ' + isEditing)
              })
          }
          .width('100%')
          .height(50)
          .padding(8)
          .backgroundColor($r('app.color.white'))
        }

        // Group控件列表
        ForEach(this.groupVOList, (item: ListGroupVO, index: number) => {
          ListItemGroup({ header: this.groupItemHead(item.title, index) }) {
            if (this.selectItem == index) {
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

                    // 分割线
                    // Row() {
                    //   Row() {}
                    //   .width(52)
                    //   .height(0.2)
                    //   .margin({ left: 8, right: 8 })
                    //   Row() {}
                    //   .width('100%')
                    //   .height(0.2)
                    //   .backgroundColor(Color.Grey)
                    //   .opacity(0.5)
                    // }
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
          }
        })

        // 底部导航栏占位
        ListItem() {}
        .width('100%')
        .height(NavConstants.BOTTOM_NAV_HEIGHT)
      }
      .fullParent()
      .sticky(StickyStyle.Header)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring, { alwaysEnabled: true })
    }
    .width('100%')
    .justifyContent(FlexAlign.Start)
    .backgroundColor($r('app.color.main_background'))
  }

  /**
   * 初始化ListGroup数据
   */
  private initListData(): Array<ListGroupVO> {
    let groupVOList: Array<ListGroupVO> = new Array<ListGroupVO>()

    // 组件通用信息
    let commonGroup: Array<ListItemVO> = new Array<ListItemVO>()
    commonGroup.push(new ListItemVO($r('sys.symbol.AI_spell_suggest'), "点击事件", "组件被点击时触发的事件。", PageConstants.ON_CLICK_PAGE, 'https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/arkts-common-events-V5', 'https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-universal-events-click-V5'));
    commonGroup.push(new ListItemVO($r('sys.symbol.card_badge_shield'), "触摸事件", "当手指在组件上按下、滑动、抬起时触发。", PageConstants.ON_TOUCH_PAGE, 'https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/arkts-common-events-touch-screen-event-V5', 'https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-universal-events-touch-V5#ontouch'));
    commonGroup.push(new ListItemVO($r('sys.symbol.calendar_17'), "挂载卸载事件", "挂载卸载事件指组件从组件树上挂载、卸载时触发的事件。", PageConstants.COMPONENT_LIFECYCLE_PAGE, '', 'https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-universal-events-show-hide-V5'));
    commonGroup.push(new ListItemVO($r('sys.symbol.arrow_down_right_and_arrow_up_left'), "拖拽事件", "拖拽事件指组件被长按后拖拽时触发的事件。", PageConstants.DRAGGABLE_PAGE, 'https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/arkts-common-events-drag-event-V5', 'https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-universal-events-drag-drop-V5'));
    commonGroup.push(new ListItemVO($r('sys.symbol.align_bottom'), "按键事件", "组件被点击时触发的事件。", PageConstants.ON_CLICK_PAGE, '', ''));
    commonGroup.push(new ListItemVO($r('sys.symbol.bookmark'), "焦点事件", "组件被点击时触发的事件。", PageConstants.ON_CLICK_PAGE, '', ''));
    commonGroup.push(new ListItemVO($r('sys.symbol.calendar'), "鼠标事件", "组件被点击时触发的事件。", PageConstants.ON_CLICK_PAGE, '', ''));
    commonGroup.push(new ListItemVO($r('sys.symbol.AI_spell_suggest'), "悬浮事件", "组件被点击时触发的事件。", PageConstants.ON_CLICK_PAGE, '', ''));
    commonGroup.push(new ListItemVO($r('sys.symbol.AI_spell_suggest'), "无障碍悬浮事件", "组件被点击时触发的事件。", PageConstants.ON_CLICK_PAGE, '', ''));
    commonGroup.push(new ListItemVO($r('sys.symbol.AI_spell_suggest'), "组件区域变化事件", "组件被点击时触发的事件。", PageConstants.ON_CLICK_PAGE, '', ''));
    commonGroup.push(new ListItemVO($r('sys.symbol.AI_spell_suggest'), "组件尺寸变化事件", "组件被点击时触发的事件。", PageConstants.ON_CLICK_PAGE, '', ''));
    commonGroup.push(new ListItemVO($r('sys.symbol.AI_spell_suggest'), "组件可见区域变化事件", "组件被点击时触发的事件。", PageConstants.ON_CLICK_PAGE, '', ''));
    commonGroup.push(new ListItemVO($r('sys.symbol.AI_spell_suggest'), "组件快捷键事件", "组件被点击时触发的事件。", PageConstants.ON_CLICK_PAGE, '', ''));
    commonGroup.push(new ListItemVO($r('sys.symbol.AI_spell_suggest'), "自定义事件分发", "组件被点击时触发的事件。", PageConstants.ON_CLICK_PAGE, '', ''));
    commonGroup.push(new ListItemVO($r('sys.symbol.AI_spell_suggest'), "自定义事件拦截", "组件被点击时触发的事件。", PageConstants.ON_CLICK_PAGE, '', ''));

    // 文本与输入
    let textAndInputGroup: Array<ListItemVO> = new Array<ListItemVO>()
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

    groupVOList.push(new ListGroupVO("组件通用信息", commonGroup));
    groupVOList.push(new ListGroupVO("行列与堆叠", textAndInputGroup));
    groupVOList.push(new ListGroupVO("栅格与分栏", textAndInputGroup));
    groupVOList.push(new ListGroupVO("滚动与滑动", textAndInputGroup));
    groupVOList.push(new ListGroupVO("导航与切换", textAndInputGroup));
    groupVOList.push(new ListGroupVO("按钮与选择", textAndInputGroup));
    groupVOList.push(new ListGroupVO("文本与输入", textAndInputGroup));
    groupVOList.push(new ListGroupVO("图片与视频", textAndInputGroup));
    groupVOList.push(new ListGroupVO("信息展示", textAndInputGroup));
    groupVOList.push(new ListGroupVO("空白与分隔", textAndInputGroup));
    groupVOList.push(new ListGroupVO("画布绘制", textAndInputGroup));
    groupVOList.push(new ListGroupVO("图形绘制", textAndInputGroup));
    groupVOList.push(new ListGroupVO("渲染绘制", textAndInputGroup));
    groupVOList.push(new ListGroupVO("标题栏与工具栏", textAndInputGroup));
    groupVOList.push(new ListGroupVO("菜单", textAndInputGroup));
    groupVOList.push(new ListGroupVO("动画", textAndInputGroup));
    groupVOList.push(new ListGroupVO("弹窗", textAndInputGroup));
    groupVOList.push(new ListGroupVO("卡片", textAndInputGroup));
    groupVOList.push(new ListGroupVO("安全", textAndInputGroup));
    groupVOList.push(new ListGroupVO("主题", textAndInputGroup));
    groupVOList.push(new ListGroupVO("原子化服务", textAndInputGroup));
    groupVOList.push(new ListGroupVO("自定义占位组件", textAndInputGroup));
    groupVOList.push(new ListGroupVO("自定义组件", textAndInputGroup));
    groupVOList.push(new ListGroupVO("状态管理与渲染控制", textAndInputGroup));
    groupVOList.push(new ListGroupVO("公共定义", textAndInputGroup));

    return groupVOList
  }

}