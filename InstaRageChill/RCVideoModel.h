//
//  RCVideoModel.h
//  InstaRageChill
//
//  Created by Joseph McArthur Gill on 12/2/13.
//  Copyright (c) 2013 Joseph McArthur Gill. All rights reserved.
//

#import "JSONModel.h"
#import "RCVideoLink.h"
#import "RCMediaThumbnail.h"

@interface RCVideoModel : JSONModel

@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSArray<RCVideoLink>* link;
@property (strong, nonatomic) NSArray<RCMediaThumbnail>* thumbnail;


@end
