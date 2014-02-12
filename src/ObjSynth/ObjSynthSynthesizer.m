#import "ObjSynthSynthesizer.h"

@implementation ObjSynthSynthesizer

- (id)initWithSettings:(ObjSynthSettings *)settings
{
    self = [super init];
    if (self) {
        _wrappedImpl = new_fluid_synth([settings wrappedImpl]);
    }
    
    return self;
}

- (void)addSoundFontPath:(OFString *)sfPath
{
    fluid_synth_sfload(_wrappedImpl, [sfPath UTF8String], 1);
}

@end
