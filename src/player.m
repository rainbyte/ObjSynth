#include <fluidsynth.h>

#import "ObjSynth/ObjSynthPlayer.h"
#import "ObjSynth/ObjSynthSettings.h"
#import "ObjSynth/ObjSynthSynthesizer.h"

int main(int argc, char** argv)
{
    int i;
    ObjSynthSettings *synthSettings = [[ObjSynthSettings alloc] init];;

    ObjSynthSynthesizer *synthSynthesizer =
        [[ObjSynthSynthesizer alloc] initWithSettings:synthSettings];
    
    ObjSynthPlayer *synthPlayer =
        [[ObjSynthPlayer alloc] initWithSynthesizer:synthSynthesizer];

    fluid_audio_driver_t* adriver;
    
    [synthSettings setOption:@"audio.driver" toStr:@"pulseaudio"];

    adriver = new_fluid_audio_driver([synthSettings origImpl],
                                     [synthSynthesizer wrappedImpl]);
    /* process command line arguments */
    for (i = 1; i < argc; i++) {
        if (fluid_is_soundfont(argv[i])) {
           fluid_synth_sfload([synthSynthesizer wrappedImpl], argv[1], 1);
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
    delete_fluid_settings([synthSettings origImpl]);
    return 0;
}
