//
//  YumiMobiAppViewController.m
//  YumiMediationSDKDemo
//
//  Created by ShunZhi Tang on 2017/7/13.
//  Copyright © 2017年 Zplay. All rights reserved.
//

#import "YumiMobiAppViewController.h"

@interface YumiMobiAppViewController ()

@property (weak, nonatomic) IBOutlet UIButton *yumiMediationButton;

@end

@implementation YumiMobiAppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.yumiMediationButton.layer.borderWidth = 1;
    
    self.yumiMediationButton.layer.borderColor  = [UIColor whiteColor].CGColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clickMetation:(UIButton *)sender {
    
}

@end
