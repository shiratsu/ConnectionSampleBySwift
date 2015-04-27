//
//  ConnectionBySessionForMultitask.h
//  ConnectionSampleSwift
//
//  Created by 平塚 俊輔 on 2015/04/24.
//  Copyright (c) 2015年 平塚 俊輔. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConnectionBySessionResult.h"

@interface ConnectionBySessionForMultitask : NSObject<NSURLSessionDataDelegate>
{
    NSMutableDictionary *datadic;
    NSMutableData *connectedData;
    NSInteger status;
    NSURLSession *session;
    int taskcount;
    
}
@property(assign,nonatomic) id<ConnectionBySessionResult> delegate;
@property(strong,nonatomic) NSMutableDictionary *datadic;
@property(strong,nonatomic) NSMutableData *connectedData;
@property(assign,nonatomic) NSInteger status;
@property(strong,nonatomic) NSURLSession *session;
@property(assign,nonatomic) int taskcount;

-(void)doMultiTask:(NSArray *)urlary;
-(void)cancelConnect;
-(void)cancelTasksByUrl:(NSArray *)tasks;
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler;
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didBecomeDownloadTask:(NSURLSessionDownloadTask *)downloadTask;
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data;
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error;
- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(NSError *)error;

@end
