#import "AVRecorde.h"

#import <AVFoundation/AVFoundation.h>

@interface AVRecorde()
///记录文件
@property (nonatomic, strong) NSURL *recordedFile;
///音乐播放器
@property (nonatomic, strong) AVAudioPlayer *player;
///音频记录器
@property (nonatomic, strong) AVAudioRecorder *recorder;

@end
@implementation AVRecorde

+ (instancetype)AVRecorde
{
    return [[NSBundle mainBundle] loadNibNamed:@"AVRecorde" owner:nil options:nil].firstObject;
}
//开始录制
- (IBAction)btnTouchDown:(id)sender {
    NSLog(@"btnTouchDown");
    _recordedFile = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingFormat:@"Record1"]];
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *sessionError;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    if(session == nil)
        NSLog(@"Error creating session: %@", [sessionError description]);
    else
        [session setActive:YES error:nil];
    _recorder = [[AVAudioRecorder alloc] initWithURL:_recordedFile settings:nil error:nil];
    [_recorder prepareToRecord];
    [_recorder record];
    _player = nil;
}
//结束录制
- (IBAction)touchUpInside:(id)sender {
    NSLog(@"touchUpInside");
    [_recorder stop];
    _recorder = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSData *data = [fileManager contentsAtPath:[NSTemporaryDirectory() stringByAppendingFormat:@"Record1"]];
    
}
//播放音频
- (IBAction)startPlayVideo:(id)sender {
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:_recordedFile error:nil];
    [_player play];
}

@end
