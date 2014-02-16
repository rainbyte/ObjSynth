#import <ObjFW/ObjFW.h>

@interface ObjSynth : OFObject

- (void)enablePlayer;
- (void)enableAudioOutput;

- (void)setOption:(OFString *)type toStr:(OFString *)str;

- (void)loadSoundFont:(OFString *)path;

- (void)loadMidiFile:(OFString *)path;
- (void)play;

+ (BOOL)isSoundFont:(OFString *)path;
+ (BOOL)isMidiFile:(OFString *)path;

@end
