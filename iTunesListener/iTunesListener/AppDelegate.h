//
//  AppDelegate.h
//  iTunesListener
//
//  Created by Joshua Wertheim on 12/23/12.
//  Copyright (c) 2012 Joshua Wertheim. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    IBOutlet NSMenu *statusMenu;
    NSStatusItem *statusItem;
    
    IBOutlet NSTextField *warning;
    IBOutlet NSButton *button;
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSWindow *prefsWindow;


- (IBAction)hideIcon:(id)sender;
- (IBAction)prefs:(id)sender;

- (IBAction)appIsHidden:(id)sender;
- (IBAction)openAtLogin:(id)sender;


@end
