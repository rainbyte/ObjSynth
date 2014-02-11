#include <fluidsynth.h>

#import "ObjSynth/ObjSynthSettings.h"

int main(int argc, char** argv)
{
    int i;
    ObjSynthSettings *synthSettings = [[ObjSynthSettings alloc] init];;
    fluid_synth_t* synth;
    fluid_player_t* player;
    fluid_audio_driver_t* adriver;
    
    [synthSettings setOption:@"audio.driver" toStr:@"pulseaudio"];

    synth = new_fluid_synth([synthSettings origImpl]);
    player = new_fluid_player(synth);
    adriver = new_fluid_audio_driver([synthSettings origImpl], synth);
    /* process command line arguments */
    for (i = 1; i < argc; i++) {
        if (fluid_is_soundfont(argv[i])) {
           fluid_synth_sfload(synth, argv[1], 1);
        }
        if (fluid_is_midifile(argv[i])) {
            fluid_player_add(player, argv[i]);
        }
    }
    /* play the midi files, if any */
    fluid_player_play(player);
    /* wait for playback termination */
    fluid_player_join(player);
    /* cleanup */
    delete_fluid_audio_driver(adriver);
    delete_fluid_player(player);
    delete_fluid_synth(synth);
    delete_fluid_settings([synthSettings origImpl]);
    return 0;
}
