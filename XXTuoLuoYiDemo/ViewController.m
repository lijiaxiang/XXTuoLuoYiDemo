//
//  ViewController.m
//  XXTuoLuoYiDemo
//
//  Created by XXViper on 16/11/10.
//  Copyright © 2016年 XXViper. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *zThetaLable;
@property (weak, nonatomic) IBOutlet UILabel *xyThetaLable;
@property (weak, nonatomic) IBOutlet UIView *rollView;
@property (nonatomic, strong) CMMotionManager *motionManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CMMotionManager *motionManager = [[CMMotionManager alloc] init];
    motionManager.accelerometerUpdateInterval = 0.025;
    self.motionManager = motionManager;
    //1. 玩转陀螺仪
    [motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
        
        double gravityX = motion.gravity.x;
        double gravityY = motion.gravity.y;
        double gravityZ = motion.gravity.z;
        double xzTheta = (atan2(gravityX, gravityZ) + M_PI) / M_PI * 180.0;
        double yzTheta = (atan2(gravityY, gravityZ) + M_PI) / M_PI * 180.0;
        self.zThetaLable.text = [NSString stringWithFormat:@"%f", atan2(gravityX, gravityZ)];
        self.xyThetaLable.text = [NSString stringWithFormat:@"%f", atan2(gravityY, gravityZ)];
        //实现view旋转
        CALayer *layer = self.rollView.layer;
        CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
        rotationAndPerspectiveTransform.m34 = 1.0 / 1000;
        rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, xzTheta / 360.0 * 2 * M_PI, 0.0f, 1.0f, 0.0f);
        rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, yzTheta / 360.0 * 2 * M_PI, 1.0f, 0.0f, 0.0f);
        layer.transform = rotationAndPerspectiveTransform;
}];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
