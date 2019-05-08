//  ----------------------------------------------------------------------
//  Copyright (C) 2017  即时通讯网(52im.net) & Jack Jiang.
//  The MobileIMSDK_X (MobileIMSDK v3.x) Project.
//  All rights reserved.
//
//  > Github地址: https://github.com/JackJiang2011/MobileIMSDK
//  > 文档地址: http://www.52im.net/forum-89-1.html
//  > 即时通讯技术社区：http://www.52im.net/
//  > 即时通讯技术交流群：320837163 (http://www.52im.net/topic-qqgroup.html)
//
//  "即时通讯网(52im.net) - 即时通讯开发者社区!" 推荐开源工程。
//
//  如需联系作者，请发邮件至 jack.jiang@52im.net 或 jb2011@163.com.
//  ----------------------------------------------------------------------
//
//  ChatTransDataEventImpl.m
//  MibileIMSDK4iDemo_X (A demo for MobileIMSDK v3.0 at Summer 2017)
//
//  Created by JackJiang on 14/10/28.
//  Copyright (c) 2017年 52im.net. All rights reserved.
//

#import "ChatTransDataEventImpl.h"
#import "Toast+UIView.h"
#import "AppDelegate.h"
#import "MainViewController.h"
#import "ErrorCode.h"


/**
 * 与IM服务器的数据交互事件在此ChatTransDataEvent子类中实现即可。
 *
 * @author Jack Jiang, 20170501
 * @version.1.1
 */
@implementation ChatTransDataEventImpl

/*!
 * 收到普通消息的回调事件通知。
 * <br>
 * 应用层可以将此消息进一步按自已的IM协议进行定义，从而实现完整的即时通信软件逻辑。
 *
 * @param fingerPrintOfProtocal 当该消息需要QoS支持时本回调参数为该消息的特征指纹码，否则为null
 * @param userid 消息的发送者id（RainbowCore框架中规定发送者id=“0”即表示是由服务端主动发过的，否则表示的是其它客户端发过来的消息）
 * @param dataContent 消息内容的文本表示形式
 */
- (void) onTransBuffer:(NSString *)fingerPrintOfProtocal withUserId:(NSString *)dwUserid andContent:(NSString *)dataContent andTypeu:(int)typeu
{
    NSLog(@"【DEBUG_UI】[%d]收到来自用户%@的消息:%@", typeu, dwUserid, dataContent);
    
    // UI显示
    // Make toast with an image & title
    [[CurAppDelegate getMainView] makeToast:dataContent
                duration:3.0
                position:@"center"
                   title:[NSString stringWithFormat:@"%@说：", dwUserid]
                   image:[UIImage imageNamed:@"qzone_mark_img_myvoice.png"]];
    [[CurAppDelegate getMainViewController] showIMInfo_black:[NSString stringWithFormat:@"%@说：%@", dwUserid, dataContent]];
}

/*!
 * 服务端反馈的出错信息回调事件通知。
 *
 * @param errorCode 错误码，定义在常量表 ErrorCode 中有关服务端错误码的定义
 * @param errorMsg 描述错误内容的文本信息
 * @see ErrorCode
 */
- (void) onErrorResponse:(int)errorCode withErrorMsg:(NSString *)errorMsg
{
    NSLog(@"【DEBUG_UI】收到服务端错误消息，errorCode=%d, errorMsg=%@", errorCode, errorMsg);
    
    // UI显示
    if(errorCode == ForS_RESPONSE_FOR_UNLOGIN)
    {
        NSString *content = [NSString stringWithFormat:@"服务端会话已失效，自动登陆/重连将启动! (%d)", errorCode];
        [[CurAppDelegate getMainViewController] showIMInfo_brightred:content];
    }
    else
    {
        NSString *content = [NSString stringWithFormat:@"Server反馈错误码：%d,errorMsg=%@", errorCode, errorMsg];
        [[CurAppDelegate getMainViewController] showIMInfo_red:content];
    }
}

@end
