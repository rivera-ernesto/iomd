// 
//  MediaDetail.m
//  iOrganizeMisDVDs
//
//  Created by 利辺羅 on 09/02/13.
//  Copyright 2009 Piggy Trashing EmperatorZ. All rights reserved.
//

#import "MediaDetail.h"

#import "Media.h"

@implementation MediaDetail 

@dynamic image;
@dynamic releaseDate;
@dynamic rating;
@dynamic aspectRatio;
@dynamic certification;
@dynamic comments;
@dynamic country;
@dynamic genre;
@dynamic language;
@dynamic otherTitles;
@dynamic synopsis;
@dynamic tagLine;
@dynamic title;
@dynamic year;
@dynamic media;
@dynamic mediaInfo;

- (NSData *)image
{
	NSData * data = [self primitiveValueForKey:@"image"];
	
	// There's an image?
	if (data != nil)
	{
		return data;
	}
	
	static NSData * noData;
	if (noData != nil)
	{
		return noData;
	}
	
	NSLog(@"Reading nonimage");
	NSString* path = [[NSBundle mainBundle]
					  pathForResource:@"nonimage" ofType:@"png"];
	noData = [[NSData alloc] initWithContentsOfFile:path];
	
	return noData;
}

@end


