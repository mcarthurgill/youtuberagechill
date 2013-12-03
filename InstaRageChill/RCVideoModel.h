//
//  RCVideoModel.h
//  InstaRageChill
//
//  Created by Joseph McArthur Gill on 12/2/13.
//  Copyright (c) 2013 Joseph McArthur Gill. All rights reserved.
//

#import "JSONModel.h"

@interface RCVideoModel : JSONModel

@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* link;
@property (strong, nonatomic) NSString* thumbnail;


@end
