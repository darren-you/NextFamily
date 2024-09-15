export class PhoneNumberUtil {
  private constructor() {}

  /**
   * 校验手机号是否正确
   * @param phoneNumber
   * @returns
   */
  static isValidPhoneNumber(phoneNumber: string): boolean {
    if (
        phoneNumber === undefined ||
        phoneNumber === null ||
        phoneNumber.trim() == '' ||
        phoneNumber.trim().length == 0
    ) return false;

    const regex = /^1[3-9]\d{9}$/;
    return regex.test(phoneNumber);
  }
}

