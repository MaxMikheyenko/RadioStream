//
//  ViewController.m
//  RadioStream
//
//  Created by Max Mikheyenko on 5/10/13.
//  Copyright (c) 2013 Max Mikheyenko. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController ()

@property (nonatomic, retain) MPMoviePlayerController *streamAudioPlayer;
@property (nonatomic, assign) BOOL isPlaying;
@end

@implementation ViewController

@synthesize streamAudioPlayer;
@synthesize isPlaying;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  self.isPlaying = NO;
  NSURL *streamURL = [NSURL URLWithString:@"http://icecast.omroep.nl/3fm-sb-mp3"];
  self.streamAudioPlayer = [[MPMoviePlayerController alloc]
                            initWithContentURL:streamURL];
  streamAudioPlayer.movieSourceType = MPMovieSourceTypeStreaming;
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MetadataUpdate:) name:MPMoviePlayerTimedMetadataUpdatedNotification object:nil];
  [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];

  NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
  [center addObserver:self selector:@selector(moviePlayerNotification:) name:MPMoviePlayerLoadStateDidChangeNotification object:self.streamAudioPlayer];
  [center addObserver:self selector:@selector(moviePlayerNotification:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.streamAudioPlayer];
  [center addObserver:self selector:@selector(moviePlayerNotification:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:self.streamAudioPlayer];

}

- (void)moviePlayerNotification:(id)sender
{
  if(self.streamAudioPlayer.playbackState == MPMoviePlaybackStatePlaying)
    self.state.text = @"Playing";

  if(self.streamAudioPlayer.playbackState == MPMoviePlaybackStatePaused)
    self.state.text = @"Paused";

  if(self.streamAudioPlayer.loadState == MPMovieLoadStateUnknown)
    self.state.text = @"Buffering...";
}

- (IBAction)togglePlay:(id)sender {
  if(isPlaying)
  {
    [self.playControl setTitle:@"Play" forState:UIControlStateNormal];
    [self.streamAudioPlayer pause];
  } else {
    [self.playControl setTitle:@"Pause" forState:UIControlStateNormal];
    [self.streamAudioPlayer play];
  }
  self.isPlaying = !self.isPlaying;
}

@end
