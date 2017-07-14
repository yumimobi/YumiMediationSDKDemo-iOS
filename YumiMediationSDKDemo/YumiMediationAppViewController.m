//
//  YumiMediationAppViewController.m
//  YumiMediationSDKDemo
//
//  Created by ShunZhi Tang on 2017/7/13.
//  Copyright © 2017年 Zplay. All rights reserved.
//

#import "YumiMediationAppViewController.h"
#import <YumiMediationSDK/YumiMediationBannerView.h>

static NSString *const yumiID = @"3f521f0914fdf691bd23bf85a8fd3c3a";

@interface YumiMediationAppViewController () <YumiMediationBannerViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *yumiMediationButton;
@property (weak, nonatomic) IBOutlet UIButton *requestAdButton;
@property (weak, nonatomic) IBOutlet UIButton *removeBannerButton;
@property (weak, nonatomic) IBOutlet UIButton *showAdButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *selectAdType;
@property (weak, nonatomic) IBOutlet UITextView *showLogConsole;
@property (weak, nonatomic) IBOutlet UIButton *clearLogButton;
@property (weak, nonatomic) IBOutlet UIButton *showLogAtBottomButton;
@property (weak, nonatomic) IBOutlet UIButton *showLogTopButton;

@property (nonatomic) YumiMediationBannerView  *bannerView;
@property (nonatomic) NSString  *allLog;

@end

@implementation YumiMediationAppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.allLog = @"";
}

#pragma mark: - private method
- (void)showLogConsoleWith:(NSString *)log{
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formateDate = [[NSDateFormatter alloc] init];
    [formateDate setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
     NSString *dataString = [formateDate stringFromDate:date];
    
    NSString *formateLog =[NSString stringWithFormat:@"%@ : %@ \n" ,dataString ,log];
    self.allLog = [self.allLog stringByAppendingString:formateLog];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.showLogConsole.text = self.allLog;
    });
    
}

- (IBAction)clickMetation:(UIButton *)sender {
    
}
- (IBAction)clickRequestAd:(UIButton *)sender {
    
    switch (self.selectAdType.selectedSegmentIndex) {
        case 0:
            [self showLogConsoleWith:[NSString stringWithFormat:@"initialiel   banner ad yumiID : %@",yumiID]];
            [self.bannerView loadAd];
            [self showLogConsoleWith:@"start request banner ad"];
            [self.view addSubview:self.bannerView];
            [self.view bringSubviewToFront:self.bannerView];
            
            break;
            
        default:
            break;
    }
}
- (IBAction)clickRemoveBanner:(UIButton *)sender {
    switch (self.selectAdType.selectedSegmentIndex) {
        case 0:
            if (self.bannerView) {
                [self.bannerView removeFromSuperview];
                self.bannerView = nil;
                [self showLogConsoleWith:@"remove  banner ad"];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark: getter
- (YumiMediationBannerView *)bannerView{
    if (!_bannerView) {
        _bannerView = [[YumiMediationBannerView alloc] initWithYumiID:yumiID channelID:@"" versionID:@"" position:YumiMediationBannerPositionBottom rootViewController:self];
        _bannerView.delegate = self;
    }
    return _bannerView;
}

#pragma mark: - YumiMediationBannerViewDelegate
- (void)yumiMediationBannerViewDidLoad:(YumiMediationBannerView *)adView{
    [self showLogConsoleWith:@"banner view did load"];
}

- (void)yumiMediationBannerView:(YumiMediationBannerView *)adView didFailWithError:(YumiMediationError *)error{
    [self showLogConsoleWith:[NSString stringWithFormat:@"banner view did fail ,error: %@", [error localizedDescription]]];
}

- (void)yumiMediationBannerViewDidClick:(YumiMediationBannerView *)adView{
    [self showLogConsoleWith:@"banner view did click"];
}

@end
