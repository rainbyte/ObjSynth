#import <ObjFW/ObjFW.h>

#import "ObjSynthSettings.h"

@interface ObjSynthSynthesizer : OFObject

@property (readonly) fluid_synth_t *wrappedImpl;

- (id)initWithSettings:(ObjSynthSettings *)settings;

@end
