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

@end
