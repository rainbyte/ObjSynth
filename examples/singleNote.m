#import <ObjFW/ObjFW.h>

#import "ObjSynth.h"

int main(int argc, char** argv)
{
    if (argc != 2) {
        fprintf(stderr, "Usage: singleNote [soundfont]\n");
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

        [synth noteOnAtChannel:0 withKey:60 andVelocity:100];
        
        printf("Press \"Enter\" to stop: ");
        fgetc(stdin);
        printf("done\n");
    }
    
    return 0;
}
