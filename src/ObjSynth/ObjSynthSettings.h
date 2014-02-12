#import <ObjFW/ObjFW.h>

#include <fluidsynth.h>

@interface ObjSynthSettings : OFObject

@property (readonly) fluid_settings_t *wrappedImpl;

- (void)setOption:(OFString *)type toStr:(OFString *)str;

@end
