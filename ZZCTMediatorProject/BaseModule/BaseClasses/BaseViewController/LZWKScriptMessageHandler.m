//
//  LZWKScriptMessageHandler.m
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/2/26.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import "LZWKScriptMessageHandler.h"

@implementation LZWKScriptMessageHandler

+ (LZWKScriptMessageHandler *)handlerWithDelegate:(id <LZWKScriptMessageHandlerDelegate>)delegate{
    LZWKScriptMessageHandler *handler = [[LZWKScriptMessageHandler alloc] init];
    handler.delegate = delegate;
    return handler;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
    if (_delegate && [_delegate respondsToSelector:@selector(lz_userContentController:didReceiveScriptMessage:)]) {
        [_delegate lz_userContentController:userContentController didReceiveScriptMessage:message];
    }
};


@end
