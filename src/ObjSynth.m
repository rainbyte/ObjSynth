#import "ObjSynth.h"

#include <fluidsynth.h>

@interface ObjSynth()

@property fluid_settings_t *wrappedSettings;
@property fluid_synth_t *wrappedSynth;
@property fluid_player_t *wrappedPlayer;
@property fluid_audio_driver_t *wrappedAudioDriver;

@end

@implementation ObjSynth

- (id)init
{
    self = [super init];
    if (self) {
        _wrappedSettings = new_fluid_settings();
        _wrappedSynth = new_fluid_synth(_wrappedSettings);
        _wrappedPlayer = NULL;
        _wrappedAudioDriver = NULL;
    }

    return self;
}

- (void)enablePlayer
{
    _wrappedPlayer = new_fluid_player(_wrappedSynth);
}

- (void)enableAudioOutput
{
    _wrappedAudioDriver = new_fluid_audio_driver(_wrappedSettings,
                                                 _wrappedSynth);
}

- (void)setOption:(OFString *)option toStr:(OFString *)str
{
    fluid_settings_setstr(_wrappedSettings, [option UTF8String], [str UTF8String]);
}

- (int)loadSoundFont:(OFString *)path withPreset:(int)preset
{
    int sfId = fluid_synth_sfload(_wrappedSynth, [path UTF8String], preset);

    return sfId;
}

- (void)unloadSoundFont:(int)sfId withPreset:(int)preset
{
    fluid_synth_sfunload(_wrappedSynth, sfId, preset);
}

- (void)noteOnAtChannel:(int)chan withKey:(int)key andVelocity:(int)vel
{
    if (key < 0 || key > 127) return;
    if (chan < 0) return;
    if (vel < 0 || vel > 127) return;

    fluid_synth_noteon(_wrappedSynth, chan, key, vel);
}

- (void)noteOffAtChannel:(int)chan withKey:(int)key
{
    if (key < 0 || key > 127) return;
    if (chan < 0) return;

    fluid_synth_noteoff(_wrappedSynth, chan, key);
}

- (void)loadMidiFile:(OFString *)path
{
    if (_wrappedPlayer == NULL) return;

    fluid_player_add(_wrappedPlayer, [path UTF8String]);
}

- (void)play
{
    if (_wrappedPlayer == NULL) return;
    
    /* play the midi files, if any */
    fluid_player_play(_wrappedPlayer);
    /* wait for playback termination */
    fluid_player_join(_wrappedPlayer);
}

+ (BOOL)isSoundFont:(OFString *)path
{
    return fluid_is_soundfont([path UTF8String]);
}

+ (BOOL)isMidiFile:(OFString *)path
{
    return fluid_is_midifile([path UTF8String]);
}


- (void)dealloc
{
    if (_wrappedAudioDriver) {
        delete_fluid_audio_driver(_wrappedAudioDriver);
    }
    
    if (_wrappedPlayer) {
        delete_fluid_player(_wrappedPlayer);
    }

    delete_fluid_synth(_wrappedSynth);
    delete_fluid_settings(_wrappedSettings);
}

@end
