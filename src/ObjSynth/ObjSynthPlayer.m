#import "ObjSynthPlayer.h"

@implementation ObjSynthPlayer

- (id)initWithSynthesizer:(ObjSynthSynthesizer *)synth
{
    self = [super init];
    if (self) {
        _wrappedImpl = new_fluid_player([synth wrappedImpl]);
    }
    
    return self;
}

- (void)addFilePath:(OFString *)filePath
{
    fluid_player_add(_wrappedImpl, [filePath UTF8String]);
}

- (void)play
{
    /* play the midi files, if any */
    fluid_player_play(_wrappedImpl);
    /* wait for playback termination */
    fluid_player_join(_wrappedImpl);
}

@end
