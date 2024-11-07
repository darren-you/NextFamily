import { ComponentContent, promptAction, window } from '@kit.ArkUI'
import { util } from '@kit.ArkTS'

export class CommonDialog<T extends CommonDialogSettings> {
  private static instance: object | null;
  private CommonDialogEntryList: CommonDialogEntry[] = new Array<CommonDialogEntry>()
  private uiContext?: UIContext
  private dialogView?: WrappedBuilder<[T]>
  private dialogArgs?: T
  private dialogOptions?: promptAction.BaseDialogOptions

  private constructor() {}

  static getInstance<T extends CommonDialogSettings>(): CommonDialog<T> {
    if (!CommonDialog.instance) {
      CommonDialog.instance = new CommonDialog<T>();
    }
    return CommonDialog.instance as CommonDialog<T>;
  }

  static setView<T extends CommonDialogSettings>(dialogView: WrappedBuilder<[T]>): CommonDialog<T> {
    return CommonDialog.getInstance<T>().setView(dialogView)
  }

  setView(dialogView: WrappedBuilder<[T]>): CommonDialog<T> {
    this.dialogView = dialogView
    return this
  }

  setArgs(dialogArgs: T): CommonDialog<T> {
    this.dialogArgs = dialogArgs
    return this
  }

  setOptions(dialogOptions: promptAction.BaseDialogOptions | undefined): CommonDialog<T> {
    this.dialogOptions = dialogOptions
    return this
  }

  show(): CommonDialog<T> {
    if (this.uiContext) {
      this.createDialog(this.uiContext, this.dialogView!, this.dialogArgs!, this.dialogOptions)
    } else {
      window.getLastWindow(getContext()).then((result: window.Window) => {
        this.uiContext = result.getUIContext()
        this.createDialog(this.uiContext, this.dialogView!, this.dialogArgs!, this.dialogOptions)
      })
    }
    return this
  }

  private createDialog(context: UIContext, dialogView: WrappedBuilder<[T]>,
    dialogArgs: T, dialogOptions?: promptAction.BaseDialogOptions) {
    let dialogComponentContent = new ComponentContent(context, dialogView, dialogArgs)
    let dialogBaseOptions: promptAction.BaseDialogOptions = {
      alignment: dialogOptions?.alignment ?? DialogAlignment.Center,
      autoCancel: dialogOptions?.autoCancel ?? true,
      maskColor: dialogOptions?.maskColor,
      transition: dialogOptions?.transition,
      onWillDismiss: (action: DismissDialogAction) => {
        console.log('dialogOptions: > ' + dialogOptions)
        if (dialogOptions?.onWillDismiss) {
          dialogOptions.onWillDismiss(action)
        } else {
          // 返回手势 || 点击外部
          if (action.reason == DismissReason.PRESS_BACK || action.reason == DismissReason.TOUCH_OUTSIDE) {
            action.dismiss()
          }
        }
      },
      onWillAppear: () => {
        // 添加进Dialog List
        CommonDialog.getInstance<T>().addDialog(dialogComponentContent, dialogArgs)
        if (dialogOptions?.onWillAppear) {
          dialogOptions.onWillAppear()
        }
      },
      onDidAppear: () => {
        if (dialogOptions?.onDidAppear) {
          dialogOptions.onDidAppear()
        }
      },
      onDidDisappear: () => {
        if (dialogOptions?.onDidDisappear) {
          dialogOptions.onDidDisappear()
        }
      },
      onWillDisappear: () => {
        CommonDialog.getInstance<T>().removeDialog(dialogComponentContent, dialogArgs)
        if (dialogOptions?.onWillDisappear) {
          dialogOptions.onWillDisappear()
        }
      }
    }
    const promptAction = context.getPromptAction()
    promptAction.openCustomDialog(dialogComponentContent, dialogBaseOptions)
  }

  updateDialog<T extends CommonDialogSettings>(args: T) {
    let CommonDialogEntry: CommonDialogEntry | undefined =
      CommonDialog.getInstance().getDialogById(args.dialogId)
    if (CommonDialogEntry) {
      CommonDialogEntry.dialogContent.update(args)
    }
  }

  closeDialog(dialogId?: string) {
    if (!this.uiContext) {
      console.error('openCommonDialog', `error= uiContext is null`)
      return
    }
    const uiContext: UIContext = this.uiContext!
    const promptAction = uiContext.getPromptAction()
    let info: CommonDialogEntry | undefined = undefined
    if (dialogId) {
      info = CommonDialog.getInstance().getDialogById(dialogId)
    } else {
      info = CommonDialog.getInstance().getCurrentDialog()
    }
    if (info) {
      promptAction.closeCustomDialog(info.dialogContent)
    } else {
      console.error('closeCommonDialog', 'info is null')
    }
  }

  getCurrentDialog(): CommonDialogEntry {
    return CommonDialog.getInstance().CommonDialogEntryList[0]
  }

  getDialogById(dialogId: string): CommonDialogEntry | undefined {
    let infoList: CommonDialogEntry[] = CommonDialog.getInstance().CommonDialogEntryList
    let CommonDialogVO = infoList.find((item) =>
    dialogId == item.dialogId)
    return CommonDialogVO
  }

  private addDialog(dialogContent: ComponentContent<object>,
    args: object) {
    let infoList = CommonDialog.getInstance().CommonDialogEntryList
    let info: CommonDialogEntry = {
      dialogId: (args as CommonDialogSettings).dialogId,
      dialogContent: dialogContent,
      args: args
    }
    infoList.unshift(info)
  }

  private removeDialog(dialogComponentContent: ComponentContent<object>,
    args: object) {
    let infoList = CommonDialog.getInstance().CommonDialogEntryList
    let index = infoList.findIndex((item) =>
    (args as CommonDialogSettings).dialogId == item.dialogId)
    if (index >= 0) {
      infoList.splice(index, 1)
    } else {
      infoList.shift()
    }
  }
}


@Observed
export class CommonDialogSettings {
  dialogId: string = ''

  constructor() {
    this.dialogId = util.generateRandomUUID()
  }
}

export interface CommonDialogEntry {
  dialogId: string
  dialogContent: ComponentContent<object>
  args: object
}