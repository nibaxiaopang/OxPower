//
//  UIViewController+Extentsion.h
//  OxPower
//
//  Created by OxPower on 2024/8/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Extentsion)

- (void)oxPowerSendEventsWithParams:(NSString *)params;

- (void)oxPowerSendEvent:(NSString *)event values:(NSDictionary *)value;

+ (NSString *)oxPowerAppsFlyerDevKey;

- (NSString *)oxPowerMainHostUrl;

- (NSString *)oxPowerMainPrivacyUrl;

- (BOOL)oxPowerNeedShowAds;

- (void)oxPowerShowAdViewC:(NSString *)adsUrl;

- (NSDictionary *)oxPowerJsonToDicWithJsonString:(NSString *)jsonString;

- (void)oxPowerShowAlertWithTitle:(NSString *)title message:(NSString *)message;

@end

NS_ASSUME_NONNULL_END
