#include <fluidsynth.h>

#import "ObjSynth/ObjSynthPlayer.h"
#import "ObjSynth/ObjSynthSettings.h"
#import "ObjSynth/ObjSynthSynthesizer.h"

int main(int argc, char** argv)
{
    int i;
    ObjSynthSettings *synthSettings = [[ObjSynthSettings alloc] init];;
    [synthSettings setOption:@"audio.driver" toStr:@"pulseaudio"];

    ObjSynthSynthesizer *synthSynthesizer =
        [[ObjSynthSynthesizer alloc] initWithSettings:synthSettings];
    
    ObjSynthPlayer *synthPlayer =
        [[ObjSynthPlayer alloc] initWithSynthesizer:synthSynthesizer];

    fluid_audio_driver_t* adriver;
    adriver = new_fluid_audio_driver([synthSettings wrappedImpl],
                                     [synthSynthesizer wrappedImpl]);

    /* process command line arguments */
    for (i = 1; i < argc; i++) {
        if (fluid_is_soundfont(argv[i])) {
            [synthSynthesizer addSoundFontPath:[OFString stringWithUTF8String:argv[i]]];
        }
        if (fluid_is_midifile(argv[i])) {
            [synthPlayer addFilePath:[OFString stringWithUTF8String:argv[i]]];
        }
    }

    [synthPlayer play];
    /* cleanup */
    delete_fluid_audio_driver(adriver);
    delete_fluid_player([synthPlayer wrappedImpl]);
    delete_fluid_synth([synthSynthesizer wrappedImpl]);
    delete_fluid_settings([synthSettings wrappedImpl]);
    return 0;
}
