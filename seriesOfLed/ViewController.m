//
//  ViewController.m
//  seriesOfLed
//
//  Created by admin on 7/20/15.
//  Copyright (c) 2015 hoangdangtrung. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    CGFloat _margin; // > ruby radius
    int _numberOfRuby;
    NSTimer *_timer;
    int _lastOnLed;
    int _lastOnLed1;
    int _lastOnLed2;
    //    CGFloat _space; // > ruby diameter
    //    CGFloat _rubyDiameter;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _margin = 40;
    //    _rubyDiameter = 24;
    _numberOfRuby = 11;
    [self drawSeriesOfRuby:_numberOfRuby];
//    _lastOnLed = -1;
//         _lastOnLed = _numberOfRuby;
    _lastOnLed1 = -1;
    _lastOnLed2 = _numberOfRuby;
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                              target:self
                                            selector:@selector(from2SidesToCenter)
                                            userInfo:nil
                                             repeats:YES];
    
    //    [self numberOfRubyvsSpace];
    //    [self checkSizeOfiPhone];
    //    [self rubyCGPointMakeX:320/2 rubyCGPointMakeY:568/3 rubyTag:1];
    
}
//=============== Turn on Led from center to 2 sides =====================
- (void) fromCenterTo2Sides { // _lastOnLed = -1
    if ((_lastOnLed1 != -1) &&(_lastOnLed2 != _numberOfRuby)) {
        [self turnOFFLed:_lastOnLed1];
        [self turnOFFLed:_lastOnLed2];
    }
    if ((_lastOnLed1 != -1)&&(_lastOnLed2 != _numberOfRuby)) {
        _lastOnLed1 --;
        _lastOnLed2 ++;
    }
    
    [self turnONLed:_lastOnLed1];
    [self turnONLed:_lastOnLed2];
    
    if ((_lastOnLed1 == 0)&&(_lastOnLed2==_numberOfRuby-1)) {
        [_timer invalidate];
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                  target:self
                                                selector:@selector(from2SidesToCenter)
                                                userInfo:nil
                                                 repeats:YES];
        
    }
    
    
}
//========== Turn on led from 2 sides to center =====================
- (void) from2SidesToCenter {
    if ((_lastOnLed1 != -1)&&((_lastOnLed2 != _numberOfRuby))) {
        [self turnOFFLed:_lastOnLed1];
        [self turnOFFLed:_lastOnLed2];
    }
    
    if ((_lastOnLed1 != (_numberOfRuby-1)/2)&&(_lastOnLed2 != (_numberOfRuby-1)/2)) {
        _lastOnLed1 ++;
        _lastOnLed2 --;
    }
    [self turnONLed:_lastOnLed1];
    [self turnONLed:_lastOnLed2];
    
    if ((_lastOnLed1 == (_numberOfRuby-1)/2)&&(_lastOnLed2==(_numberOfRuby-1)/2)) {
        [_timer invalidate];
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                  target:self
                                                selector:@selector(fromCenterTo2Sides)
                                                userInfo:nil
                                                 repeats:YES];
        

    }
    
    
    

}
//    if (_lastOnLed1 == _numberOfRuby) {
//        [_timer invalidate];
//        _timer = [NSTimer scheduledTimerWithTimeInterval:0.5
//                                                  target:self
//                                                selector:@selector(fromRightToLeft)
//                                                userInfo:nil
//                                                 repeats:1];
//    }
//}

//=============== Turn on Led from Right to Left =====================
//- (void) fromRightToLeft { // _lastOnLed = _numberOfRuby
//    
//    if (_lastOnLed2 != _numberOfRuby) {
//        [self turnOFFLed:_lastOnLed];
//    }
//    if (_lastOnLed2 != _numberOfRuby) {
//        [self turnONLed:_lastOnLed2];
//        _lastOnLed2 --;
//    }
////    [self turnONLed:_lastOnLed];
//    if (_lastOnLed2 == 0) {
////        [_timer invalidate];
//        _timer = [NSTimer scheduledTimerWithTimeInterval:0.5
//                                                  target:self
//                                                selector:@selector(fromLeftToRight)
//                                                userInfo:nil
//                                                 repeats:1];
//        
//    }
//}




- (void) turnONLed: (int) index {
    UIView *view = [self.view viewWithTag:index + 100];
    if (view && [view isMemberOfClass:[UIImageView class]]) {
        UIImageView *ruby = (UIImageView *)view;
        ruby.image = [UIImage imageNamed:@"rubyRed"];
    }
}


- (void) turnOFFLed: (int) index {
    UIView *view = [self.view viewWithTag:index + 100];
    if (view && [view isMemberOfClass:[UIImageView class]]) {
        UIImageView *ruby = (UIImageView *) view;
        ruby.image = [UIImage imageNamed:@"rubyGrey"];
    }
}


// Put a Image to a determined Position =========================
-(void) rubyCGPointMakeX: (CGFloat) x
        rubyCGPointMakeY: (CGFloat) y
                 rubyTag:(CGFloat) tag;
{
    UIImageView *ruby = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"rubyGrey"]];
    ruby.center = CGPointMake(x, y);
    ruby.tag = tag;
    [self.view addSubview:ruby];
    //    NSLog(@"w = %f, h= %f",ruby.bounds.size.width,ruby.bounds.size.height);
}

// Distance between Rubys in a row =========================
-(CGFloat)spaceBetweenRubyCenterByRow: (int) n {
    return (self.view.bounds.size.width - 2* _margin)/(n-1);
}

//-(void)numberOfRubyvsSpace{
//    bool stop = false;
//    int n =3;
//    while (!stop) {
//        CGFloat space = [self spaceBetweenRubyCenter: n];
//        if (space< _rubyDiameter) {
//            stop = true;
//        }else {
//            NSLog(@"Number of Ruby %d, space between ruby center %3.0f",n,space);
//        }
//        n++;
//    }
//}

// ======================   Draw Series of Ruby   ======================
-(void)drawSeriesOfRuby: (int)numberRubys{
    CGFloat spaceRow = [self spaceBetweenRubyCenterByRow:numberRubys];
    for (int i=0; i<numberRubys; i++) {
        [self rubyCGPointMakeX:_margin+ i*spaceRow
              rubyCGPointMakeY:self.view.bounds.size.height/3
                       rubyTag:i+100];}
}
//-(void) checkSizeOfiPhone{
//    CGSize size = self.view.bounds.size;
//    NSLog(@"w = %f, h = %f",size.width,size.height);
//}

@end
