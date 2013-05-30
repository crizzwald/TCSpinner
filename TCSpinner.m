//
//  Spinner.m
//  LoaderAnimation
//
//  Created by Todd Crown on 4/16/13.
//  Copyright (c) 2013 Todd Crown. All rights reserved.
//
/*
 Copyright (c) 2013 Todd Crown <toddcrown@gmail.com>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is furnished
 to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

#import "TCSpinner.h"
#import <QuartzCore/QuartzCore.h>

@interface TCSpinner ()
@property (strong, nonatomic) CALayer *circleTL;
@property (strong, nonatomic) CALayer *circleTR;
@property (strong, nonatomic) CALayer *circleBR;
@property (strong, nonatomic) CALayer *circleBL;
@property (nonatomic) CGPoint circleTLStartPoint;
@property (nonatomic) CGPoint circleTRStartPoint;
@property (nonatomic) CGPoint circleBRStartPoint;
@property (nonatomic) CGPoint circleBLStartPoint;
@property (nonatomic) BOOL isAnimating;
@end

@implementation TCSpinner
NSString * const OPACITY_KEY_PATH = @"opacity";
NSString * const POSITION_KEY_PATH = @"position";

NSString * const NAME_KEY = @"Name";
NSString * const TL_FADEIN_ANIMATION_KEY = @"TL_FadeIn_Animation";
NSString * const TR_FADEIN_ANIMATION_KEY = @"TR_FadeIn_Animation";
NSString * const BR_FADEIN_ANIMATION_KEY = @"BR_FadeIn_Animation";
NSString * const BL_FADEIN_ANIMATION_KEY = @"BL_FadeIn_Animation";

NSString * const TL_FADEOUT_ANIMATION_KEY = @"TL_FadeOut_Animation";
NSString * const TR_FADEOUT_ANIMATION_KEY = @"TR_FadeOut_Animation";
NSString * const BR_FADEOUT_ANIMATION_KEY = @"BR_FadeOut_Animation";
NSString * const BL_FADEOUT_ANIMATION_KEY = @"BL_FadeOut_Animation";


NSString * const TL_ANIMATION_KEY = @"TL_Animation";
NSString * const TR_ANIMATION_KEY = @"TR_Animation";
NSString * const BR_ANIMATION_KEY = @"BR_Animation";
NSString * const BL_ANIMATION_KEY = @"BL_Animation";


#pragma mark Properties
@synthesize color = _color;
-(void)setColor:(UIColor *)color
{
    [self.layer.sublayers enumerateObjectsUsingBlock:^(CALayer *layer, NSUInteger idx, BOOL *stop) {
        layer.backgroundColor = color.CGColor;
    }];
}
- (id)color
{
    if(!_color)
        _color = [UIColor colorWithRed:132.0/255 green:175.0/255 blue:86.0/255 alpha:1.0];
    return _color;
}

@synthesize fadeSpeed = _fadeSpeed;
- (float)fadeSpeed
{
    if(!_fadeSpeed)
        _fadeSpeed = 1;
    return _fadeSpeed;
}

@synthesize timingFunction = _timingFunction;
- (id)timingFunction
{
    if(!_timingFunction)
        _timingFunction = [CAMediaTimingFunction functionWithControlPoints:.5 :1.8 :1 :1];
    return _timingFunction;
}

@synthesize spinnerSpeed = _spinnerSpeed;
- (float)spinnerSpeed
{
    if(!_spinnerSpeed)
        _spinnerSpeed = 0.5;
    return _spinnerSpeed;
}

@synthesize repeatCount = _repeatCount;
- (int)repeatCount
{
    if(!_repeatCount)
        _repeatCount = 0;
    return _repeatCount;
}

#pragma mark Initialization

- (id)init
{
    return [self initWithFrame:CGRectMake(0, 0, 60, 60)];
}

- (id)initWithFrame:(CGRect)frame
{
    float circleSize = frame.size.height < frame.size.width ? frame.size.height/3 : frame.size.width/3;

    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width + circleSize, frame.size.height + circleSize)];
    
    if(self)
    {
        self.circleTLStartPoint = CGPointMake(self.center.x - (circleSize/1.3), self.center.y - (circleSize/1.3));
        self.circleTRStartPoint = CGPointMake(self.center.x + (circleSize/1.3), self.center.y - (circleSize/1.3));
        self.circleBRStartPoint = CGPointMake(self.center.x + (circleSize/1.3), self.center.y + (circleSize/1.3));
        self.circleBLStartPoint = CGPointMake(self.center.x - (circleSize/1.3), self.center.y + (circleSize/1.3));
        
        self.circleTL = [self circleLayer:self.circleTLStartPoint size:circleSize];
        self.circleTR = [self circleLayer:self.circleTRStartPoint size:circleSize];
        self.circleBR = [self circleLayer:self.circleBRStartPoint size:circleSize];
        self.circleBL = [self circleLayer:self.circleBLStartPoint size:circleSize];
        
        [self.layer addSublayer:self.circleTL];
        [self.layer addSublayer:self.circleTR];
        [self.layer addSublayer:self.circleBR];
        [self.layer addSublayer:self.circleBL];
    }
    return self;
}

- (id)initWithColor:(UIColor *)color
              frame:(CGRect)frame
{
    self.color = color;
    return [self initWithFrame:frame];
}

#pragma mark CallBacks
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSString* name = [anim valueForKey: NAME_KEY];
    
    //remove fade in animations
    if ([name isEqualToString: TL_FADEIN_ANIMATION_KEY])
    {
        [self.circleTL removeAnimationForKey:TL_FADEIN_ANIMATION_KEY];
        [self.circleTL setOpacity:1.0];
    }
    
    if ([name isEqualToString: TR_FADEIN_ANIMATION_KEY])
    {
        [self.circleTR removeAnimationForKey:TR_FADEIN_ANIMATION_KEY];
        [self.circleTR setOpacity:1.0];
    }
    
    if ([name isEqualToString: BR_FADEIN_ANIMATION_KEY])
    {
        [self.circleBR removeAnimationForKey:BR_FADEIN_ANIMATION_KEY];
        [self.circleBR setOpacity:1.0];
    }
    
    if ([name isEqualToString: BL_FADEIN_ANIMATION_KEY])
    {
        [self.circleBL removeAnimationForKey:BL_FADEIN_ANIMATION_KEY];
        [self.circleBL setOpacity:1.0];
    }
    
    //remove fade out animations
    if ([name isEqualToString: TL_FADEOUT_ANIMATION_KEY])
    {
        [self.circleTL removeAnimationForKey:TL_FADEOUT_ANIMATION_KEY];
        [self.circleTL setOpacity:0.0];
    }
    
    if ([name isEqualToString: TR_FADEOUT_ANIMATION_KEY])
    {
        [self.circleTR removeAnimationForKey:TR_FADEOUT_ANIMATION_KEY];
        [self.circleTR setOpacity:0.0];
    }
    
    if ([name isEqualToString: BR_FADEOUT_ANIMATION_KEY])
    {
        [self.circleBR removeAnimationForKey:BR_FADEOUT_ANIMATION_KEY];
        [self.circleBR setOpacity:0.0];
    }
    
    if ([name isEqualToString: BL_FADEOUT_ANIMATION_KEY])
    {
        [self.circleBL removeAnimationForKey:BL_FADEOUT_ANIMATION_KEY];
        [self.circleBL setOpacity:0.0];
    }
    
    //stop the circles from animating
    if([name isEqualToString:TL_ANIMATION_KEY])
        [self stopAnimating];
    
    if([name isEqualToString:TR_ANIMATION_KEY])
        [self stopAnimating];
    
    if([name isEqualToString:BR_ANIMATION_KEY])
        [self stopAnimating];
    
    if([name isEqualToString:BL_ANIMATION_KEY])
        [self stopAnimating];
}

#pragma mark Controls
- (void)startAnimating
{
    if(!self.isAnimating)
    {
        //it's now animating
        self.isAnimating = YES;
        
        //fresh on each start.
        [self removeAllAnimations];
        
        if(self.fadeIn)
        {   
            //add fadein
            CABasicAnimation *tLFadeIn = [self opacityAnimation:0.0 toValue:1.0];
            [tLFadeIn setValue:TL_FADEIN_ANIMATION_KEY forKey:NAME_KEY];
            [self.circleTL addAnimation:tLFadeIn forKey:TL_FADEIN_ANIMATION_KEY];
            
            CABasicAnimation *tRFadeIn = [self opacityAnimation:0.0 toValue:1.0];
            [tRFadeIn setValue:TR_FADEIN_ANIMATION_KEY forKey:NAME_KEY];
            [self.circleTR addAnimation:tRFadeIn forKey:TR_FADEIN_ANIMATION_KEY];
            
            CABasicAnimation *bRFadeIn = [self opacityAnimation:0.0 toValue:1.0];
            [bRFadeIn setValue:BR_FADEIN_ANIMATION_KEY forKey:NAME_KEY];
            [self.circleBR addAnimation:bRFadeIn forKey:BR_FADEIN_ANIMATION_KEY];
            
            CABasicAnimation *bLFadeIn = [self opacityAnimation:0.0 toValue:1.0];
            [bLFadeIn setValue:BL_FADEIN_ANIMATION_KEY forKey:NAME_KEY];
            [self.circleBL addAnimation:bLFadeIn forKey:BL_FADEIN_ANIMATION_KEY];
        }
        
        CABasicAnimation *tlA = [self positionAnimation:self.circleTLStartPoint endPoint:self.circleTRStartPoint];
        [tlA setValue:TL_ANIMATION_KEY forKey:NAME_KEY];
        [self.circleTL addAnimation:tlA forKey:TL_ANIMATION_KEY];
        
        CABasicAnimation *trA = [self positionAnimation:self.circleTRStartPoint endPoint:self.circleBRStartPoint];
        [trA setValue:TR_ANIMATION_KEY forKey:NAME_KEY];
        [self.circleTR addAnimation:trA forKey:TR_ANIMATION_KEY];
        
        CABasicAnimation *brA = [self positionAnimation:self.circleBRStartPoint endPoint:self.circleBLStartPoint];
        [brA setValue:BR_ANIMATION_KEY forKey:NAME_KEY];
        [self.circleBR addAnimation:brA forKey:BR_ANIMATION_KEY];
        
        CABasicAnimation *blA = [self positionAnimation:self.circleBLStartPoint endPoint:self.circleTLStartPoint];
        [blA setValue:BL_ANIMATION_KEY forKey:NAME_KEY];
        [self.circleBL addAnimation:blA forKey:BL_ANIMATION_KEY];
        
    }
}

-(void)stopAnimating
{
    if(self.isAnimating)
    {
        //it's done animating
        self.isAnimating = NO;
        
        if(self.fadeOut)
        {
            //add fadeout
            CABasicAnimation *tLFadeOut = [self opacityAnimation:1.0 toValue:0.0];
            [tLFadeOut setValue:TL_FADEOUT_ANIMATION_KEY forKey:NAME_KEY];
            [self.circleTL addAnimation:tLFadeOut forKey:TL_FADEOUT_ANIMATION_KEY];
            
            CABasicAnimation *tRFadeOut = [self opacityAnimation:1.0 toValue:0.0];
            [tRFadeOut setValue:TR_FADEOUT_ANIMATION_KEY forKey:NAME_KEY];
            [self.circleTR addAnimation:tRFadeOut forKey:TR_FADEOUT_ANIMATION_KEY];
            
            CABasicAnimation *bRFadeOut = [self opacityAnimation:1.0 toValue:0.0];
            [bRFadeOut setValue:BR_FADEOUT_ANIMATION_KEY forKey:NAME_KEY];
            [self.circleBR addAnimation:bRFadeOut forKey:BR_FADEOUT_ANIMATION_KEY];
            
            CABasicAnimation *bLFadeOut = [self opacityAnimation:1.0 toValue:0.0];
            [bLFadeOut setValue:BL_FADEOUT_ANIMATION_KEY forKey:NAME_KEY];
            [self.circleBL addAnimation:bLFadeOut forKey:BL_FADEOUT_ANIMATION_KEY];
        }
        else
            [self removeAllAnimations];
    }
}

#pragma mark Animations
- (CABasicAnimation *)positionAnimation:(CGPoint)startPoint
                            endPoint:(CGPoint)endPoint
{
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:POSITION_KEY_PATH];
    anim.fromValue = [NSValue valueWithCGPoint:startPoint];
    anim.toValue = [NSValue valueWithCGPoint:endPoint];
    anim.removedOnCompletion = NO;
    [anim setFillMode:kCAFillModeForwards];
    [anim setDuration:self.spinnerSpeed];
    [anim setTimingFunction:self.timingFunction];
    //anim.repeatDuration = HUGE_VALF;
    anim.repeatCount = self.repeatCount;
    anim.delegate = self;
    return anim;
}

-(CABasicAnimation *)opacityAnimation:(float)fromValue toValue:(float)toValue
{
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:OPACITY_KEY_PATH];
    anim.fromValue = [NSNumber numberWithFloat:fromValue];
    anim.toValue = [NSNumber numberWithFloat:toValue];
    anim.removedOnCompletion = NO;
    [anim setFillMode:kCAFillModeForwards];
    anim.duration = self.fadeSpeed;
    anim.delegate = self;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    return anim;
}

#pragma mark Helpers
- (void)removeAllAnimations
{
    [self.circleTL removeAllAnimations];
    [self.circleTR removeAllAnimations];
    [self.circleBR removeAllAnimations];
    [self.circleBL removeAllAnimations];
}

- (CALayer *)circleLayer:(CGPoint)startPoint
                    size:(float)size
{
    CALayer *circle = [CALayer layer];
    circle.bounds = CGRectMake(0, 0, size, size);
    circle.cornerRadius = size/2;
    circle.backgroundColor = self.color.CGColor;
    circle.position = startPoint;
    return circle;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
