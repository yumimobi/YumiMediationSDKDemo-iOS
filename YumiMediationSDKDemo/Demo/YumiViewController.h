//
//  YumiViewController.h
//  YumiMediationDebugCenter-iOS
//
//  Created by ShunZhi Tang on 2017/7/13.
//  Copyright © 2017年 Zplay. All rights reserved.
//

@import UIKit;
#import "YumiCommonHeaderFile.h"
/*
 banner：y6op8v69
 interstitial: rz2wotpp
 video：5x11o7l3
 splash：pynlqi14
 */
static NSString *const placementID = @"5x11o7l3";
static NSString *const channelID = @"";
static NSString *const versionID = @"";

@protocol YumiViewControllerDelegate <NSObject>

- (void)modifyPlacementID:(NSString *)placementID
                channelID:(NSString *)channelID
                versionID:(NSString *)versionID
                   adType:(YumiAdType)adType;

@end

@interface YumiViewController : UIViewController

@property (nonatomic, weak) id<YumiViewControllerDelegate> delegate;
@property (nonatomic, assign, getter=isPresented) BOOL presented;
@property (nonatomic, assign) YumiAdType adType;

@end
