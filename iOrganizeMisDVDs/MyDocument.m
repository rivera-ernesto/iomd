//
//  MyDocument.m
//  iOrganizeMisDVDs
//
//  Created by ??? on 08/11/10.
//  Copyright Piggy Trashing EmperatorZ 2008 . All rights reserved.
//

#import "MyDocument.h"
//#import "ArrayControllers.h"
//#import "Disc.h"
//#import "Movie.h"


static NSString *DiscPBoardType = @"DiscPBoardType";

@implementation MyDocument

# pragma mark Init

- (NSString *)windowNibName 
{
    return @"MyDocument";
}

//- (void)awakeFromNib
//{
//	NSLog(@"Document awakeFromNib");
//	if ([[self superclass] instancesRespondToSelector:@selector(awakeFromNib)])
//		[super awakeFromNib];
//}

- (void) windowControllerDidLoadNib:(NSWindowController *)windowController 
{
    NSLog(@"windowControllerDidLoadNib");
	[super windowControllerDidLoadNib:windowController];
	
	// User interface preparation code
	[self setIconsViewVisible:YES];
	
//	// Register value transformer
//	MediaToDiscIndexesTransformer * transformer = [[MediaToDiscIndexesTransformer alloc] init];
//	transformer.discArrayController = discArrayController;
//	transformer.mediaArrayController = mediaArrayController;
//	[NSValueTransformer setValueTransformer:transformer forName:@"kk"];
}

# pragma mark View Switching

- (BOOL) listingViewVisible
{
	return [listingView isDescendantOf:mainView];
}

- (void) setListingViewVisible:(BOOL)flag
{
	if (flag == YES && ![listingView isDescendantOf:mainView])
	{
		[self setIconsViewVisible:NO];
		NSLog(@"Set listing visible");
		[mainView addSubview:listingView];
		[listingView setFrame:[mainView bounds]];
		currentArrayController = discArrayController;
	}
	else if (flag == NO && [listingView isDescendantOf:mainView])
	{
		NSLog(@"Set listing not visible");
		[listingView retain];
		[listingView removeFromSuperview];
		[self setIconsViewVisible:YES];
	}
}

- (BOOL) iconsViewVisible
{
	return [iconsView isDescendantOf:mainView];
}

- (void) setIconsViewVisible:(BOOL)flag
{
	if (flag == YES && ![iconsView isDescendantOf:mainView])
	{
		[self setListingViewVisible:NO];
		NSLog(@"Set icons view visible");
		[mainView addSubview:iconsView];
		[iconsView setFrame:[mainView bounds]];
		currentArrayController = mediaArrayController;
	}
	else if (flag == NO && [iconsView isDescendantOf:mainView])
	{
		NSLog(@"Set icons view not visible");
		[iconsView retain];
		[iconsView removeFromSuperview];
		[self setListingViewVisible:YES];
	}
}


# pragma mark First Responder

- (void)newObject:(id)sender
{
	[currentArrayController add:sender];
}

- (void)delete:(id)sender
{
	[currentArrayController remove:self];
}

# pragma mark Open & Import

- (BOOL)readFromURL:(NSURL *)absoluteURL 
			 ofType:(NSString *)typeName 
			  error:(NSError **)outError
{
	// Try to let super read it
	if ([super readFromURL:absoluteURL ofType:typeName error:outError]) {
		NSLog(@"Document %@ of type %@ was read by super", absoluteURL, typeName);
		return YES;
	}
	
	// ToDo: code should be moved to DocumentController instead
	
	NSLog(@"Document %@ of type %@ has to be read manually", absoluteURL, typeName);
	
	// Try to read from old format
	NSArray *oldLibrary = [NSArray arrayWithContentsOfURL:absoluteURL];
	if (oldLibrary==nil)
		return NO;
	
	// Backup the original file
	NSString *srcPath = [absoluteURL path];
	NSString *dstPath = [[srcPath stringByDeletingPathExtension] stringByAppendingPathExtension:@"old"];
	if (![[NSFileManager defaultManager] copyItemAtPath:srcPath toPath:dstPath error:outError])
		NSLog(@"Error backuping original file: %@", *outError);
	
	// Create the new persistent store
	if (![[NSFileManager defaultManager] removeItemAtPath:srcPath error:outError])
		NSLog(@"Error removing original file: %@", *outError);
	NSPersistentStoreCoordinator *persistentStoreCoordinator = [[self managedObjectContext] persistentStoreCoordinator];
	NSString *type = [self persistentStoreTypeForFileType:typeName];
	NSPersistentStore *store = [persistentStoreCoordinator addPersistentStoreWithType:type
																		configuration:nil 
																				  URL:absoluteURL
																			  options:nil
																				error:outError];
	if (store == nil)
		return NO;
	
	// Start
	NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
	[managedObjectContext processPendingChanges];
	[[managedObjectContext undoManager] disableUndoRegistration];
	
	// Insert discs
//	for (NSDictionary *oldDisc in oldLibrary) {
//		
//		// Add disc
//		Disc *disc = [NSEntityDescription insertNewObjectForEntityForName:@"Disc" 
//												   inManagedObjectContext:managedObjectContext];
//		
//		// Init other values
//		disc.code = [oldDisc objectForKey:@"code"];
//		disc.audio = [oldDisc objectForKey:@"audio"];
//		disc.subtitles = [oldDisc objectForKey:@"subtitles"];
//		disc.movie.director = [oldDisc objectForKey:@"director"];
//		disc.movie.genre = [oldDisc objectForKey:@"genre"];
//		disc.movie.title = [oldDisc objectForKey:@"title"];
//		disc.movie.year = [oldDisc objectForKey:@"year"];
//		disc.movie.length = [oldDisc objectForKey:@"length"];
//	}
	
	// Finish
	[managedObjectContext processPendingChanges];
	[[managedObjectContext undoManager] enableUndoRegistration];
	[managedObjectContext save:outError];
	
	// Notify
	NSBeginInformationalAlertSheet(@"Import successful", 
								   nil, nil, nil, 
								   [self windowForSheet],
								   NULL, NULL, NULL,
								   self,
								   @"A copy of the original file has been saved as %@.", dstPath);
	return YES;
}

# pragma mark Utilities

- (NSArray *)newDiscsFromPropList:(NSArray *)propList
{
	//NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
	NSMutableArray *newDiscs = [[NSMutableArray alloc] init];
	
	// Convert dictionaries to discs
//	for (NSMutableDictionary *dict in propList) 
//	{
//		Disc *d = [NSEntityDescription insertNewObjectForEntityForName:@"Disc" 
//												inManagedObjectContext:managedObjectContext];
//		
//		[d updateWithDictionaryRepresentation:dict];
//		
//		// Add to new discs
//		[newDiscs addObject:d];
//	}
	
	return newDiscs;
}

//- (void)selectAndScrollTo:(NSArray *)discs
//{
//	[mediaArrayController setSelectedObjects:discs];
//	NSIndexSet *indexes = [mediaArrayController selectionIndexes];
//	[listingView scrollRowToVisible:[indexes lastIndex]];
//	[listingView scrollRowToVisible:[indexes firstIndex]];
//}

# pragma mark Cut, Copy & Paste

- (void)copy:(id)sender
{
	// Get selection
	NSArray *selectedDiscs = [currentArrayController selectedObjects];
	if ([selectedDiscs count] == 0) {
        NSBeep();
		return;
    }
	
	// Prepare containers
	NSMutableArray *strDiscs = [[NSMutableArray alloc] init];
	NSMutableArray *propList = [[NSMutableArray alloc] init];
	
	// Fill containers
//	for (Disc *d in selectedDiscs) {
//		[strDiscs addObject:[d textDescription]];
//		[propList addObject:[d dictionaryRepresentation]];
//	}
	
	// Copy to pasteboard
	NSPasteboard *generalPasteboard = [NSPasteboard generalPasteboard];
	[generalPasteboard declareTypes:[NSArray arrayWithObjects:NSStringPboardType, DiscPBoardType, nil]
							  owner:nil];
	[generalPasteboard setString:[strDiscs componentsJoinedByString:@"\n"]
						 forType:NSStringPboardType];
	
	if (![generalPasteboard setPropertyList:propList
									forType:DiscPBoardType])
		NSLog(@"Couldn't copy propList");
}

- (void)cut:(id)sender
{
	// Copy
	[self copy:sender];
	
	// ...and Delete
	[currentArrayController remove:sender];
}

//- (void)paste:(id)sender
//{
//	// Read pasteboard
//	NSPasteboard *generalPasteboard = [NSPasteboard generalPasteboard];
//    NSArray *propList = [generalPasteboard propertyListForType:DiscPBoardType];
//    if (propList == nil) {
//        NSBeep();
//		return;
//    }
//	
//	// Create new discs
//	NSArray *newDiscs = [self newDiscsFromPropList:propList];
//	
//	// Select and scroll
//	NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
//	[managedObjectContext processPendingChanges];
//	[self selectAndScrollTo:newDiscs];
//}

//- (void)duplicate:(id)sender
//{
//	// Get selection
//	NSArray *selectedDiscs = [mediaArrayController selectedObjects];
//	if ([selectedDiscs count] == 0) {
//        NSBeep();
//		return;
//    }
//	
//	// Get the values
//	NSMutableArray *propList = [[NSMutableArray alloc] init];
//	for (Disc *d in selectedDiscs)
//		[propList addObject:[d dictionaryRepresentation]];
//	
//	// Create new discs
//	NSArray *newDiscs = [self newDiscsFromPropList:propList];
//	
//	// Select and scroll
//	NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
//	[managedObjectContext processPendingChanges];
//	[self selectAndScrollTo:newDiscs];
//}

# pragma mark Misc

//- (BOOL)validateUserInterfaceItem:(id <NSValidatedUserInterfaceItem>)anItem
//{
//    SEL theAction = [anItem action];
//	if (theAction == @selector(saveDocument:))
//    {
//        NSLog(@"Validate");
//		return [self isDocumentEdited];
//		
//    }
//	return [super validateUserInterfaceItem:anItem];
//}

- (NSPrintOperation *)printOperationWithSettings:(NSDictionary *)printSettings error:(NSError **)outError
{
	return [NSPrintOperation printOperationWithView:listingView 
										  printInfo:[self printInfo]];
}

@end










