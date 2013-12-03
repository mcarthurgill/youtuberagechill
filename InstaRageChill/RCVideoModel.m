//
//  RCVideoModel.m
//  InstaRageChill
//
//  Created by Joseph McArthur Gill on 12/2/13.
//  Copyright (c) 2013 Joseph McArthur Gill. All rights reserved.
//

#import "RCVideoModel.h"

@implementation RCVideoModel

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"snippet.thumbnails.default.url":@"thumbnail",
                                                       @"snippet.title": @"title",
                                                       @"id.videoId": @"link"
                                                       }];
}

@end
