//
//  ZHJCarAnimationView.m
//  CarAnimationDemo
//
//  Created by Sword on 02/12/2016.
//  Copyright © 2016 Baidu. All rights reserved.
//

#import "ZHJCarAnimationView.h"
#import "UIView+Sizes.h"

@interface ZHJCarAnimationView()

@property (nonatomic, strong) UIImageView *carBodayImageView;
@property (nonatomic, strong) UIImageView *carFrontWheelImageView;
@property (nonatomic, strong) UIImageView *carBackWheelImageView;
@property (nonatomic, strong) UIImageView *carFrontWheelLineImageView;
@property (nonatomic, strong) UIImageView *carBackWheelLineImageView;
@property (nonatomic, strong) UIImageView *carexhaustImageView;

@property (nonatomic, strong) UIView *roadBoundView;
@property (nonatomic, strong) UIView *roadContentView;

@end

@implementation ZHJCarAnimationView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configView];
    }
    return self;
}

- (void)startAnimation {
    
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.values = @[@(1.0), @(1.1), @(1.15), @(1.1), @(1.0)];;
    scaleAnimation.repeatCount = HUGE_VALF;
    scaleAnimation.duration = 0.5;
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = @(-M_PI);
    rotationAnimation.repeatCount = HUGE_VALF;
    rotationAnimation.duration = 1.0;
    rotationAnimation.cumulative = TRUE;
    
    CAKeyframeAnimation *carPositionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
    carPositionAnimation.values = @[@(_carBodayImageView.centerY), @(_carBodayImageView.centerY + 1), @(_carBodayImageView.centerY + 2), @(_carBodayImageView.centerY + 1), @(_carBodayImageView.centerY)];
    carPositionAnimation.repeatCount = HUGE_VALF;
    carPositionAnimation.duration = 0.5;
    
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    positionAnimation.values = @[@(0), @(_roadBoundView.width)];
    positionAnimation.repeatCount = HUGE_VALF;
    positionAnimation.duration = 2;
    positionAnimation.fillMode = kCAFillModeForwards;
    positionAnimation.removedOnCompletion = FALSE;
    
    [_carFrontWheelLineImageView.layer addAnimation:rotationAnimation forKey:@"car.wheel.rotate"];
    [_carBackWheelLineImageView.layer addAnimation:rotationAnimation forKey:@"car.wheel.rotate"];
    [_carBodayImageView.layer addAnimation:carPositionAnimation forKey:@"car.boday.position.y"];
    [_carexhaustImageView.layer addAnimation:scaleAnimation forKey:@"car.exhaust.scale"];
    [_roadContentView.layer addAnimation:positionAnimation forKey:@"car.boday.position.x"];
}

- (void)stopAnimation {
    [_carFrontWheelLineImageView.layer removeAnimationForKey:@"car.wheel.rotate"];
    [_carBackWheelLineImageView.layer removeAnimationForKey:@"car.wheel.rotate"];
    [_carBodayImageView.layer removeAnimationForKey:@"car.boday.position.y"];
    [_carexhaustImageView.layer removeAnimationForKey:@"car.exhaust.scale"];
    [_roadContentView.layer removeAnimationForKey:@"car.boday.position.x"];
}

- (void)configView {
    UIImage *roadImage = [UIImage imageNamed:@"rentcar_loading_road"];
    
    _roadBoundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, roadImage.size.width, roadImage.size.height)];
    _roadBoundView.clipsToBounds = TRUE;
    [self addSubview:_roadBoundView];
    
    _roadContentView = [[UIView alloc] initWithFrame:CGRectMake(-roadImage.size.width, 0, 2 * roadImage.size.width, roadImage.size.height)];
    
    UIImageView *roadImageView1 = [[UIImageView alloc] initWithImage:roadImage];
    UIImageView *roadImageView2 = [[UIImageView alloc] initWithImage:roadImage];
    
    roadImageView2.left = 0;
    roadImageView2.top = 0;
    roadImageView1.left = roadImage.size.width;
    roadImageView1.top = 0;
    
    [_roadContentView addSubview:roadImageView2];
    [_roadContentView addSubview:roadImageView1];
    
    [_roadBoundView addSubview:_roadContentView];
    
    _carBodayImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rentcar_loading_car"]];
    [self addSubview:_carBodayImageView];
    
    _carFrontWheelImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rentcar_loading_chelun"]];
    [self addSubview:_carFrontWheelImageView];
    
    _carBackWheelImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rentcar_loading_chelun"]];
    [self addSubview:_carBackWheelImageView];
    
    _carFrontWheelLineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rentcar_loading_chelunxin"]];
    [self addSubview:_carFrontWheelLineImageView];
    
    _carBackWheelLineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rentcar_loading_chelunxin"]];
    [self addSubview:_carBackWheelLineImageView];
    
    _carexhaustImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rentcar_weiqi"]];
    [self addSubview:_carexhaustImageView];
    
    CGFloat marginY = (CGRectGetHeight(self.bounds) - CGRectGetHeight(_carBodayImageView.bounds) - roadImage.size.height - CGRectGetHeight(_carFrontWheelImageView.bounds) / 2.0) / 2.0;
    
    _carBodayImageView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2, marginY);
    
    _carFrontWheelImageView.centerY = _carBodayImageView.bottom;
    _carFrontWheelImageView.centerX = _carBodayImageView.left + _carFrontWheelImageView.width + 2;
    
    _carBackWheelImageView.centerY = _carBodayImageView.bottom;
    _carBackWheelImageView.centerX = _carBodayImageView.right - _carFrontWheelImageView.width;
    
    _carFrontWheelLineImageView.center = _carFrontWheelImageView.center;
    _carFrontWheelLineImageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    _carBackWheelLineImageView.center = _carBackWheelImageView.center;
    _carBackWheelLineImageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    
    _roadBoundView.top = _carFrontWheelImageView.bottom;
    _roadBoundView.centerX = self.width / 2;
    
    _carexhaustImageView.bottom = _carBodayImageView.bottom - 2;
    _carexhaustImageView.left = _carBodayImageView.right - 2;
}

@end
