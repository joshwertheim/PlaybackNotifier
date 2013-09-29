//
//  AppDelegate.m
//  iTunesListener
//
//  Created by Joshua Wertheim on 12/23/12.
//  Copyright (c) 2012 Joshua Wertheim. All rights reserved.
//


#import "AppDelegate.h"
#import "LaunchAtLoginController.h"

#import "iTunes.h"

@implementation AppDelegate

@synthesize prefsWindow;


- (void)showNotificationAlert:(NSString *)message andTitle:(NSString *)title
{
    
    NSUserNotification *notification = [[NSUserNotification alloc] init];
    [notification setTitle:title];
    [notification setInformativeText:message];
    
    [notification setDeliveryDate:[NSDate dateWithTimeInterval:0 sinceDate:[NSDate date]]];
//    [notification setSoundName:NSUserNotificationDefaultSoundName];
    NSUserNotificationCenter *center = [NSUserNotificationCenter defaultUserNotificationCenter];
    [center scheduleNotification:notification];
    

}

- (void)checkPlayback:(NSNotification *)notification
{
    NSString *trackName = @"", *trackArtist = @"", *trackAlbum = @"", *msg = @"";
    
    NSDictionary *information = [notification userInfo];
//    NSLog(@"track information: %@", information);
    
    [[NSUserNotificationCenter defaultUserNotificationCenter] removeAllDeliveredNotifications];
    
    trackName = [information valueForKey:@"Name"];
    trackArtist = [information valueForKey:@"Artist"];
    
    
    if([information valueForKey:@"Album"])
        trackAlbum = [information valueForKey:@"Album"];
    else trackAlbum = @"";
    
    
    msg = [NSString stringWithFormat:@"\%@\n\%@", trackArtist, trackAlbum];
    
//    msg = [NSString stringWithFormat:@"%@\n\%@", trackName, trackArtist];
    
    
    if([[information valueForKey:@"Player State"] isEqualToString:@"Playing"])
        [self showNotificationAlert:msg andTitle:trackName];
    
    
}


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{    
    [[NSDistributedNotificationCenter defaultCenter] addObserver:self selector:@selector(checkPlayback:) name:@"com.apple.iTunes.playerInfo" object:nil];
    
    [[NSDistributedNotificationCenter defaultCenter] addObserver:self selector:@selector(checkPlayback:) name:@"com.spotify.client.PlaybackStateChanged" object:nil];
}

/*
- (IBAction)hideIcon:(id)sender {
    [[NSStatusBar systemStatusBar] removeStatusItem: statusItem];
}
 */

- (IBAction)prefs:(id)sender {    
    [prefsWindow makeKeyAndOrderFront:NSApp];
}


- (IBAction)appIsHidden:(id)sender {
    NSLog(@"test");
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"isHidden"]) {
        [[NSStatusBar systemStatusBar] removeStatusItem: statusItem];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isHidden"];
        [prefsWindow close];
        NSLog(@"dfdfd");
    }
    
    else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isHidden"];
    }
}

- (IBAction)openAtLogin:(id)sender {
    
    LaunchAtLoginController *launchController = [[LaunchAtLoginController alloc] init];
    
    if(![launchController launchAtLogin])
        NSLog(@"Set...");
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"openAtLogin"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"openAtLogin"];
        [launchController setLaunchAtLogin:YES];
        [button setTitle:@"Disable Start at login"];
        
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"openAtLogin"];
        [launchController setLaunchAtLogin:FALSE];
        [button setTitle:@"Enable Start at login"];
                
    }
}







-(void)awakeFromNib {
    
    NSImage *statusImage = [NSImage imageNamed:@"icon-dark.png"];
    NSImage *statusHighlightedImage = [NSImage imageNamed:@"icon-light.png"];

        
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setMenu:statusMenu];
    [statusItem setImage:statusImage];
    [statusItem setAlternateImage:statusHighlightedImage];
    [statusItem setHighlightMode:YES];
    [statusItem setTarget:self];
    
//    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"openAtLogin"];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isHidden"];
    
    [warning setStringValue:@"This option makes PlaybackNotifier completely hidden from view. \nNote: you will be unable to quit the app unless you open\nActivityMonitor.app"];
}

@end
