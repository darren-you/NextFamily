/**
 * Constants for Device Screen.
 */
export class DeviceScreenConstants {
  static readonly DEVICE_SCREEN_SM: string = 'sm';
  static readonly DEVICE_SCREEN_MD: string = 'md';
  static readonly DEVICE_SCREEN_LG: string = 'lg';

  static readonly DEVICE_SCREEN_RANGE_SM: string = '(320vp<=width<520vp)';
  static readonly DEVICE_SCREEN_RANGE_MD: string = '(520vp<=width<840vp)';
  static readonly DEVICE_SCREEN_RANGE_LG: string = '(840vp<=width)';

  static readonly DEVICE_SCREEN_ORIENTATION: string = '(orientation: landscape)';
  static readonly DEVICE_SCREEN_LANDSCAPE: number = 0;
  static readonly DEVICE_SCREEN_PORTRAIT: number = 1;

  static readonly CURRENT_BREAKPOINT: string = 'currentSize';
  static readonly CURRENT_ORIENTATION: string = 'currentOrientation';


}