//
//  MovieDiscArrayController.h
//  iOrganizeMisDVDs
//
//  Created by 利辺羅 on 09/02/04.
//  Copyright 2009 Piggy Trashing EmperatorZ. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface DiscArrayController : NSArrayController
{
	IBOutlet NSArrayController * mediaArrayController;
}

@end


@interface MovieArrayController : NSArrayController
{
}

@end


//@interface MediaToDiscIndexesTransformer: NSValueTransformer
//{
//	NSArrayController * discArrayController, * mediaArrayController;
//}
//@property (retain) NSArrayController * discArrayController, * mediaArrayController;
//
//@end

