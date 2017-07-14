//
//  YumiMediationAppViewController.m
//  YumiMediationSDKDemo
//
//  Created by ShunZhi Tang on 2017/7/13.
//  Copyright © 2017年 Zplay. All rights reserved.
//

#import "YumiMediationAppViewController.h"
#import <YumiMediationSDK/YumiMediationBannerView.h>
#import <YumiMediationSDK/YumiTest.h>

typedef NS_ENUM(NSUInteger ,YumiMediationAdLogType) {
    YumiMediationAdLogTypeBanner,
    YumiMediationAdLogTypeInterstitial,
    YumiMediationAdLogTypeVideo
};

static NSString *const yumiID = @"3f521f0914fdf691bd23bf85a8fd3c3a";

@interface YumiMediationAppViewController () <YumiMediationBannerViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *yumiMediationButton;
@property (weak, nonatomic) IBOutlet UIButton *requestAdButton;
@property (weak, nonatomic) IBOutlet UIButton *checkVideoButton;
@property (weak, nonatomic) IBOutlet UIButton *presentOrCloseAdButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *selectAdType;
@property (weak, nonatomic) IBOutlet UITextView *showLogConsole;
@property (weak, nonatomic) IBOutlet UIButton *clearLogButton;
@property (weak, nonatomic) IBOutlet UIButton *showLogAtBottomButton;
@property (weak, nonatomic) IBOutlet UIButton *showLogTopButton;

@property (nonatomic) YumiMediationBannerView  *bannerView;
@property (nonatomic) NSString  *bannerAdLog;
@property (nonatomic) NSString  *interstitialAdLog;
@property (nonatomic) NSString  *videoAdLog;
@property (nonatomic ,assign)YumiMediationAdLogType adType;

@end

@implementation YumiMediationAppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // initialize global log
    self.bannerAdLog = @"";
    self.interstitialAdLog = @"";
    self.videoAdLog = @"";
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    // select test
    [self implementTestFeature];
}

#pragma mark: - private method
- (void)showLogConsoleWith:(NSString *)log adLogType:(YumiMediationAdLogType)adLogType{
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formateDate = [[NSDateFormatter alloc] init];
    [formateDate setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
     NSString *dataString = [formateDate stringFromDate:date];
    
    NSString *formateLog =[NSString stringWithFormat:@"%@ : %@ \n" ,dataString ,log];
    NSString *adLog = @"";
    switch (adLogType) {
        case YumiMediationAdLogTypeBanner:
            self.bannerAdLog =  [self.bannerAdLog stringByAppendingString:formateLog];
            adLog = self.bannerAdLog;
            break;
        case YumiMediationAdLogTypeInterstitial:
            self.interstitialAdLog =  [self.interstitialAdLog stringByAppendingString:formateLog];
            adLog = self.interstitialAdLog;
            break;
        case YumiMediationAdLogTypeVideo:
            self.videoAdLog =  [self.videoAdLog stringByAppendingString:formateLog];
            adLog = self.videoAdLog;
            break;
            
        default:
            break;
    }
    
    if (self.adType != adLogType) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        self.showLogConsole.text = adLog;
    });
    
}

- (void)implementTestFeature {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择测试环境"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction *_Nonnull action){
                                            }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction *_Nonnull action) {
                                                [YumiTest enableTestMode];
                                            }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)clearLogConsole{
    switch (self.adType) {
        case YumiMediationAdLogTypeBanner:
            self.bannerAdLog = @"";
            break;
        case YumiMediationAdLogTypeInterstitial:
            self.interstitialAdLog = @"";
            break;
        case YumiMediationAdLogTypeVideo:
            self.videoAdLog = @"";
            break;
            
        default:
            break;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.showLogConsole.text = @"";
    });
    
}

- (IBAction)clickMetation:(UIButton *)sender {
    
}
- (IBAction)clickRequestAd:(UIButton *)sender {
    
    switch (self.selectAdType.selectedSegmentIndex) {
        case 0:
            [self showLogConsoleWith:[NSString stringWithFormat:@"initialize   banner ad yumiID : %@",yumiID] adLogType:YumiMediationAdLogTypeBanner];
            [self.bannerView loadAd];
            [self showLogConsoleWith:@"start request banner ad" adLogType:YumiMediationAdLogTypeBanner];
            [self.view addSubview:self.bannerView];
            [self.view bringSubviewToFront:self.bannerView];
            
            break;
            
        default:
            break;
    }
}
- (IBAction)clickPresentOrCloseAdButton:(UIButton *)sender {
    switch (self.selectAdType.selectedSegmentIndex) {
        case 0:
            if (self.bannerView) {
                [self.bannerView removeFromSuperview];
                self.bannerView = nil;
                [self showLogConsoleWith:@"remove  banner ad" adLogType:YumiMediationAdLogTypeBanner];
        }
            break;
            
        default:
            break;
    }
}
- (IBAction)clickSegmentControl:(UISegmentedControl *)sender {
    
    // reset button style
    switch (sender.selectedSegmentIndex) {
        case 0:
        {
            [self.requestAdButton setTitle:@"Show banner" forState:UIControlStateNormal];
            [self.presentOrCloseAdButton setTitle:@"Remove banner" forState:UIControlStateNormal];
            self.checkVideoButton.hidden = YES;
            self.adType = YumiMediationAdLogTypeBanner;
            dispatch_async(dispatch_get_main_queue(), ^{
                self.showLogConsole.text = self.bannerAdLog;
            });
        }
            break;
        case 1:
        {
            [self.requestAdButton setTitle:@"Request interstitial" forState:UIControlStateNormal];
            [self.presentOrCloseAdButton setTitle:@"Show interstitial" forState:UIControlStateNormal];
            self.checkVideoButton.hidden = YES;
            self.adType = YumiMediationAdLogTypeInterstitial;
            dispatch_async(dispatch_get_main_queue(), ^{
                self.showLogConsole.text = self.interstitialAdLog;
            });
        }
            break;
        case 2:
        {
            [self.requestAdButton setTitle:@"Request video" forState:UIControlStateNormal];
            [self.checkVideoButton setTitle:@"Check  video" forState:UIControlStateNormal];
            [self.presentOrCloseAdButton setTitle:@"Play video" forState:UIControlStateNormal];
              self.checkVideoButton.hidden = NO;
            self.adType = YumiMediationAdLogTypeVideo;
            dispatch_async(dispatch_get_main_queue(), ^{
                self.showLogConsole.text = self.videoAdLog;
            });
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
    [self showLogConsoleWith:@"banner view did load" adLogType:YumiMediationAdLogTypeBanner];
}

- (void)yumiMediationBannerView:(YumiMediationBannerView *)adView didFailWithError:(YumiMediationError *)error{
    [self showLogConsoleWith:[NSString stringWithFormat:@"banner view did fail ,error: %@", [error localizedDescription]] adLogType:YumiMediationAdLogTypeBanner];
}

- (void)yumiMediationBannerViewDidClick:(YumiMediationBannerView *)adView{
    [self showLogConsoleWith:@"banner view did click" adLogType:YumiMediationAdLogTypeBanner];
}

@end
