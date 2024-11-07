import { ListItemVO } from './ListItemVO'

export class ListGroupVO {
  title: string
  itemVOList: Array<ListItemVO>

  /**
   * @param title Group名称
   * @param itemVOList Group数据
   */
  constructor(title: string, itemVOList: Array<ListItemVO>) {
    this.title = title
    this.itemVOList = itemVOList
  }
}