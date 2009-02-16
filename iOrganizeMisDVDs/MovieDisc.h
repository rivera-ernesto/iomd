//
//  MovieDisc.h
//  iOrganizeMisDVDs
//
//  Created by 利辺羅 on 09/02/06.
//  Copyright 2009 Piggy Trashing EmperatorZ. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "MediaDisc.h"


@interface MovieDisc :  MediaDisc  
{
}

@property (retain) NSString * audio;
@property (retain) NSString * subtitles;
@property (retain) NSNumber * menu;

@property (assign) NSString * audioSubtitles;

@end


