import { util } from '@kit.ArkTS'

export class ListItemVO {
  key: string = util.generateRandomUUID(true)
  icon: Resource
  name: string
  desc: string
  page: string
  guide: string
  api: string


  /**
   * @param icon: 图标
   * @param name: 名称
   * @param desc: 简介
   * @param page: 对应page
   * @param guide: 指南
   * @param api: API
   */
  constructor(icon: Resource, name: string, desc: string, page: string, guide: string, api: string) {
    this.icon = icon
    this.name = name
    this.desc = desc
    this.page = page
    this.guide = guide
    this.api = api
  }
}