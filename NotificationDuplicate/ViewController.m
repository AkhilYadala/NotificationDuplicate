//
//  ViewController.m
//  NotificationDuplicate
//
//  Created by akhil.y on 23/02/21.
//

#import "ViewController.h"

@interface ViewController ()

@end

bool isGrantedNotificationAccess;

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    isGrantedNotificationAccess = false;
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    UNAuthorizationOptions options = UNAuthorizationOptionAlert+UNAuthorizationOptionSound;
    
    [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
        isGrantedNotificationAccess = granted;
    }];
}
    
    
- (IBAction)showNotification:(id)sender {
    NSLog(@"Inside show notification");
    
    if(isGrantedNotificationAccess) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = @"Notification Title";
        content.subtitle = @"Notification SubTitle";
        content.body = @"This is the notification's body";
        content.categoryIdentifier = @"myNotification";
    
        
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
        
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"UYLocalNotification" content:content trigger:trigger];
        
        [center addNotificationRequest:request withCompletionHandler:nil];
    }
}


@end
