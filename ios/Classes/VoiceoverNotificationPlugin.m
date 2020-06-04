#import "VoiceoverNotificationPlugin.h"
#if __has_include(<voiceover_notification_plugin/voiceover_notification_plugin-Swift.h>)
#import <voiceover_notification_plugin/voiceover_notification_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "voiceover_notification_plugin-Swift.h"
#endif

@implementation VoiceoverNotificationPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftVoiceoverNotificationPlugin registerWithRegistrar:registrar];
}
@end
