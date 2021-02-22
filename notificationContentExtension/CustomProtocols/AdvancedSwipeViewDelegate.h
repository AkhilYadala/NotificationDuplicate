//
//  AdvancedSwipeViewDelegate.h
//  swipeView
//
//  Created by prashuk.j on 22/02/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AdvancedSwipeViewDelegate <NSObject>
@required
- (void) didFinishSwipingWithStatus:(Boolean) status;
@end

NS_ASSUME_NONNULL_END
