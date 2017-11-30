//
//  ViewController.m
//  APNS-Pusher
//
//  Created by Wilson on 2017/11/30.
//  Copyright © 2017年 Wilson. All rights reserved.
//

#import "ViewController.h"
#import "SCLAlertView.h"
#import "AFNetworking.h"

@interface ViewController ()

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)onPushNotificationClicked:(id)sender
{
    if(true
       )
    {
        SCLAlertView *alertView = [[SCLAlertView alloc] init];
        
        [alertView showWaiting:self title:@"Waiting..." subTitle:@"推送中" closeButtonTitle:nil duration:0.0f];
        
        dispatch_async( dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT , 0 ), ^{
            
            NSDictionary *alertJSON=@{ @"title":@"Realtime Custom Push Notifications",
                                       @"subtitle":@"Now with iOS 10 support!",
                                       @"body":@"Add multimedia content to your notifications"};
            
            NSDictionary *meidaJSON;
            
            if(self.SegmentedControl.selectedSegmentIndex==0)
            {
                meidaJSON=@{ @"type":@"image",
                             @"url":@"https://www.fotor.com/images2/features/photo_effects/e_bw.jpg"};
            }
            else
            {
                meidaJSON=@{ @"type":@"video",@"url":@"http://olxnvuztq.bkt.clouddn.com/WeChatSight1.mp4"};
            }
            
            NSDictionary *parameters=@
            {
                @"alert":alertJSON,
                @"media":meidaJSON
            };
            

            NSString *URLString = @"your RESTful api";
            
            
            AFHTTPSessionManager *manager=[[AFHTTPSessionManager alloc]init];
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain",@"text/html", nil];
            
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            
            [manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    
                    [alertView hideView];
                    
                    SCLAlertView *alertView = [[SCLAlertView alloc] init];
                    
                    if([[responseObject objectForKey:@"error"] integerValue]>0)
                    {
                        NSString *message=[responseObject objectForKey:@"message"];
                        
                        [alertView showError:self title:@"Error" subTitle:message closeButtonTitle:@"OK" doneCallback:^{
                            
                        } duration:0.0f];
                        
                    }
                    else
                    {
                        [alertView showSuccess:self title:@"推送成功！！" subTitle:nil closeButtonTitle:@"OK" doneCallback:^{
                            
                            
                            
                        } duration:0.0f];
                    }
                });
                
                
                
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [alertView hideView];
                    NSLog(@"Post失敗");
                });
            }];
        });
        
    }
}
@end
