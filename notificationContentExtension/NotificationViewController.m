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
#import "AppDelegate.h"
#import "SuccessViewController.h"


#define SWIPE_VIEW_CORNER_FONT_STANDARD_HEIGHT 180.0
#define SWIPE_VIEW_ROUNDED_RECT_CORNER_RADIUS 12.0
#define SWIPE_VIEW_DIFFERENCE_BETWEEN_RECT_AND_CIRCLE 8.0
#define SWIPE_VIEW_DIFFERENCE_FOR_ACCEPTANCE_OR_DENIAL 10.0


//bool isAttachmentAllowed;
@interface NotificationViewController () <UNNotificationContentExtension>
@property (weak, nonatomic) IBOutlet advancedSwipeView *advanceSwipeView;
@property (nonatomic) int seconds;
//@property (strong, nonatomic) advancedSwipeView *advancedswipeView;
@end

@implementation NotificationViewController
/*
- (advancedSwipeView *)advancedswipeView
{
    if(!_advancedswipeView)
    {
        _advancedswipeView = [[advancedSwipeView alloc]initWithFrame: CGRectMake(20, 20, 250, 50) ];
    }
    return _advancedswipeView;
}
 */

/*
- (advancedSwipeView *)advanceSwipeView
{
    if(!_advanceSwipeView)
    {
        _advanceSwipeView = [[advancedSwipeView alloc]init];
    }
    return _advanceSwipeView;
}
 */
- (NSTimer *)timer
{
    if(!_timer)
    {
        _timer = [[NSTimer alloc]init];
        //self.seconds =120;
    }
    return _timer;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any required interface initialization here.
    self.view.userInteractionEnabled = true;
    self.seconds = 180;

    /*
    self.advancedswipeView.userInteractionEnabled = true;
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self.advancedswipeView action:@selector(pan:)];
    [self.advancedswipeView addGestureRecognizer:panGestureRecognizer];
    [self.view addSubview:self.advancedswipeView];
     
    self.view.frame = CGRectMake(0, 0, 250, 50);
    //[self.view setNeedsUpdateConstraint];
    [self.view setNeedsLayout];
     
    self.preferredContentSize = CGSizeMake(250, 50);
    [self.view setNeedsLayout];
     */
    //[self authenticateUser];
    
    
}
- (void)didReceiveNotification:(UNNotification *)notification {
    
}
- (IBAction)panFunction:(id)sender {
    if(self.advanceSwipeView.isAttachmentAllowed) {
        CGFloat circleDiameter = self.advanceSwipeView.bounds.size.height - SWIPE_VIEW_DIFFERENCE_BETWEEN_RECT_AND_CIRCLE;
        CGPoint gesturePoint = [sender locationInView:self.advanceSwipeView];
        gesturePoint.y = self.advanceSwipeView.bounds.size.height/2.0;

        if(([sender state] == UIGestureRecognizerStateBegan) || [sender state] == UIGestureRecognizerStateChanged || [sender state ] == UIGestureRecognizerStateEnded) {

            if([sender state ] == UIGestureRecognizerStateBegan) {
                self.advanceSwipeView.attachmentBehaviour = [[UIAttachmentBehavior alloc] initWithItem:self.advanceSwipeView.circle attachedToAnchor:self.advanceSwipeView.circle.center];
                [self.advanceSwipeView.animator addBehavior:self.advanceSwipeView.attachmentBehaviour];

            } else if([sender state ] == UIGestureRecognizerStateChanged) {
                //CGPoint velocity = [gesture velocityInView:self];
                if(gesturePoint.x <= self.advanceSwipeView.bounds.size.width - circleDiameter/2.0 && gesturePoint.x >= circleDiameter/2.0) {
                    self.advanceSwipeView.attachmentBehaviour.anchorPoint = gesturePoint;
                }
            } else if([sender state ] == UIGestureRecognizerStateEnded ) {
                if(gesturePoint.x >= self.advanceSwipeView.bounds.size.width - circleDiameter/2.0 - SWIPE_VIEW_DIFFERENCE_FOR_ACCEPTANCE_OR_DENIAL) {
                    NSLog(@"Payment Accepted");
                    [self authenticateUser];
 //                   if(self.delegate) {
  //                     [self.delegate //didFinishSwipingWithStatus:YES];
            //      }
                    //Payment Accepted
                    [self.advanceSwipeView.animator removeBehavior:self.advanceSwipeView.attachmentBehaviour];
                    self.advanceSwipeView.attachmentBehaviour = nil;
                //notify the view controller to complete the transaction
                   // [self transitionToHome];
                   // [self performSegueWithIdentifier:@"Success" sender:self];
                   
                } else if(gesturePoint.x <= circleDiameter/2.0 + SWIPE_VIEW_DIFFERENCE_FOR_ACCEPTANCE_OR_DENIAL) {
                    NSLog(@"Payment Rejected");
                    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
                    [center removeDeliveredNotificationsWithIdentifiers:@[@"myNotification"]];
    //                if(self.delegate) {
    //                    [self.delegate didFinishSwipingWithStatus:NO];
    //                }
                    [self.advanceSwipeView.animator removeBehavior:self.advanceSwipeView.attachmentBehaviour];
                    self.advanceSwipeView.attachmentBehaviour = nil;
                    // Payment Rejected
                } else {
                    // we will animate the circle back to the center
                    //NSLog(@"%f %f", self.attachmentBehaviour.anchorPoint.x, self.attachmentBehaviour.anchorPoint.y);
                    [UIView animateWithDuration:1.0 animations:^() {
    //                        self.attachmentBehaviour.anchorPoint = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
                        self.advanceSwipeView.circle.center = CGPointMake(self.advanceSwipeView.bounds.size.width/2.0, self.advanceSwipeView.bounds.size.height/2.0);
                        [self.advanceSwipeView.animator removeBehavior:self.advanceSwipeView.attachmentBehaviour];
                        self.advanceSwipeView.attachmentBehaviour = nil;
                        self.advanceSwipeView.isAttachmentAllowed = false;
                        } completion:^(BOOL finished) {
                            self.advanceSwipeView.isAttachmentAllowed = true;
                        if(finished) {
                            //[dropsToRemove makeObjectsPerformSelector:@selector(removeFromSuperview)];
                        }
                    }];
                
                }
            }
        }
    }
}
- (void) notifyUser:(NSString *)msg withError:(NSString *)error {
    UIAlertController * alertvc = [UIAlertController alertControllerWithTitle:msg
                                     message:error preferredStyle:UIAlertControllerStyleAlert];
      UIAlertAction * action = [UIAlertAction actionWithTitle: @ "OK"
                                style: UIAlertActionStyleDefault handler: ^ (UIAlertAction * _Nonnull action) {
                                  NSLog(@ "OK Tapped");
                                }];
      [alertvc addAction: action];
      [self presentViewController: alertvc animated: true completion: nil];
}
- (IBAction) authenticateUser {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSLog(@"This is run on the background queue");

        dispatch_async(dispatch_get_main_queue(), ^(void) {
             //stop your HUD here
             //This is run on the main thread
            NSLog(@"This is run on the main queue, after the previous code in outer block");
            sleep(1);
            LAContext *context = [[LAContext alloc] init];
            NSError *error;
            
            if([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
                NSLog(@"Hurray");
                
                // Device can use biometric authentication
                [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"Access requiers authentication" reply:^(BOOL success, NSError * _Nullable error) {
                    dispatch_sync(dispatch_get_main_queue(), ^(void){
                        NSLog(@"Hurray");
                        NSError *err = error;
                        if(err) {
                            switch([err code]) {
                                case LAErrorSystemCancel:
                                    [self notifyUser:@"Session Cancelled" withError:[err localizedDescription]];
                                case LAErrorUserCancel:
                                    [self notifyUser:@"Please Try Again" withError:[err localizedDescription]];
                                case LAErrorUserFallback:
                                    [self notifyUser:@"Authentication" withError:@"Password Option Selected"];
                                    // Custom Code to Obtain Password Here
                                default:
                                    [self notifyUser:@"Authentication Failed" withError:[err localizedDescription]];
                            }
                        } else {
                            //[self notifyUser:@"Authentication Succesful" withError:@"You have now full access"];
                            //NSLog(@"Hurray");
                            //[self transitionToHome];
                            [self performSegueWithIdentifier:@"Success" sender:self];
                            
                            //[self transitionToHome];
                        }
                    });
                }];
            } else {
                // Device cannot use biometric authentication
                NSError *err = error;
                if(err) {
                    switch([err code]) {
                        case LAErrorBiometryNotEnrolled:
                            [self notifyUser:@"User is not enrolled" withError:[err localizedDescription]];
                        case LAErrorPasscodeNotSet:
                            [self notifyUser:@"A Passcode has not been set" withError:[err localizedDescription]];
                        case LAErrorBiometryNotAvailable:
                            [self notifyUser:@"Biometric Authentication not available" withError:[err localizedDescription]];
                        default:
                            [self notifyUser:@"Unknown Error" withError:[err localizedDescription]];
                    }
                }
            }
        });
    });
    
}

- (void)transitionToHome
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"MainInterface"
                 bundle:nil];
    UIViewController *add =
                [storyboard instantiateViewControllerWithIdentifier:@"SuccessVC"];

    [self presentViewController:add
                    animated:YES
                  completion:nil];
}
 

- (void)didFinishSwipingWithStatus:(Boolean)status {
    if (status) {
        NSLog(@"Hurray!! Payment Accepted");
    } else {
        NSLog(@"Not Hurray!! Payment Declined");
    }
}

@end

    
