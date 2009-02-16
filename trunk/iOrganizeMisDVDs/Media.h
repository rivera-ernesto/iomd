//
//  Media.h
//  iOrganizeMisDVDs
//
//  Created by 利辺羅 on 09/02/12.
//  Copyright 2009 Piggy Trashing EmperatorZ. All rights reserved.
//

#import <CoreData/CoreData.h>

@class MediaDisc;

@interface Media :  NSManagedObject  
{
}

@property (retain) NSManagedObject * detail;
@property (retain) NSSet* relatedMedia;
@property (retain) NSSet* discs;
@property (retain) NSSet* infos;

@end

@interface Media (CoreDataGeneratedAccessors)
- (void)addRelatedMediaObject:(NSManagedObject *)value;
- (void)removeRelatedMediaObject:(NSManagedObject *)value;
- (void)addRelatedMedia:(NSSet *)value;
- (void)removeRelatedMedia:(NSSet *)value;

- (void)addDiscsObject:(MediaDisc *)value;
- (void)removeDiscsObject:(MediaDisc *)value;
- (void)addDiscs:(NSSet *)value;
- (void)removeDiscs:(NSSet *)value;

- (void)addInfosObject:(NSManagedObject *)value;
- (void)removeInfosObject:(NSManagedObject *)value;
- (void)addInfos:(NSSet *)value;
- (void)removeInfos:(NSSet *)value;

@end

