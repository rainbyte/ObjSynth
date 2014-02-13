#import <ObjFW/ObjFW.h>

#include <fluidsynth.h>

#import "ObjSynthSettings.h"
#import "ObjSynthSynthesizer.h"

@interface ObjSynthAudioDriver : OFObject

@property (readonly) fluid_audio_driver_t *wrappedImpl;

- (id)initWithSettings:(ObjSynthSettings *)settings
              andSynth:(ObjSynthSynthesizer *)synth;

@end
