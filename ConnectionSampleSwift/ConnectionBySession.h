//
//  ConnectionBySession.h
//  ConnectionBySession
//
//  Created by 平塚 俊輔 on 2015/04/09.
//  Copyright (c) 2015年 平塚 俊輔. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConnectionBySessionResult.h"

@interface ConnectionBySession : NSObject<NSURLSessionDataDelegate>
{
    __weak NSString *urlStr;
    NSMutableData *connectedData;
    NSInteger status;
    NSURLSession *session;
}
@property(assign,nonatomic) id<ConnectionBySessionResult> delegate;
@property(weak,nonatomic) NSString *urlStr;
@property(strong,nonatomic) NSMutableData *connectedData;
@property(assign,nonatomic) NSInteger status;
@property(strong,nonatomic) NSURLSession *session;

-(id)initWithUrl:(NSString *)urlArgStr;
-(void)doConncet;
-(void)cancelConnect;
-(void)cancelTasksByUrl:(NSArray *)tasks;
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler;
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didBecomeDownloadTask:(NSURLSessionDownloadTask *)downloadTask;
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data;
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error;
- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(NSError *)error;

@end
