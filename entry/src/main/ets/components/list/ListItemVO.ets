import { util } from '@kit.ArkTS'

export class ListItemVO {
  key: string = util.generateRandomUUID(true)
  icon: Resource
  name: string
  desc: string

  /**
   * @param icon: 图标
   * @param name: 名称
   * @param desc: 简介
   */
  constructor(icon: Resource, name: string, desc: string) {
    this.icon = icon
    this.name = name
    this.desc = desc
  }
}