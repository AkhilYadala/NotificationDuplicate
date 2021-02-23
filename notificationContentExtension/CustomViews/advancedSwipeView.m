//
//  advancedSwipeView.m
//  notificationContentExtension
//
//  Created by prashuk.j on 22/02/21.
//

#import "advancedSwipeView.h"
#import "CircularUIView.h"
#import "AdvancedSwipeViewDelegate.h"

#define SWIPE_VIEW_CORNER_FONT_STANDARD_HEIGHT 180.0
#define SWIPE_VIEW_ROUNDED_RECT_CORNER_RADIUS 12.0
#define SWIPE_VIEW_DIFFERENCE_BETWEEN_RECT_AND_CIRCLE 8.0
#define SWIPE_VIEW_DIFFERENCE_FOR_ACCEPTANCE_OR_DENIAL 10.0
 

//Boolean isAttachmentAllowed;

@interface advancedSwipeView() <UIDynamicAnimatorDelegate>
/*
@property (strong, nonatomic) CircularUIView *circle;
@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) UIAttachmentBehavior *attachmentBehaviour;
//@property (strong, nonatomic) UICollisionBehavior *collisionBehaviour;
//@property (strong, nonatomic) UIGravityBehavior *behaviour;
@property (weak, nonatomic) id<AdvancedSwipeViewDelegate> delegate;
 */
@end

@implementation advancedSwipeView

#pragma mark - Initialization

- (void)awakeFromNib {
    [super awakeFromNib];
    self.isAttachmentAllowed = true;
    //[self.behaviour addItem:self.circle];
}

#pragma mark - Setter and Getters

- (UIDynamicAnimator *)animator {
    if(!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
        _animator.delegate = self;
    }
    return _animator;
}

//- (UICollisionBehavior *)collisionBehaviour {
//    if(!_collisionBehaviour) {
//        _collisionBehaviour = [[UICollisionBehavior alloc] init];
//        [self.animator addBehavior:_collisionBehaviour];
//    }
//
//    return _collisionBehaviour;
//}

//- (UIGravityBehavior *)behaviour {
//    if(!_behaviour) {
//        _behaviour = [[UIGravityBehavior alloc] init];
//        _behaviour.gravityDirection = CGVectorMake(-1.0, 0.0);
//        _behaviour.magnitude = 0.01;
//        [self.animator addBehavior:_behaviour];
//    }
//
//    return _behaviour;
//}

- (CircularUIView *)circle {
    if(!_circle) {
        CGFloat circleDiameter = self.bounds.size.height - SWIPE_VIEW_DIFFERENCE_BETWEEN_RECT_AND_CIRCLE;
        //CGFloat circleDiameter = 250.0;
        _circle = [[CircularUIView alloc] initWithFrame:CGRectMake((self.bounds.size.width - circleDiameter)/2.0, (self.bounds.size.height- circleDiameter)/2.0, circleDiameter, circleDiameter)];
        [self addSubview:_circle];
        NSLog(@"%f",circleDiameter);
    }
    
    return _circle;
}

#pragma mark - Helper Functions

- (CGFloat)cornerScaleFactor {return 250/SWIPE_VIEW_CORNER_FONT_STANDARD_HEIGHT;}
- (CGFloat)cornerRadius {return SWIPE_VIEW_ROUNDED_RECT_CORNER_RADIUS * [self cornerScaleFactor];}

- (CGFloat)cornerOffSet {return [self cornerRadius]/3.0;}

#pragma mark - Drawing Functions

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.circle.backgroundColor = [UIColor whiteColor];
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
    
    [roundedRect addClip];
    
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
}

//- (void)updateCenter:(CGPoint)centerPoint {
//    self.circle = [UIBezierPath bezierPathWithArcCenter:centerPoint radius:250.0/2.0 startAngle:0 endAngle:(22*3.14)/7 clockwise:YES];
//    [self setNeedsDisplay];
//}

#pragma mark - Gesture Recognizers
/*
- (void)pan:(UIPanGestureRecognizer *)gesture {
    if(isAttachmentAllowed) {
        CGFloat circleDiameter = 250.0 - SWIPE_VIEW_DIFFERENCE_BETWEEN_RECT_AND_CIRCLE;
        CGPoint gesturePoint = [gesture locationInView:self];
        gesturePoint.y = 250.0/2.0;

        if((gesture.state == UIGestureRecognizerStateBegan) || gesture.state == UIGestureRecognizerStateChanged || gesture.state == UIGestureRecognizerStateEnded) {

            if(gesture.state == UIGestureRecognizerStateBegan) {
                self.attachmentBehaviour = [[UIAttachmentBehavior alloc] initWithItem:self.circle attachedToAnchor:self.circle.center];
                [self.animator addBehavior:self.attachmentBehaviour];

            } else if(gesture.state == UIGestureRecognizerStateChanged) {
                //CGPoint velocity = [gesture velocityInView:self];
                if(gesturePoint.x <= self.bounds.size.width - circleDiameter/2.0 && gesturePoint.x >= circleDiameter/2.0) {
                    self.attachmentBehaviour.anchorPoint = gesturePoint;
                }
            } else if(gesture.state == UIGestureRecognizerStateEnded) {
                if(gesturePoint.x >= self.bounds.size.width - circleDiameter/2.0 - SWIPE_VIEW_DIFFERENCE_FOR_ACCEPTANCE_OR_DENIAL) {
                    NSLog(@"Payment Accepted");
    //                if(self.delegate) {
    //                    [self.delegate didFinishSwipingWithStatus:YES];
    //                }
                    //Payment Accepted
                    [self.animator removeBehavior:self.attachmentBehaviour];
                    self.attachmentBehaviour = nil;
                //notify the view controller to complete the transaction
                } else if(gesturePoint.x <= circleDiameter/2.0 + SWIPE_VIEW_DIFFERENCE_FOR_ACCEPTANCE_OR_DENIAL) {
                    NSLog(@"Payment Rejected");
    //                if(self.delegate) {
    //                    [self.delegate didFinishSwipingWithStatus:NO];
    //                }
                    [self.animator removeBehavior:self.attachmentBehaviour];
                    self.attachmentBehaviour = nil;
                    // Payment Rejected
                } else {
                    // we will animate the circle back to the center
                    //NSLog(@"%f %f", self.attachmentBehaviour.anchorPoint.x, self.attachmentBehaviour.anchorPoint.y);
                    [UIView animateWithDuration:1.0 animations:^() {
    //                        self.attachmentBehaviour.anchorPoint = CGPointMake(self.bounds.size.width/2.0, 250.0/2.0);
                        self.circle.center = CGPointMake(self.bounds.size.width/2.0, 250.0/2.0);
                        [self.animator removeBehavior:self.attachmentBehaviour];
                        self.attachmentBehaviour = nil;
                        isAttachmentAllowed = false;
                        } completion:^(BOOL finished) {
                            isAttachmentAllowed = true;
                        if(finished) {
                            //[dropsToRemove makeObjectsPerformSelector:@selector(removeFromSuperview)];
                        }
                    }];
                
                }
            }
        }
    }
}
*/

@end
