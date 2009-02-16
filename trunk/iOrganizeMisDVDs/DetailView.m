//
//  DetailView.m
//  iOrganizeMisDVDs
//
//  Created by 利辺羅 on 09/02/12.
//  Copyright 2009 Piggy Trashing EmperatorZ. All rights reserved.
//

#import "DetailView.h"


@implementation DetailView

- (void) awakeFromNib
{
	// Set up the background gradient for this custom scrollView
	backgroundGradient = [[NSGradient alloc] initWithStartingColor:[NSColor colorWithDeviceRed:254/255.0 green:243/255.0 blue:101/255.0 alpha:1]
													   endingColor:[NSColor colorWithDeviceRed:215/255.0 green:184/255.0 blue:14/255.0 alpha:1]];
	if ([[self superclass] instancesRespondToSelector:@selector(awakeFromNib)])
		[super awakeFromNib];
}

- (void) drawRect:(NSRect)rect
{
	// Drawing code here.
	[backgroundGradient drawInRect:[self bounds] angle:-80.0];
}

- (void) dealloc
{
	[backgroundGradient release];
	[super dealloc];
}

@end
