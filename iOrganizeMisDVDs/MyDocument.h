//
//  MyDocument.h
//  iOrganizeMisDVDs
//
//  Created by ??? on 08/11/10.
//  Copyright Piggy Trashing EmperatorZ 2008 . All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MyDocument : NSPersistentDocument 
{	
	IBOutlet NSArrayController * discArrayController, * mediaArrayController;
	IBOutlet NSView * mainView, * listingView, * iconsView;
	IBOutlet NSTextField * status;
	
	NSArrayController * currentArrayController;
}

@property BOOL listingViewVisible, iconsViewVisible;

- (IBAction) newObject:(id)sender;
//- (IBAction) duplicate:(id)sender;

@end
