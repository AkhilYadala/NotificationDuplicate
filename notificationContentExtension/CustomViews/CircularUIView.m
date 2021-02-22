//
//  CircularUIView.m
//  swipeView
//
//  Created by prashuk.j on 22/02/21.
//

#import "CircularUIView.h"

@interface CircularUIView()
@property (strong, nonatomic) UIBezierPath *circleBezierPath;
@end

@implementation CircularUIView

@synthesize circleBezierPath = _circleBezierPath;

- (UIBezierPath *)circleBezierPath {
    
    if(!_circleBezierPath) {
        _circleBezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0) radius:self.bounds.size.height/2.0 startAngle:0.0 endAngle:(22*3.14)/7 clockwise:YES];
    }
    return _circleBezierPath;
}

- (void)drawRect:(CGRect)rect {
    
    [self.circleBezierPath addClip];
    
    [[UIColor blackColor] setStroke];
    [self.circleBezierPath stroke];
    [[UIColor systemBlueColor] setFill];
    [self.circleBezierPath fill];
}

@end
