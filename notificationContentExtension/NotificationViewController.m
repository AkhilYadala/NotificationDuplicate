//
//  NotificationViewController.m
//  notificationContentExtension
//
//  Created by akhil.y on 23/02/21.
//

#import "NotificationViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>
#import "advancedSwipeView.h"

@interface NotificationViewController () <UNNotificationContentExtension>
@property (strong, nonatomic) advancedSwipeView *advancedswipeView;
@end

@implementation NotificationViewController

- (advancedSwipeView *)advancedswipeView
{
    if(!_advancedswipeView)
    {
        _advancedswipeView = [[advancedSwipeView alloc]initWithFrame: CGRectMake(0, 0, 250, 50) ];
    }
    return _advancedswipeView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any required interface initialization here.
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self.advancedswipeView action:@selector(pan:)];
    [self.advancedswipeView addGestureRecognizer:panGestureRecognizer];
    [self.view addSubview:self.advancedswipeView];
     
    
}
- (void)didReceiveNotification:(UNNotification *)notification {
    
}

@end
