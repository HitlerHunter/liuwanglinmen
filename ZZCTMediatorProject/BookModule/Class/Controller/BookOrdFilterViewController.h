//
//  BookOrdFilterViewController.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/17.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "SDBaseViewController.h"

@protocol BookOrdFilterDelegate <NSObject>

- (void)didFinishSelect:(NSDictionary *)dic;

@end

@class BookViewModel;
@interface BookOrdFilterViewController : SDBaseViewController

@property (nonatomic, strong) BookViewModel *viewModel;

@property (nonatomic, weak) id <BookOrdFilterDelegate> delegate;
@end
