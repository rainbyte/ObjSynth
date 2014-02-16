#import <ObjFW/ObjFW.h>

#import "ObjSynth/ObjSynth.h"

int main(int argc, char** argv)
{
    int i;
    ObjSynth *synth = [[ObjSynth alloc] init];;
    [synth setOption:@"audio.driver" toStr:@"pulseaudio"];

    [synth enablePlayer];
    [synth enableAudioOutput];
    
    /* process command line arguments */
    for (i = 1; i < argc; i++) {
        OFString *argument = [OFString stringWithUTF8String:argv[i]];
        if ([ObjSynth isSoundFont:argument]) {
            [synth loadSoundFont:argument];
        }
        if ([ObjSynth isMidiFile:argument]) {
            [synth loadMidiFile:argument];
        }
    }

    [synth play];
    return 0;
}
