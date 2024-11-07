import { CommonDialogSettings } from '../CommonDialog'

export class AgreementDocDialogVO extends CommonDialogSettings {
  type?:number
  show?:number

  constructor(type: number, show: number) {
    super()
    this.type = type
    this.show = show
  }
}