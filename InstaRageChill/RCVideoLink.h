//
//  RCVideoLink.h
//  InstaRageChill
//
//  Created by Joseph McArthur Gill on 12/2/13.
//  Copyright (c) 2013 Joseph McArthur Gill. All rights reserved.
//

#import "JSONModel.h"

@protocol RCVideoLink @end

@interface RCVideoLink : JSONModel

@property (strong, nonatomic) NSURL* href;

@end
