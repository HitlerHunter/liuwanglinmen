//
//  LZWKScriptMessageHandler.h
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/2/26.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LZWKScriptMessageHandlerDelegate <NSObject>

- (void)lz_userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message;

@end

@interface LZWKScriptMessageHandler : NSObject <WKScriptMessageHandler>

@property (nonatomic, weak) id <LZWKScriptMessageHandlerDelegate> delegate;

+ (LZWKScriptMessageHandler *)handlerWithDelegate:(id <LZWKScriptMessageHandlerDelegate>)delegate;
@end

NS_ASSUME_NONNULL_END
