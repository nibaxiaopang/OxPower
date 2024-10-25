//
//  OxPowerUUDInstance.h
//  OxPower
//
//  Created by OxPower on 2024/9/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OxPowerUUDInstance : NSObject

+ (instancetype)sharedInstance;

- (NSString *)getUUID;

@end

NS_ASSUME_NONNULL_END
