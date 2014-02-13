#import "ObjSynthAudioDriver.h"

@implementation ObjSynthAudioDriver

- (id)initWithSettings:(ObjSynthSettings *)settings andSynth:(ObjSynthSynthesizer *)synth
{
    self = [super init];
    if (self) {
        _wrappedImpl = new_fluid_audio_driver([settings wrappedImpl],
                                              [synth wrappedImpl]);
    }
    
    return self;
}

@end
