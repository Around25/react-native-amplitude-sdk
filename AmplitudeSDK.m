#import "AmplitudeSDK.h"
#import "Amplitude-iOS/Amplitude.h"
#import "AMPRevenue.h"

@implementation AmplitudeSDKiOS

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(initializeApiKey:(NSString *)apiKey) {
    [[Amplitude instance] setTrackingSessionEvents:YES];
    [[Amplitude instance] initializeApiKey:apiKey];
}

RCT_EXPORT_METHOD(setUserId:(NSString *)userId) {
    [[Amplitude instance] setUserId:userId];
}

RCT_EXPORT_METHOD(setUserProperties:(NSDictionary *)properties) {
    [[Amplitude instance] setUserProperties:properties];
}

RCT_EXPORT_METHOD(clearUserProperties) {
    [[Amplitude instance] clearUserProperties];
}

RCT_EXPORT_METHOD(logEventWithProperties:(NSString *)event withProperties:(NSDictionary *)properties) {
    if(properties){
        [[Amplitude instance] logEvent:event withEventProperties:properties];
    }
    else [[Amplitude instance] logEvent:event withEventProperties:nil];
    
}

RCT_EXPORT_METHOD(logEvent:(NSString *)event) {
    
    [[Amplitude instance] logEvent:event withEventProperties:nil];
    
}

RCT_EXPORT_METHOD(logOutUser) {
    [[Amplitude instance] setUserId:nil];  // not string nil
}


RCT_EXPORT_METHOD(logRevenue:(NSDictionary *)properties price:(double)price quantity:(int)quantity)
{
    AMPRevenue *revenue = [[[AMPRevenue revenue] setQuantity: quantity] setEventProperties:properties];
    [revenue setPrice:[NSNumber numberWithDouble:price]];
    [[Amplitude instance] logRevenueV2:revenue];
}

@end
