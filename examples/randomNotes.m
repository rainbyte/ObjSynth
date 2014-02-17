#import <ObjFW/ObjFW.h>
#import <stdlib.h>
#import <unistd.h>

#import "ObjSynth.h"

int main(int argc, char **argv)
{
    if (argc != 2) {
        fprintf(stderr, "Usage: randomNotes [soundfont]\n");
        return 1;
    }

    @autoreleasepool {
        ObjSynth *synth = [[ObjSynth alloc] init];
        [synth setOption:@"audio.driver" toStr:@"pulseaudio"];

        /* process command line arguments */
        OFString *sfpath = [OFString stringWithUTF8String:argv[1]];
        if ([ObjSynth isSoundFont:sfpath]) {
            [synth loadSoundFont:sfpath withPreset:1];
        }

        [synth enableAudioOutput];

        /* init random number generator */
        srand(getpid());

        int key;
        for (int i = 0; i < 32; i++) {
            /* generate a random key */
            key = 60 + (int) (12.0f * rand() / (float) RAND_MAX);

            /* play a note */
            [synth noteOnAtChannel:0 withKey:key andVelocity:100];

            /* sleep for 1 sec */
            sleep(1);

            /* stop the note */
            [synth noteOffAtChannel:0 withKey:key];
        }
    }
    
    return 0;
}
