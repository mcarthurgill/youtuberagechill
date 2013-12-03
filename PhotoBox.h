//
//  PhotoBox.h
//  InstaRageChill
//
//  Created by Joseph McArthur Gill on 12/2/13.
//  Copyright (c) 2013 Joseph McArthur Gill. All rights reserved.
//

#import "MGBox.h"

@interface PhotoBox : MGBox

+(PhotoBox *)photoBoxForURL:(NSURL*)url title:(NSString*)title;

@property (strong, nonatomic) NSString* titleString;

@end
