export class VerifyCodeUtil {
  private constructor() {}

  static checkVerifyCode(verifyCode: string): boolean {
    if (
      verifyCode === undefined ||
      verifyCode === null ||
      verifyCode.trim() == '' ||
      verifyCode.trim().length == 0
    ) return false;

    const regex = /^\d{4}$/;
    return regex.test(verifyCode);
  }
}