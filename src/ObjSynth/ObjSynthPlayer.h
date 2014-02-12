#include <fluidsynth.h>

#import <ObjFW/ObjFW.h>

#import "ObjSynthSynthesizer.h"

@interface ObjSynthPlayer : OFObject

@property (readonly) fluid_player_t *wrappedImpl;

- (id)initWithSynthesizer:(ObjSynthSynthesizer *)synth;

- (void)addFilePath:(OFString *)filePath;
- (void)play;

@end
