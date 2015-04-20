//
//  ConnectionResultBySession.h
//  ConnectionBySession
//
//  Created by 平塚 俊輔 on 2015/04/11.
//  Copyright (c) 2015年 平塚 俊輔. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ConnectionBySessionResult <NSObject>

- (void)showResult;
- (void)handleErrorForConnection;

@end
