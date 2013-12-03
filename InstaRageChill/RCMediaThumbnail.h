//
//  RCMediaThumbnail.h
//  InstaRageChill
//
//  Created by Joseph McArthur Gill on 12/2/13.
//  Copyright (c) 2013 Joseph McArthur Gill. All rights reserved.
//

#import "JSONModel.h"

@protocol RCMediaThumbnail @end

@interface RCMediaThumbnail : JSONModel

@property (strong, nonatomic) NSURL* url;
@property (assign, nonatomic) int width;
@property (assign, nonatomic) int height;
@property (strong, nonatomic) NSString* time;

@end
