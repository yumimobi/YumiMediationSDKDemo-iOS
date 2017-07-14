//
//  YumiMediationAppViewController.m
//  YumiMediationSDKDemo
//
//  Created by ShunZhi Tang on 2017/7/13.
//  Copyright © 2017年 Zplay. All rights reserved.
//

#import "YumiMediationAppViewController.h"

@interface YumiMediationAppViewController ()

@property (weak, nonatomic) IBOutlet UIButton *yumiMediationButton;

@property (weak, nonatomic) IBOutlet UIButton *requestAdButton;

@property (weak, nonatomic) IBOutlet UIButton *removeBannerButton;
@property (weak, nonatomic) IBOutlet UIButton *showAdButton;

@property (weak, nonatomic) IBOutlet UISegmentedControl *selectAdType;

@property (weak, nonatomic) IBOutlet UITextView *showLogConsole;

@property (weak, nonatomic) IBOutlet UIButton *clearLogButton;

@property (weak, nonatomic) IBOutlet UIButton *showLogAtBottomButton;

@property (weak, nonatomic) IBOutlet UIButton *showLogTopButton;

@end

@implementation YumiMediationAppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.yumiMediationButton.layer.borderWidth = 1;
    
    self.yumiMediationButton.layer.borderColor  = [UIColor whiteColor].CGColor;
}

- (IBAction)clickMetation:(UIButton *)sender {
    
}

@end
