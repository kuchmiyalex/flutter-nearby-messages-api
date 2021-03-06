#import "NearbyMessagesApiPlugin.h"
#import "NearbyMessagesApiMCMs.h"

@interface NearbyMessagesApiPlugin ()
@property(nonatomic, retain) FlutterMethodChannel *channel;
@end

@implementation NearbyMessagesApiPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel *channel = [FlutterMethodChannel
      methodChannelWithName:@"nearby_messages_api"
            binaryMessenger:[registrar messenger]];
  NearbyMessagesApiPlugin* instance = [[NearbyMessagesApiPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
    instance.channel = channel;
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    NearbyMessagesApiMCMs *nearbyMessagesApiMcms = [[NearbyMessagesApiMCMs alloc] initWithChannel:self.channel];
    
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else if ([@"backgroundSubscribe" isEqualToString:call.method]) {
      [nearbyMessagesApiMcms backgroundSubscribe];
      result(@(true));
  } else if ([@"backgroundUnsubscribe" isEqualToString:call.method]) {
      [ nearbyMessagesApiMcms backgroundUnsubscribe];
      result(@(true));
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
