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

@dynamic comments;
@dynamic year;
@dynamic image;
@dynamic rating;
@dynamic certification;
@dynamic country;
@dynamic synopsis;
@dynamic tagLine;
@dynamic releaseDate;
@dynamic genre;
@dynamic title;
@dynamic aspectRatio;
@dynamic language;
@dynamic media;
@dynamic mediaInfo;

- (NSData *)image
{
	NSLog(@"IMAAGE");
	
	NSData * data = [self primitiveValueForKey:@"image"];
	
	// There's an image?
	if (data != nil)
	{
		NSLog(@"has data");
		return data;
	}
	
	static NSData * noData;
	if (noData != nil)
	{
		NSLog(@"has default");
		return noData;
	}
	
	NSLog(@"had no default");
	NSString* path = [[NSBundle mainBundle]
					  pathForResource:@"nonimage" ofType:@"png"];
	noData = [[NSData alloc] initWithContentsOfFile:path];
	
	return noData;
}

@end
