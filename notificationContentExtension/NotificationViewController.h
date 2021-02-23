//
//  NotificationViewController.h
//  notificationContentExtension
//
//  Created by akhil.y on 23/02/21.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>
#import <LocalAuthentication/LocalAuthentication.h>
#import "AdvancedSwipeViewDelegate.h"

@interface NotificationViewController : UIViewController<UNNotificationContentExtension,AdvancedSwipeViewDelegate>
@property (strong, nonatomic) NSTimer *timer;
@end

