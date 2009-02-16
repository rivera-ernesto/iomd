//
//  MediaDetail.h
//  iOrganizeMisDVDs
//
//  Created by 利辺羅 on 09/02/13.
//  Copyright 2009 Piggy Trashing EmperatorZ. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Media;

@interface MediaDetail :  NSManagedObject  
{
}

@property (retain) NSData * image;
@property (retain) NSDate * releaseDate;
@property (retain) NSNumber * rating;
@property (retain) NSString * aspectRatio;
@property (retain) NSString * certification;
@property (retain) NSString * comments;
@property (retain) NSString * country;
@property (retain) NSString * genre;
@property (retain) NSString * language;
@property (retain) NSString * otherTitles;
@property (retain) NSString * synopsis;
@property (retain) NSString * tagLine;
@property (retain) NSString * title;
@property (retain) NSString * year;
@property (retain) Media * media;
@property (retain) NSManagedObject * mediaInfo;

@end

