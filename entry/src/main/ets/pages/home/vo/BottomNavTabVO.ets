@ObservedV2
export class BottomNavTabVO {
  @Trace currentStatus?: boolean = false;
  tabIndex: number = 0;
  tabIcon?: Resource;
  @Trace tabText: string = '';

  /**
   * @param tabIndex Tab索引
   * @param tabText Tab名称
   * @param tabIcon Tab图标
   * @param currentStatus Tab选中状态
   */
  constructor(tabIndex: number, tabText: string, tabIcon?: Resource, currentStatus?: boolean) {
    this.tabIndex = tabIndex;
    this.tabText = tabText;
    this.tabIcon = tabIcon;
    this.currentStatus = currentStatus;
  }
}