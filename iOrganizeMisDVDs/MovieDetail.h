//
//  MovieDetail.h
//  iOrganizeMisDVDs
//
//  Created by 利辺羅 on 09/02/16.
//  Copyright 2009 Piggy Trashing EmperatorZ. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "MediaDetail.h"


@interface MovieDetail :  MediaDetail  
{
}

@property (retain) NSString * director;
@property (retain) NSString * writer;
@property (retain) NSString * casting;
@property (retain) NSString * length;

@end


