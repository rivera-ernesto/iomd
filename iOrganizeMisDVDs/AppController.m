//
//  AppController.m
//  iOrganizeMisDVDs
//
//  Created by 利辺羅 on 08/11/12.
//  Copyright 2008 Piggy Trashing EmperatorZ. All rights reserved.
//

#import "AppController.h"


@implementation AppController

# pragma mark Application Delegate

// Don't open untitled yet
- (BOOL)applicationShouldOpenUntitledFile:(NSApplication *)sender
{
	return NO;
}

// Avoid opening untitled documents everytime
- (BOOL)applicationShouldHandleReopen:(NSApplication *)theApplication hasVisibleWindows:(BOOL)flag
{
	return NO;
}

// Open most recent document if available
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	NSDocumentController *docController = [NSDocumentController sharedDocumentController];
	NSArray *recents = [docController recentDocumentURLs];
	NSString *defaultPath = [@"~/Library/Preferences/iOrganizeMisDVDs.dvds" stringByExpandingTildeInPath];
	NSError *outError;
	
	// Default library exists?
	BOOL defaultExists = [[NSFileManager defaultManager] fileExistsAtPath:defaultPath];
	if (defaultExists && NO) // Disabled for now
	{
		NSLog(@"Opening default...");
		[docController openDocumentWithContentsOfURL:[NSURL fileURLWithPath:defaultPath]
											 display:YES
											   error:&outError];
	}
	// Else open last document
	else if (![recents count] == 0) {
		NSLog(@"Opening most recent...");
		[docController openDocumentWithContentsOfURL:[recents objectAtIndex:0]
											 display:YES
											   error:&outError];
	}
	// Otherwise open a new untitled library
	else {		
		NSLog(@"Opening new untitled library...");
		[docController newDocument:self];
	}
}

@end
