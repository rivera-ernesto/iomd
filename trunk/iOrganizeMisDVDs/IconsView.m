//
//  IconsView.m
//  iOrganizeMisDVDs
//
//  Created by 利辺羅 on 09/02/05.
//  Copyright 2009 Piggy Trashing EmperatorZ. All rights reserved.
//

#import "IconsView.h"


@implementation MovieCollectionView

- (void) awakeFromNib
{
	// Set up the background gradient for this custom scrollView
	backgroundGradient = [[NSGradient alloc] initWithStartingColor:[NSColor colorWithDeviceRed:25/255.0 green:50/255.0 blue:149/255.0 alpha:1]
													   endingColor:[NSColor colorWithDeviceRed:8/255.0 green:12/255.0 blue:27/255.0 alpha:1]];
	if ([[self superclass] instancesRespondToSelector:@selector(awakeFromNib)])
		[super awakeFromNib];
}

- (void) drawRect:(NSRect)rect
{
	// Drawing code here.
	[backgroundGradient drawInRect:[self bounds] angle:80.0];
}

- (void) dealloc
{
	[backgroundGradient release];
	[super dealloc];
}

@end


@implementation MediaItemView

- (NSView *) hitTest:(NSPoint)aPoint
{
	// Don't allow any mouse clicks for subviews in this view
	return self;
}

@end
