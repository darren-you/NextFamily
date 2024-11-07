import { HMInterceptor, HMInterceptorAction, HMInterceptorInfo, IHMInterceptor, HMActionType } from '@hadss/hmrouter';
import { Logger } from '@darren/common';

@HMInterceptor({ interceptorName: 'JumpInfoInterceptor' })
export class JumpInfoInterceptor implements IHMInterceptor {
  handle(info: HMInterceptorInfo): HMInterceptorAction {
    let connectionInfo: string = '';
    if (info.type === HMActionType.PUSH) {
      connectionInfo = 'jump to';
    } else {
      connectionInfo = 'back to';
    }

    Logger.debug(`${info.srcName} ${connectionInfo} ${info.targetName}`)
    return HMInterceptorAction.DO_NEXT;
  }
}