#import "FlutterChannelEventBusPlugin.h"
#if __has_include(<flutter_channel_event_bus/flutter_channel_event_bus-Swift.h>)
#import <flutter_channel_event_bus/flutter_channel_event_bus-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_channel_event_bus-Swift.h"
#endif

@implementation FlutterChannelEventBusPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterChannelEventBus registerWithRegistrar:registrar];
}
@end
