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
                                                       @"media$group.media$thumbnail":@"thumbnail",
                                                       @"title.$t": @"title",
                                                       }];
}

@end
