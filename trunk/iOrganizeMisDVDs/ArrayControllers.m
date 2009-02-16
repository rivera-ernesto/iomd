//
//  MovieDiscArrayController.m
//  iOrganizeMisDVDs
//
//  Created by 利辺羅 on 09/02/04.
//  Copyright 2009 Piggy Trashing EmperatorZ. All rights reserved.
//

#import "ArrayControllers.h"
#import "Media.h"
#import "MediaDisc.h"

#define SELECTION_CHANGED @"selectionChanged"



@implementation DiscArrayController

- (void)awakeFromNib
{
	NSLog(@"DiscArrayController awakeFromNib");
	[super awakeFromNib];
	
	// Register for notifications
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(refreshSelection:) 
												 name:SELECTION_CHANGED 
											   object:mediaArrayController];
}

- (void) dealloc
{
	// Unregister for notifications
	[[NSNotificationCenter defaultCenter] removeObserver:self];

	[super dealloc];
}

// Refresh selection according to the media array controller
- (void)refreshSelection:(NSNotification *)notification
{
	NSLog(@"Discs refreshSelection");
	
	NSMutableArray * discsToSelect = [[NSMutableArray alloc] init];
	for (Media * m in [mediaArrayController selectedObjects]) 
		[discsToSelect addObjectsFromArray:[[m discs] allObjects]];
	
	[self setSelectedObjects:discsToSelect];
}

// Update the media array controller selection accordingly
- (BOOL)setSelectionIndexes:(NSIndexSet *)indexes
{
	NSLog(@"Discs setSelectionIndexes");
	if (![super setSelectionIndexes:indexes])
		return NO;
	
	NSArray * arrangedDiscs = [self arrangedObjects];
	NSMutableArray * mediaToSelect = [[NSMutableArray alloc] init];
	for (MediaDisc * d in [arrangedDiscs objectsAtIndexes:indexes])
		[mediaToSelect addObject:[d media]];
	
	return [mediaArrayController setSelectedObjects:mediaToSelect];
}

// Create the movie and its details
- (id)newObject
{
	NSLog(@"DiscArrayController newObject");
	
	id obj = [super newObject];
	
	// Set addition date
	[obj setValue:[NSDate date] forKey:@"dateAdded"];
	
	NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
	
	// Create the corresponding movie
	// ToDo: Let choose an existing movie as well
	id media = [NSEntityDescription insertNewObjectForEntityForName:@"Media" 
											 inManagedObjectContext:managedObjectContext];
	[obj setValue:media
		   forKey:@"media"];
	
	// Create corresponding movie details
	id detail = [NSEntityDescription insertNewObjectForEntityForName:@"MovieDetail" 
											   inManagedObjectContext:managedObjectContext];
	[media setValue:detail forKey:@"detail"];
	
	return obj;
}

@end


@implementation MovieArrayController

// Notify selection changes
- (BOOL)setSelectionIndexes:(NSIndexSet *)indexes
{
	NSLog(@"Movie setSelectionIndexes");
	if (![super setSelectionIndexes:indexes])
		return NO;
	
	// Post notification
	[[NSNotificationCenter defaultCenter] postNotificationName:SELECTION_CHANGED object:self];
	
	return YES;
}

// Create movie details
- (id)newObject
{
	NSLog(@"MovieArrayController newObject");
	
	id obj = [super newObject];
	
	NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
	
	// Create corresponding movie details
	id detail = [NSEntityDescription insertNewObjectForEntityForName:@"MovieDetail" 
											  inManagedObjectContext:managedObjectContext];
	[obj setValue:detail forKey:@"detail"];
	
	return obj;
}

@end


//@implementation MediaToDiscIndexesTransformer
//
//@synthesize discArrayController, mediaArrayController;
//
//+ (Class)transformedValueClass
//{
//	return [NSIndexSet class];
//}
//
//+ (BOOL)allowsReverseTransformation
//{
//	return NO;
//}
//
//- (id)transformedValue:(id)value
//{
//    NSLog(@"MediaToDiscIndexesTransformer");
//	
//	if (value == nil)
//		return nil;
//	
//	NSMutableIndexSet * discIndexes = [[[NSMutableIndexSet alloc] init] autorelease];
//	NSArray * arrangedDiscs = [discArrayController arrangedObjects];
//	
//	NSLog(@"%@", discArrayController);
//	for (Media * m in [mediaArrayController selectedObjects])
//	{
//		NSLog(@"%@",[m discs]);
//	
//		for (MediaDisc * d in [m discs])
//		{
//			[discIndexes addIndex:[arrangedDiscs indexOfObject:d]]; 
//		}
//	}
//	
//	NSLog(@"%@ -> %@", value, discIndexes);
//	return discIndexes;
//}
//
//@end
