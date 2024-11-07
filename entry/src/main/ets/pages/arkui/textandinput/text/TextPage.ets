import { HMRouter } from '@hadss/hmrouter'
import { CustomAppBar } from '../../../../components/CustomAppBar'
import { PageConstants } from '../../../../constant/PageConstants'
import { HMRouterMgr } from '@hadss/hmrouter'
import { Logger } from '@darren/common'
import { JSON } from '@kit.ArkTS'
import { NavConstants } from '../../../../constant/NavConstants'
import { ComponentCard } from '../../../../components/ComponentCard'
import { ListItemVO } from '../../main/vo/ListItemVO'

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

  @Builder
  private titleRow(title: string, desc: string) {
    Column() {
      Text(title)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 16 })
      Text(desc)
        .fontSize(14)
        .fontColor(Color.Grey)
        .margin({ top: 8, bottom: 16 })
    }
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  private bindSelectionMenu() {
    Column() {
      List() {
        ListItem() {
          Row(){
            Text('选项一')
              .margin({ left: 16 })
          }
          .fullParent()
          .backgroundColor(Color.White)

        }
        .width('100%')
        .height(50)

        ListItem() {
          Row(){
            Text('选项二')
              .margin({ left: 16 })
          }
          .fullParent()
          .backgroundColor(Color.White)

        }
        .width('100%')
        .height(50)

        ListItem() {
          Row(){
            Text('选项三')
              .margin({ left: 16 })
          }
          .fullParent()
          .backgroundColor(Color.White)
        }
        .width('100%')
        .height(50)

      }
      .width(200)
      .height(100)
      .backgroundColor(Color.White)
      .borderRadius(16)
    }
    .width(200)
    .backgroundColor(Color.White)
    .borderRadius(16)
    .alignItems(HorizontalAlign.Start)

  }

  build() {
    Stack() {
      CustomAppBar({ title: this.listItemVO?.name, barBackgroundColor: Color.Transparent })
      Column() {
        Row() {}.width('100%').height(NavConstants.APP_BAR_HEIGHT)
        List() {
          ComponentCard({ listItemVO: this.listItemVO })
          ListItem() {
            Column() {
              // TextAlign
              this.titleRow('textAlign', '设置文本段落在水平方向的对齐方式。')
              Column() {
                Text("TextAlign.Start") {
                }
                .width('100%')
                .height(50)
                .textAlign(TextAlign.Start)
                .allBorder()
                .margin({ bottom: 4 })

                Text("TextAlign.Center") {
                }
                .width('100%')
                .height(50)
                .textAlign(TextAlign.Center)
                .allBorder()
                .margin({ bottom: 4 })

                Text("TextAlign.End") {
                }
                .width('100%')
                .height(50)
                .textAlign(TextAlign.End)
                .allBorder()
                .margin({ bottom: 4 })

                Text("TextAlign.JUSTIFY") {
                }
                .width('100%')
                .height(50)
                .textAlign(TextAlign.JUSTIFY)
                .allBorder()
                .margin({ bottom: 4 })
              }
              .width('100%')

              // textOverflow
              this.titleRow('textOverflow', '设置文本超长时的显示方式。')
              Text("当前TextOverflow.Clip，设置文本超长时的显示方式。默认值：{overflow: TextOverflow.Clip}") {
              }
              .width('100%')
              .height(50)
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Clip })
              .allBorder()
              .margin({ bottom: 4 })
              Text("当前TextOverflow.Ellipsis，设置文本超长时的显示方式。默认值：{overflow: TextOverflow.Clip}") {
              }
              .width('100%')
              .height(50)
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .allBorder()
              .margin({ bottom: 4 })
              Text("当前TextOverflow.MARQUEE，设置文本超长时的显示方式。默认值：{overflow: TextOverflow.Clip}") {
              }
              .width('100%')
              .height(50)
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.MARQUEE })
              .allBorder()
              .margin({ bottom: 4 })

              // maxLines
              this.titleRow('maxLines', '设置文本的最大行数。')
              Text('当前maxLines = 2，设置文本的最大行数。默认情况下，文本是自动折行的，如果指定此属性，则文本最多不会超过指定的行。如果有多余的文本，可以通过textOverflow来指定截断方式。') {
              }
              .width('100%')
              .maxLines(2)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .allBorder()
              .margin({ bottom: 4 })

              // lineHeight
              this.titleRow('lineHeight', '设置文本的最大行数。')
              Text('当前lineHeight = 50，设置文本的文本行高，设置值不大于0时，不限制文本行高，自适应字体大小，number类型时单位为fp。') {
              }
              .width('100%')
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .lineHeight(50)
              .allBorder()
              .margin({ bottom: 4 })

              // decoration
              this.titleRow('decoration', '设置文本装饰线样式及其颜色。')
              Text('设置文本装饰线样式及其颜色。Underline') {
              }
              .width('100%')
              .decoration({ type: TextDecorationType.Underline, color: Color.Blue, style: TextDecorationStyle.SOLID})
              .allBorder()
              .margin({ bottom: 4 })
              Text('设置文本装饰线样式及其颜色。Overline') {
              }
              .width('100%')
              .decoration({ type: TextDecorationType.Overline, color: Color.Orange, style: TextDecorationStyle.DOUBLE})
              .allBorder()
              .margin({ bottom: 4 })
              Text('设置文本装饰线样式及其颜色。LineThrough') {
              }
              .width('100%')
              .decoration({ type: TextDecorationType.LineThrough, color: Color.Red, style: TextDecorationStyle.DOTTED})
              .allBorder()
              .margin({ bottom: 4 })

              // baselineOffset
              this.titleRow('baselineOffset', '设置文本基线的偏移量，设置该值为百分比时，按默认值显示。')
              Text('当前baselineOffset = 100，设置文本基线的偏移量，设置该值为百分比时，按默认值显示。') {
              }
              .width('100%')
              .baselineOffset(100)
              .allBorder()
              .margin({ bottom: 4 })

              // letterSpacing
              this.titleRow('letterSpacing', '设置文本字符间距。')
              Text('当前letterSpacing = 5，设置文本字符间距。设置该值为百分比时，按默认值显示。设置该值为0时，按默认值显示。\n' +
                '当取值为负值时，文字会发生压缩，负值过小时会将组件内容区大小压缩为0，导致无内容显示。') {
              }
              .width('100%')
              .letterSpacing(5)
              .allBorder()
              .margin({ bottom: 4 })

              // minFontSize
              this.titleRow('minFontSize', '设置文本最小显示字号。')
              Text('当前minFontSize = 20，设置文本最小显示字号。需配合maxFontSize以及maxlines或布局大小限制使用，单独设置不生效，对子组件和属性字符串不生效。') {
              }
              .width('100%')
              .minFontSize(20)
              .maxFontSize(40)
              .maxLines(3)
              .allBorder()
              .margin({ bottom: 4 })

              // maxFontSize
              this.titleRow('maxFontSize', '设置文本最大显示字号。')
              Text('maxFontSize = 3，需配合minFontSize以及maxlines或布局大小限制使用，单独设置不生效，对子组件和属性字符串不生效。') {
              }
              .width('100%')
              .maxFontSize(3)
              .maxLines(2)
              .allBorder()
              .margin({ bottom: 4 })

              // textCase
              this.titleRow('textCase', '设置文本大小写。')
              Text('当前textCase = TextCase.LowerCase，设置文本大小写。') {
              }
              .width('100%')
              .textCase(TextCase.LowerCase)
              .allBorder()
              .margin({ bottom: 4 })
              Text('当前textCase = TextCase.UpperCase，设置文本大小写。') {
              }
              .width('100%')
              .textCase(TextCase.UpperCase)
              .allBorder()

              // fontColor
              this.titleRow('fontColor', '设置字体颜色。')
              Text('当前fontColor = Color.Red，设置字体颜色。') {
              }
              .width('100%')
              .fontColor(Color.Red)
              .allBorder()
              .margin({ bottom: 4 })
              Text('当前fontColor = Color.Blue，设置字体颜色。') {
              }
              .width('100%')
              .fontColor(Color.Blue)
              .allBorder()
              .margin({ bottom: 4 })

              // fontSize
              this.titleRow('fontSize', '设置字体大小。')
              Text('当前fontSize = 30，设置字体大小。') {
              }
              .width('100%')
              .fontSize(30)
              .allBorder()
              .margin({ bottom: 4 })
              Text('当前fontSize = 20，设置字体大小。') {
              }
              .width('100%')
              .fontSize(20)
              .allBorder()
              .margin({ bottom: 4 })

              // fontStyle
              this.titleRow('fontStyle', '设置字体样式。')
              Text('当前fontStyle = FontStyle.Italic，设置字体样式。') {
              }
              .width('100%')
              .fontStyle(FontStyle.Italic)
              .allBorder()
              .margin({ bottom: 4 })
              Text('当前fontStyle = FontStyle.Normal，设置字体样式。') {
              }
              .width('100%')
              .fontStyle(FontStyle.Normal)
              .allBorder()
              .margin({ bottom: 4 })

              // fontWeight
              this.titleRow('fontWeight', '设置文本的字体粗细，设置过大可能会在不同字体下有截断。')
              Text('当前fontWeight = FontWeight.Lighter，设置文本的字体粗细，设置过大可能会在不同字体下有截断。') {
              }
              .width('100%')
              .fontWeight(FontWeight.Lighter)
              .allBorder()
              .margin({ bottom: 4 })
              Text('当前fontWeight = FontWeight.Normal，设置文本的字体粗细，设置过大可能会在不同字体下有截断。') {
              }
              .width('100%')
              .fontWeight(FontWeight.Normal)
              .allBorder()
              .margin({ bottom: 4 })
              Text('当前fontWeight = FontWeight.Regular，设置文本的字体粗细，设置过大可能会在不同字体下有截断。') {
              }
              .width('100%')
              .fontWeight(FontWeight.Regular)
              .allBorder()
              .margin({ bottom: 4 })
              Text('当前fontWeight = FontWeight.Medium，设置文本的字体粗细，设置过大可能会在不同字体下有截断。') {
              }
              .width('100%')
              .fontWeight(FontWeight.Medium)
              .allBorder()
              .margin({ bottom: 4 })
              Text('当前fontWeight = FontWeight.Bold，设置文本的字体粗细，设置过大可能会在不同字体下有截断。') {
              }
              .width('100%')
              .fontWeight(FontWeight.Bold)
              .allBorder()
              .margin({ bottom: 4 })
              Text('当前fontWeight = FontWeight.Bolder，设置文本的字体粗细，设置过大可能会在不同字体下有截断。') {
              }
              .width('100%')
              .fontWeight(FontWeight.Bolder)
              .allBorder()
              .margin({ bottom: 4 })
              Text('当前fontWeight = 100，文本的字体粗细，number类型取值[100, 900]，取值间隔为100，默认为400，取值越大，字体越粗。') {
              }
              .width('100%')
              .fontWeight(100)
              .allBorder()
              .margin({ bottom: 4 })

              // fontFamily
              this.titleRow('fontFamily', '设置字体列表。')
              Text('当前fontFamily = "HarmonyOS Sans"，字体列表。默认字体\'HarmonyOsSans\'。应用当前支持 HarmonyosSans\'字体和注册自定义字体。卡片当前仅支持\'HarmonyOSSans\'字体。') {
              }
              .width('100%')
              .fontFamily('HarmonyOS Sans')
              .allBorder()
              .margin({ bottom: 4 })

              // copyOption
              this.titleRow('copyOption', '设置组件是否支持文本可复制粘贴。')
              Text('当前copyOption = CopyOptions.None，设置组件是否支持文本可复制粘贴。设置copyOptions为CopyOptions.InApp或者CopyOptions.LocalDevice，长按文本，会弹出文本选择菜单，可选中文本并进行复制、全选操作。') {
              }
              .width('100%')
              .copyOption(CopyOptions.None)
              .allBorder()
              .margin({ bottom: 4 })
              Text('当前copyOption = CopyOptions.InApp，设置组件是否支持文本可复制粘贴。设置copyOptions为CopyOptions.InApp或者CopyOptions.LocalDevice，长按文本，会弹出文本选择菜单，可选中文本并进行复制、全选操作。') {
              }
              .width('100%')
              .copyOption(CopyOptions.InApp)
              .allBorder()
              .margin({ bottom: 4 })
              Text('当前copyOption = CopyOptions.LocalDevice，设置组件是否支持文本可复制粘贴。设置copyOptions为CopyOptions.InApp或者CopyOptions.LocalDevice，长按文本，会弹出文本选择菜单，可选中文本并进行复制、全选操作。') {
              }
              .width('100%')
              .copyOption(CopyOptions.LocalDevice)
              .allBorder()
              .margin({ bottom: 4 })

              // draggable
              this.titleRow('draggable', '设置选中文本拖拽效果。')
              Text('当前draggable = true，不能和onDragStart事件同时使用。需配合CopyOptions一起使用，设置copyOptions为CopyOptions.InApp或者CopyOptions.LocalDevice，并且draggable设置为true时，支持对选中文本的拖拽以及选中内容复制到输入框。') {
              }
              .width('100%')
              .copyOption(CopyOptions.InApp)
              .draggable(true)
              .allBorder()
              .margin({ bottom: 4 })

              // font
              this.titleRow('font', '设置文本样式。包括字体大小、字体粗细、字体族和字体风格。')
              Text('当前font({size: 10, weight: FontWeight.Bold})，设置文本样式。包括字体大小、字体粗细、字体族和字体风格。') {
              }
              .width('100%')
              .font({size: 10, weight: FontWeight.Bold})
              .allBorder()
              .margin({ bottom: 4 })

              // textShadow
              this.titleRow('textShadow', '设置文字阴影效果。')
              Text('当前textShadow({radius: 2, type: ShadowType.COLOR, color: Color.Blue, offsetX: 2, offsetY: 2, fill: true}) 设置文字阴影效果。\n' +
                '不支持fill字段,不支持智能取色模式。\n' +
                '从API version 11开始，该接口支持以数组形式入参，实现多重文字阴影。') {
              }
              .width('100%')
              .textShadow({radius: 2, type: ShadowType.COLOR, color: Color.Blue, offsetX: 2, offsetY: 2, fill: true})
              .allBorder()
              .margin({ bottom: 4 })
              Text('当前textShadow({radius: 2, type: ShadowType.COLOR, color: Color.Blue, offsetX: 2, offsetY: 2, fill: false}) 设置文字阴影效果。\n' +
                '不支持fill字段,不支持智能取色模式。\n' +
                '从API version 11开始，该接口支持以数组形式入参，实现多重文字阴影。') {
              }
              .width('100%')
              .textShadow({radius: 2, type: ShadowType.COLOR, color: Color.Blue, offsetX: 2, offsetY: 2, fill: false})
              .allBorder()
              .margin({ bottom: 4 })

              // heightAdaptivePolicy
              this.titleRow('heightAdaptivePolicy', '设置文本自适应高度的方式。')
              Text('heightAdaptivePolicy = TextHeightAdaptivePolicy.MAX_LINES_FIRST, 当设置为TextHeightAdaptivePolicy.MAX_LINES_FIRST时，优先使用maxlines属性来调整文本高度。如果使用maxLines属性的布局大小超过了布局约束，则尝试在minFontSize和maxFontSize的范围内缩小字体以显示更多文本。') {
              }
              .width('100%')
              .heightAdaptivePolicy(TextHeightAdaptivePolicy.MAX_LINES_FIRST)
              .allBorder()
              .margin({bottom: 4 })

              // textIndent
              this.titleRow('textIndent', '设置首行文本缩进。')
              Text('当前textIndent = 16，设置首行文本缩进，从API version 11开始，该接口支持在元服务中使用。') {
              }
              .width('100%')
              .textIndent(16)
              .allBorder()
              .margin({ bottom: 4 })

              // wordBreak
              this.titleRow('wordBreak', '设置断行规则。')
              Text('当前wordBreak = WordBreak.NORMAL，设置断行规则。WordBreak.BREAK_ALL与{overflow: TextOverflow.Ellipsis}，maxLines组合使用可实现英文单词按字母截断，超出部分以省略号显示。Launch cn.darrenyou.nextfamily success in 3 s 812 ms') {
              }
              .width('100%')
              .maxLines(2)
              .fontSize(10)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .wordBreak(WordBreak.NORMAL)
              .allBorder()
              .margin({ bottom: 4 })
              Text('当前wordBreak = WordBreak.BREAK_ALL，设置断行规则。WordBreak.BREAK_ALL与{overflow: TextOverflow.Ellipsis}，maxLines组合使用可实现英文单词按字母截断，超出部分以省略号显示。Launch cn.darrenyou.nextfamily success in 3 s 812 ms') {
              }
              .width('100%')
              .maxLines(2)
              .fontSize(10)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .wordBreak(WordBreak.BREAK_ALL)
              .allBorder()
              .margin({ bottom: 4 })
              Text('当前wordBreak = WordBreak.BREAK_WORD，设置断行规则。WordBreak.BREAK_ALL与{overflow: TextOverflow.Ellipsis}，maxLines组合使用可实现英文单词按字母截断，超出部分以省略号显示。Launch cn.darrenyou.nextfamily success in 3 s 812 ms') {
              }
              .width('100%')
              .maxLines(2)
              .fontSize(10)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .wordBreak(WordBreak.BREAK_WORD)
              .allBorder()
              .margin({ bottom: 4 })

              // selection
              this.titleRow('textOverflow', '设置选中区域。选中区域高亮且显示手柄和文本选择菜单。')
              Text('当前selection = selection(2, 11)，设置选中区域。选中区域高亮且显示手柄和文本选择菜单。当前选中\'当前selection\' ') {
              }
              .width('100%')
              .fontSize(20)
              .copyOption(CopyOptions.LocalDevice)
              .selection(2, 11)
              .allBorder()
              .margin({ bottom: 4 })

              // ellipsisMode
              this.titleRow('ellipsisMode', '设置省略位置。')
              Text('当前ellipsisMode = EllipsisMode.START，设置省略位置。ellipsisMode属性需要配合overflow设置为TextOverflow.Ellipsis以及maxLines使用，单独设置ellipsisMode属性不生效。') {
              }
              .width('100%')
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .ellipsisMode(EllipsisMode.START)
              .allBorder()
              .margin({ bottom: 4 })
              Text('当前ellipsisMode = EllipsisMode.CENTER，设置省略位置。ellipsisMode属性需要配合overflow设置为TextOverflow.Ellipsis以及maxLines使用，单独设置ellipsisMode属性不生效。') {
              }
              .width('100%')
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .ellipsisMode(EllipsisMode.CENTER)
              .allBorder()
              .margin({ bottom: 4 })
              Text('当前ellipsisMode = EllipsisMode.END，设置省略位置。ellipsisMode属性需要配合overflow设置为TextOverflow.Ellipsis以及maxLines使用，单独设置ellipsisMode属性不生效。') {
              }
              .width('100%')
              .maxLines(1)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .ellipsisMode(EllipsisMode.END)
              .allBorder()
              .margin({ bottom: 8 })

              // enableDataDetector
              this.titleRow('enableDataDetector', '设置是否进行文本特殊实体识别。')
              Text('当前enableDataDetector = true，触摸点击和鼠标右键点击实体，会根据实体类型弹出对应的实体操作菜单，鼠标左键点击实体会直接响应菜单的第一个选项。\n' +
                '当overflow设置为TextOverflow.MARQUEE时，该功能不会生效。\n' +
                '当copyOption设置为CopyOptions.None时，点击实体弹出的菜单没有选择文本和复制功能。15680798739 当copyOption不为CopyOptions.None，且textSelectable设置为TextSelectableMode.UNSELECTABLE时，仍然具有实体复制功能，但没有选择文本功能。') {
              }
              .width('100%')
              .enableDataDetector(true)
              .allBorder()
              .decoration({
                type: TextDecorationType.Underline,
                color:  Color.Green,
                style: TextDecorationStyle.SOLID
              })
              .margin({ bottom: 4 })
              Text('当前enableDataDetector = true，触摸点击和鼠标右键点击实体，会根据实体类型弹出对应的实体操作菜单，鼠标左键点击实体会直接响应菜单的第一个选项。\n' +
                '当overflow设置为TextOverflow.MARQUEE时，该功能不会生效。\n' +
                '当copyOption设置为CopyOptions.None时，点击实体弹出的菜单没有选择文本和复制功能。15680798739 当copyOption不为CopyOptions.None，且textSelectable设置为TextSelectableMode.UNSELECTABLE时，仍然具有实体复制功能，但没有选择文本功能。') {
              }
              .width('100%')
              .enableDataDetector(false)
              .allBorder()
              .decoration({
                type: TextDecorationType.Underline,
                color:  Color.Green,
                style: TextDecorationStyle.SOLID
              })
              .margin({ bottom: 4 })

              // dataDetectorConfig
              this.titleRow('enableDataDetector', '设置文本识别配置。当有两个实体A、B重叠时，按以下规则保留实体：\n' +
                '1. 若A ⊂ B，则保留B，反之则保留A。\n' +
                '2. 当A ⊄ B且B ⊄ A时，若A.start < B.start，则保留A，反之则保留B。')
              Text('需配合enableDataDetector一起使用，设置enableDataDetector为true时，dataDetectorConfig的配置才能生效。work@darrenyou.cn 15680798739') {
              }
              .width('100%')
              .enableDataDetector(true)
              .allBorder()
              .decoration({
                type: TextDecorationType.Underline,
                color:  Color.Green,
                style: TextDecorationStyle.SOLID
              })
              .dataDetectorConfig({
                // 设置文本识别的实体类型。设置types为null或者[]时，识别所有类型的实体，否则只识别指定类型的实体。
                types: [TextDataDetectorType.PHONE_NUMBER, TextDataDetectorType.EMAIL, TextDataDetectorType.URL],
                // 文本识别成功后，触发onDetectResultUpdate回调。
                // - result：文本识别的结果，Json格式。
                onDetectResultUpdate: (result: string) => {
                  Logger.debug('TextPage dataDetectorConfig onDetectResultUpdate: ' + result)
                },
                // 设置文本识别成功后的实体颜色。
                // 默认值：'#ff0a59f7'
                color: Color.Green,
                decoration: {
                  type: TextDecorationType.Underline,
                  color:  Color.Green,
                  style: TextDecorationStyle.SOLID
                }
              })
              .margin({ bottom: 4 })

              // bindSelectionMenu
              this.titleRow('bindSelectionMenu', '设置自定义选择菜单。bindSelectionMenu长按响应时长为600ms，bindContextMenu长按响应时长为800ms，同时绑定且触发方式均为长按时，优先响应bindSelectionMenu。\n' +
                '自定义菜单超长时，建议内部嵌套Scroll组件使用，避免键盘被遮挡。')
              Text('鼠标右键触发菜单弹出') {
              }
              .width('100%')
              .fontSize(20)
              .copyOption(CopyOptions.InApp)
              .bindSelectionMenu(
                TextSpanType.TEXT,
                this.bindSelectionMenu(),
                TextResponseType.RIGHT_CLICK,
                {
                  onAppear: () => {
                    Logger.debug('TextPage bindSelectionMenu onAppear')
                  },
                  onDisappear: () => {
                    Logger.debug('TextPage bindSelectionMenu onDisappear')
                  },
                }
              )
              .allBorder()
              .margin({ bottom: 16 })
              Text('长按触发菜单弹出') {
              }
              .width('100%')
              .fontSize(20)
              .copyOption(CopyOptions.InApp)
              .bindSelectionMenu(
                // 选择菜单的类型。
                // 默认值：TextSpanType.TEXT
                TextSpanType.TEXT,
                // 选择菜单的内容。
                this.bindSelectionMenu(),
                // 选择菜单的响应类型。
                // 默认值：TextResponseType.LONG_PRESS
                TextResponseType.LONG_PRESS,
                // 选择菜单的选项。
                {
                  onAppear: () => {
                    Logger.debug('TextPage bindSelectionMenu onAppear')
                  },
                  onDisappear: () => {
                    Logger.debug('TextPage bindSelectionMenu onDisappear')
                  },
                }
              )
              .allBorder()
              .margin({ bottom: 16 })
              Text('鼠标选中触发菜单弹出') {
              }
              .width('100%')
              .fontSize(20)
              .copyOption(CopyOptions.InApp)
              .bindSelectionMenu(
                TextSpanType.TEXT,
                this.bindSelectionMenu(),
                TextResponseType.SELECT,
                {
                  onAppear: () => {
                    Logger.debug('TextPage bindSelectionMenu onAppear')
                  },
                  onDisappear: () => {
                    Logger.debug('TextPage bindSelectionMenu onDisappear')
                  },
                }
              )
              .allBorder()
              .margin({ bottom: 16 })

              // fontFeature
              this.titleRow('fontFeature', '设置文字特性效果，比如数字等宽的特性。')
              Text('fontFeature, 格式为：normal | <feature-tag-value>') {
              }
              .width('100%')
              .fontSize(20)
              .fontFeature("ss01")
              .allBorder()
              .margin({ bottom: 16 })

              // lineSpacing
              this.titleRow('lineSpacing', '设置文本的行间距，设置值不大于0时，取默认值0。')
              Text('当前行间距为lineSpacing({\n' +
                '                value: 40,\n' +
                '                unit: 1,\n' +
                '              })，设置文本的行间距，设置值不大于0时，取默认值0。设置文本的行间距，设置值不大于0时，取默认值0') {
              }
              .width('100%')
              .allBorder()
              .lineSpacing({
                // 长度属性的值。
                value: 20,
                // 长度属性的单位，默认为VP。
                unit: 1,
              })
              .margin({ bottom: 16 })

              // privacySensitive
              this.titleRow('privacySensitive', '设置是否支持卡片敏感隐私信息')
              Text('当前privacySensitive: true') {
              }
              .width('100%')
              .fontSize(20)
              .privacySensitive(true)
              // 设置组件内容的遮罩类型。
              .obscured([ObscuredReasons.PLACEHOLDER])
              .allBorder()
              .margin({ bottom: 16 })

              // lineBreakStrategy
              this.titleRow('lineBreakStrategy', '设置折行规则。该属性在wordBreak不等于breakAll的时候生效，不支持连词符。')
              Text('当前lineBreakStrategy: LineBreakStrategy.GREEDY 设置折行规则。该属性在wordBreak不等于breakAll的时候生效，不支持连词符。') {
              }
              .width('100%')
              .lineBreakStrategy(LineBreakStrategy.GREEDY)
              .allBorder()
              .margin({ bottom: 16 })

              Text('当前lineBreakStrategy: LineBreakStrategy.HIGH_QUALITY 设置折行规则。该属性在wordBreak不等于breakAll的时候生效，不支持连词符。') {
              }
              .width('100%')
              .lineBreakStrategy(LineBreakStrategy.HIGH_QUALITY)
              .allBorder()
              .margin({ bottom: 16 })

              Text('当前lineBreakStrategy: LineBreakStrategy.BALANCED 设置折行规则。该属性在wordBreak不等于breakAll的时候生效，不支持连词符。') {
              }
              .width('100%')
              .lineBreakStrategy(LineBreakStrategy.BALANCED)
              .allBorder()
              .margin({ bottom: 16 })

              // textSelectable
              this.titleRow('textSelectable', '设置是否支持文本可选择、可获焦以及Touch后能否获取焦点。')
              Text('当前textSelectable(TextSelectableMode.SELECTABLE_UNFOCUSABLE) 文本是否支持可选择、可获焦。') {
              }
              .width('100%')
              .textSelectable(TextSelectableMode.SELECTABLE_UNFOCUSABLE)
              .allBorder()
              .margin({ bottom: 16 })
              Text('当前textSelectable(TextSelectableMode.SELECTABLE_FOCUSABLE) 文本是否支持可选择、可获焦。') {
              }
              .width('100%')
              .textSelectable(TextSelectableMode.SELECTABLE_FOCUSABLE)
              .allBorder()
              .margin({ bottom: 16 })
              Text('当前textSelectable(TextSelectableMode.UNSELECTABLE) 文本是否支持可选择、可获焦。') {
              }
              .width('100%')
              .textSelectable(TextSelectableMode.UNSELECTABLE)
              .allBorder()
              .margin({ bottom: 16 })

              // editMenuOptions
              this.titleRow('editMenuOptions', '设置文本菜单的显示选项。')
              Text('长按选择文本弹出菜单') {
              }
              .copyOption(CopyOptions.InApp)
              .width('100%')
              .editMenuOptions({
                onCreateMenu: (menuItems: TextMenuItem[]): TextMenuItem[] => {
                  return [
                    {
                      content: '1剪切',
                      icon: $r('sys.symbol.ranking'),
                      id: TextMenuItemId.CUT,
                    },
                    {
                      content: '2复制',
                      icon: $r('sys.symbol.voice_convert_text'),
                      id: TextMenuItemId.COPY,
                    },
                    {
                      content: '3粘贴',
                      icon: $r('sys.symbol.touchpad'),
                      id: TextMenuItemId.PASTE,
                    },
                    {
                      content: '4全选',
                      icon: $r('sys.symbol.ohos_arrow_up'),
                      id: TextMenuItemId.SELECT_ALL,
                    },
                    {
                      content: '5互通服务',
                      icon: $r('sys.symbol.ohos_wifi'),
                      id: TextMenuItemId.COLLABORATION_SERVICE,
                    },
                    {
                      content: '6拍摄输入',
                      icon: $r('sys.symbol.ohos_photo'),
                      id: TextMenuItemId.CAMERA_INPUT,
                    },
                  ];
                },
                onMenuItemClick: (menuItem: TextMenuItem, range: TextRange): boolean => {
                  Logger.debug('TextPage editMenuOptions onMenuItemClick menuItem: ' + JSON.stringify(menuItem))
                  return false
                },
              })
              .allBorder()
              .margin({ bottom: 16 })

              // minFontScale
              this.titleRow('minFontScale', '设置文本最小的字体缩放倍数。文本最大的字体缩放倍数。\n' +
                '\n' +
                '取值范围：[1, +∞)\n' +
                '\n' +
                '说明：\n' +
                '\n' +
                '设置的值小于1时，按值为1处理，异常值默认不生效。')
              Text('当前minFontScale: 0.5') {
              }
              .width('100%')
              .minFontScale(0.5)
              .allBorder()
              .margin({ bottom: 16 })
              Text('当前minFontScale: 0.8') {
              }
              .width('100%')
              .minFontScale(0.8)
              .allBorder()
              .margin({ bottom: 16 })

              // halfLeading
              this.titleRow('halfLeading', '设置文本是否将行间距平分至行的顶部与底部。\n组件侧设置halfLeading优先级高于module.json5配置文件中的halfLeading配置项。')
              Text('当前halfLeading: true, 文本是否将行间距平分至行的顶部与底部。true表示将行间距平分至行的顶部与底部，false则不平分。默认值：false') {
              }
              .width('100%')
              .halfLeading(true)
              .allBorder()
              .margin({ bottom: 16 })
              Text('当前halfLeading: false, 文本是否将行间距平分至行的顶部与底部。true表示将行间距平分至行的顶部与底部，false则不平分。默认值：false') {
              }
              .width('100%')
              .halfLeading(false)
              .allBorder()
              .margin({ bottom: 16 })

              // font
              this.titleRow('font', '设置文本样式，支持设置字体配置项。\n仅Text组件生效，其子组件不生效。')
              Text('当前font: {\n' +
                '                  size: 12,\n' +
                '                  weight: FontWeight.Regular,\n' +
                '                  family: \'Arial\',\n' +
                '                  style: FontStyle.Italic\n' +
                '                }') {
              }
              .width('100%')
              .font(
                {
                  size: 12,
                  weight: FontWeight.Regular,
                  family: 'Arial',
                  style: FontStyle.Italic
                },
                // 字体配置项
                {
                  // 是否支持字重无极调节
                  enableVariableFontWeight: true,
                }
              )
              .allBorder()

              // fontWeight
              this.titleRow('fontWeight', '设置文本字重，支持设置字体配置项\n仅Text组件生效，其子组件不生效。')
              Text('当前fontWeight: FontWeight.Regular') {
              }
              .width('100%')
              .fontWeight(
                FontWeight.Regular,
                // 字体配置项
                {
                  // 是否支持字重无极调节
                  enableVariableFontWeight: true,
                }
              )
              .allBorder()
              .margin({ bottom: 16 })




            }
            .alignItems(HorizontalAlign.Start)
            .padding({ left: 8, right: 8 })
          }
          .padding({ left: 16, right: 16 })
        }
        .width('100%')
        .layoutWeight(1)
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
