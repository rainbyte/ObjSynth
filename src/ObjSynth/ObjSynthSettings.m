#import "ObjSynthSettings.h"

@implementation ObjSynthSettings

- (id)init
{
    self = [super init];
    if (self) {
        _origImpl = new_fluid_settings();
    }
    
    return self;
}

- (void)setOption:(OFString *)option toStr:(OFString *)str
{
    fluid_settings_setstr(_origImpl, [option UTF8String], [str UTF8String]);
}

@end
