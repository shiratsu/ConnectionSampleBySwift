//
//  ConnectionBySessionForMultitask.m
//  ConnectionSampleSwift
//
//  Created by 平塚 俊輔 on 2015/04/24.
//  Copyright (c) 2015年 平塚 俊輔. All rights reserved.
//

#import "ConnectionBySessionForMultitask.h"

@implementation ConnectionBySessionForMultitask

@synthesize delegate;
@synthesize connectedData;
@synthesize status;
@synthesize session;
@synthesize datadic;
@synthesize taskcount;

-(id)init{
    if (self = [super init]) {
        // 初期処理
        self.connectedData = [[NSMutableData alloc] init];
        self.datadic = [[NSMutableDictionary alloc] init];
    }
    return self;
}
-(void)doMultiTask:(NSArray *)urlary{
    
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.timeoutIntervalForRequest = 15;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config
                                                          delegate:self
                                                     delegateQueue:[NSOperationQueue mainQueue]];
    
    //現在のタスクをカウントしておく
    taskcount = [urlary count];
    
    for (int i = 0; i < [urlary count]; i++) {
        NSString *urlstr = [urlary objectAtIndex:i];
        NSURL* url = [NSURL URLWithString:[urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request];
        
        [task resume];
        
    }
    
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
    
    for(int i=1;i<=taskcount;i++){
        
        if(dataTask.taskIdentifier == i){
            NSMutableData *rData = [[NSMutableData alloc] init];
            [rData appendData:data];
            [datadic setObject:rData forKey:[NSString stringWithFormat:@"%d",i]];
        }
        
    }
    
    
    [self.delegate completeMultitask];
    
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
