#import "Fargon2Plugin.h"
#if __has_include(<fargon2/fargon2-Swift.h>)
#import <fargon2/fargon2-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "fargon2-Swift.h"
#endif

@implementation Fargon2Plugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFargon2Plugin registerWithRegistrar:registrar];
}
@end
