import hilog from '@ohos.hilog';

export class Logger {
  private static readonly DOMAIN = 0x0001;
  private static readonly TAG = "Logger";
  public static enabledPrint = false;

  public static debug(format: string, ...args: unknown[]): void {
    if (this.enabledPrint) hilog.debug(this.DOMAIN, this.TAG, format, args);
  }

  public static info(format: string, ...args: unknown[]): void {
    if (this.enabledPrint) hilog.info(this.DOMAIN, this.TAG, format, args);
  }

  public static warn(format: string, ...args: unknown[]): void {
    if (this.enabledPrint) hilog.warn(this.DOMAIN, this.TAG, format, args);
  }

  public static error(format: string, ...args: unknown[]): void {
    if (this.enabledPrint) hilog.error(this.DOMAIN, this.TAG, format, args);
  }

  public static fatal(format: string, ...args: unknown[]): void {
    if (this.enabledPrint) hilog.fatal(this.DOMAIN, this.TAG, format, args);
  }
}
