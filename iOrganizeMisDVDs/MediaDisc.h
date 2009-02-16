//
//  MediaDisc.h
//  iOrganizeMisDVDs
//
//  Created by 利辺羅 on 09/02/06.
//  Copyright 2009 Piggy Trashing EmperatorZ. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface MediaDisc :  NSManagedObject  
{
}

@property (retain) NSString * kind;
@property (retain) NSDate * dateAdded;
@property (retain) NSString * location;
@property (retain) NSString * code;
@property (retain) NSString * status;
@property (retain) NSString * edition;
@property (retain) NSNumber * totalNumber;
@property (retain) NSString * discZone;
@property (retain) NSString * comments;
@property (retain) NSString * format;
@property (retain) NSNumber * discNumber;
@property (retain) NSManagedObject * media;

@end


