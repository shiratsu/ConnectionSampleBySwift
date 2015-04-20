//
//  ConnectionBySession.m
//  ConnectionBySession
//
//  Created by 平塚 俊輔 on 2015/04/09.
//  Copyright (c) 2015年 平塚 俊輔. All rights reserved.
//

#import "ConnectionBySession.h"



@implementation ConnectionBySession

@synthesize delegate;
@synthesize urlStr;
@synthesize connectedData;
@synthesize status;
@synthesize session;

-(id)initWithUrl:(NSString *)urlArgStr{
    if (self = [super init]) {
        // 初期処理
        self.urlStr = urlArgStr;
        self.connectedData = [[NSMutableData alloc] init];
    }
    return self;
}

-(void)doConncet{
    
    NSURL* url = [NSURL URLWithString:[self.urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.timeoutIntervalForRequest = 15;
    self.session = [NSURLSession sessionWithConfiguration:config
                                                 delegate:self
                                            delegateQueue:[NSOperationQueue mainQueue]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request];
    
    [task resume];
    
}
-(void)cancelConnect{
    
    [self.session getTasksWithCompletionHandler:^(NSArray* dataTasks, NSArray* uploadTasks, NSArray* downloadTasks){
        NSLog(@"Currently suspended tasks");
        
        [self cancelTasksByUrl:dataTasks];
    }];
    
}
-(void)cancelTasksByUrl:(NSArray *)tasks{
    
    for (NSURLSessionTask* task in tasks) {
        [task cancel];
    }
    
}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler{
    
    if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
        
        NSHTTPURLResponse *httpURLResponse = (NSHTTPURLResponse *)response;
        
        self.status = httpURLResponse.statusCode;
        
        if(self.status == 200){
            NSURLSessionResponseDisposition disposition = NSURLSessionResponseAllow;
            
            completionHandler(disposition);
        }else{
            [self.delegate handleErrorForConnection];
        }
        
    }
    
    
}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didBecomeDownloadTask:(NSURLSessionDownloadTask *)downloadTask
{
    NSLog(@"didBecomeDownloadTask");
}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    
    [self.connectedData appendData:data];
    [self.delegate showResult];
    
}
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    
    NSLog(@"%@",error);
    
    if(error != nil){
        [self.delegate handleErrorForConnection];
        
    }
    
}
- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(NSError *)error{
    NSLog(@"%@",error);
    
    if(error != nil){
        [self.delegate handleErrorForConnection];
        
    }
}

@end
