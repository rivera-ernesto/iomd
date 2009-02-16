// 
//  MovieDisc.m
//  iOrganizeMisDVDs
//
//  Created by 利辺羅 on 09/02/06.
//  Copyright 2009 Piggy Trashing EmperatorZ. All rights reserved.
//

#import "MovieDisc.h"


@implementation MovieDisc 

@dynamic audio;
@dynamic subtitles;
@dynamic menu;

- (NSString *)audioSubtitles
{
	if (self.audio == nil && self.subtitles == nil)
		return nil;
	
	NSString * tmp = (self.audio != nil && [self.audio length] > 0) ? self.audio : @"?";
	
	if (self.subtitles == nil || [self.subtitles length] == 0)
		return tmp;
		
	return [NSString stringWithFormat:@"%@/%@", tmp, self.subtitles];
}

- (void)setAudioSubtitles:(NSString *)str
{
	NSArray * components = [str componentsSeparatedByString:@"/"];
	self.audio = [components objectAtIndex:0];
	
	if ([components count] > 1)
		self.subtitles = [components objectAtIndex:1];
	else
		self.subtitles = nil;
}

@end
