#import "ObjSynthSettings.h"

@implementation ObjSynthSettings

- (id)init
{
    self = [super init];
    if (self) {
        _wrappedImpl = new_fluid_settings();
    }
    
    return self;
}

- (void)setOption:(OFString *)option toStr:(OFString *)str
{
    fluid_settings_setstr(_wrappedImpl, [option UTF8String], [str UTF8String]);
}

@end
