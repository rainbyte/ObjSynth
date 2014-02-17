#import <ObjFW/ObjFW.h>

@interface ObjSynth : OFObject

- (void)enablePlayer;
- (void)enableAudioOutput;

- (void)setOption:(OFString *)type toStr:(OFString *)str;

- (int)loadSoundFont:(OFString *)path withPreset:(int)preset;
- (void)unloadSoundFont:(int)sfId withPreset:(int)preset;

- (void)noteOnAtChannel:(int)chan withKey:(int)key andVelocity:(int)vel;
- (void)noteOffAtChannel:(int)chan withKey:(int)key;

- (void)loadMidiFile:(OFString *)path;
- (void)play;

+ (BOOL)isSoundFont:(OFString *)path;
+ (BOOL)isMidiFile:(OFString *)path;

@end
