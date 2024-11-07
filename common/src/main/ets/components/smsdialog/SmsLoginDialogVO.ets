import { CommonDialogSettings } from '../CommonDialog'
import { THIRD_LOGIN_TYPE } from './ThirdLoginEnum'

export class SmsLoginDialogVO extends CommonDialogSettings {
  pageInfos?: NavPathStack
  cancelCallback?: () => void
  requestSmsCodeCallback?: (phoneNumber: string, requestState: boolean, smsCode: string | null) => void
  smsLoginCallback?: (phoneNumber: string, verifyCode: string) => void
  thirdLoginCallback?: (thirdLoginType: THIRD_LOGIN_TYPE) => void

  constructor() {
    super()
  }

  setPageInfos(pageInfos?: NavPathStack): SmsLoginDialogVO {
    this.pageInfos = pageInfos
    return this
  }

  setCancelCallback(callback?: () => void): SmsLoginDialogVO {
    this.cancelCallback = callback
    return this
  }

  setRequestSmsCodeCallback(callback?: (phoneNumber: string, requestState: boolean, smsCode: string | null) => void): SmsLoginDialogVO {
    this.requestSmsCodeCallback = callback
    return this
  }

  setSmsLoginCallback(callback?: (phoneNumber: string, verifyCode: string) => void): SmsLoginDialogVO {
    this.smsLoginCallback = callback
    return this
  }

  setThirdLoginCallback(callback?: (thirdLoginType: THIRD_LOGIN_TYPE) => void): SmsLoginDialogVO {
    this.thirdLoginCallback = callback
    return this
  }
}
