//
//  advancedSwipeView.h
//  notificationContentExtension
//
//  Created by prashuk.j on 22/02/21.
//

#import <UIKit/UIKit.h>
#import "CircularUIView.h"
#import "AdvancedSwipeViewDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface advancedSwipeView : UIView
//- (void)pan:(UIPanGestureRecognizer *)gesture;
@property (strong, nonatomic) CircularUIView *circle;
@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) UIAttachmentBehavior *attachmentBehaviour;
//@property (strong, nonatomic) UICollisionBehavior *collisionBehaviour;
//@property (strong, nonatomic) UIGravityBehavior *behaviour;
@property (weak, nonatomic) id<AdvancedSwipeViewDelegate> delegate;
@property (nonatomic) BOOL isAttachmentAllowed;
@end

NS_ASSUME_NONNULL_END
