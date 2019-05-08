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
//  ChatBaseEventImpl.m
//  MibileIMSDK4iDemo_X (A demo for MobileIMSDK v3.0 at Summer 2017)
//
//  Created by JackJiang on 14/10/28.
//  Copyright (c) 2017年 52im.net. All rights reserved.
//

#import "ChatBaseEventImpl.h"
#import "AppDelegate.h"
#import "MainViewController.h"


/**
 * 与IM服务器的连接事件在此ChatBaseEvent子类中实现即可。
 *
 * @author Jack Jiang, 20170501
 * @version.1.1
 */
@implementation ChatBaseEventImpl

/*!
 * 本地用户的登陆结果回调事件通知。
 *
 * @param dwErrorCode 服务端反馈的登录结果：0 表示登陆成功，否则为服务端自定义的出错代码（按照约定通常为>=1025的数）
 */
- (void) onLoginMessage:(int)dwErrorCode
{
    if (dwErrorCode == 0)
    {
        NSLog(@"【DEBUG_UI】IM服务器登录/连接成功！");
        
        // UI显示
        [CurAppDelegate refreshConnecteStatus];
        [[CurAppDelegate getMainViewController] showIMInfo_green:[NSString stringWithFormat:@"登录成功,dwErrorCode=%d", dwErrorCode]];
    }
    else
    {
        NSLog(@"【DEBUG_UI】IM服务器登录/连接失败，错误代码：%d", dwErrorCode);
        
        // UI显示
        [[CurAppDelegate getMainViewController] showIMInfo_red:[NSString stringWithFormat:@"IM服务器登录/连接失败,code=%d", dwErrorCode]];
    }
    
    // 此观察者只有开启程序首次使用登陆界面时有用
    if(self.loginOkForLaunchObserver != nil)
    {
        self.loginOkForLaunchObserver(nil, [NSNumber numberWithInt:dwErrorCode]);
        
        //## Try bug FIX! 20160810：上方的observer作为block代码应是被异步执行，此处立即设置nil的话，实测
        //##                        中会遇到怎么也登陆不进去的问题（因为此observer已被过早的nil了！）
//        self.loginOkForLaunchObserver = nil;
    }
}

/*!
 * 与服务端的通信断开的回调事件通知。
 *
 * <br>
 * 该消息只有在客户端连接服务器成功之后网络异常中断之时触发。
 * 导致与与服务端的通信断开的原因有（但不限于）：无线网络信号不稳定、WiFi与2G/3G/4G等同开情
 * 况下的网络切换、手机系统的省电策略等。
 *
 * @param dwErrorCode 本回调参数表示表示连接断开的原因，目前错误码没有太多意义，仅作保留字段，目前通常为-1
 */
- (void) onLinkCloseMessage:(int)dwErrorCode
{
    NSLog(@"【DEBUG_UI】与IM服务器的网络连接出错关闭了，error：%d", dwErrorCode);
    
    // UI显示
    [CurAppDelegate refreshConnecteStatus];
    [[CurAppDelegate getMainViewController] showIMInfo_red:[NSString stringWithFormat:@"与IM服务器的连接已断开, 自动登陆/重连将启动! (%d)", dwErrorCode]];
}


@end
