import { THIRD_LOGIN_TYPE } from './ThirdLoginEnum'

export class ThirdLoginVO {
  thirdLoginType: THIRD_LOGIN_TYPE
  thirdLoginTypeName: string
  thirdLoginTypeIcon: Resource

  constructor(thirdLoginType: THIRD_LOGIN_TYPE, thirdLoginTypeName: string, thirdLoginTypeIcon: Resource) {
    this.thirdLoginType = thirdLoginType
    this.thirdLoginTypeName = thirdLoginTypeName
    this.thirdLoginTypeIcon = thirdLoginTypeIcon
  }
}