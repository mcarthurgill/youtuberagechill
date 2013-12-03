//
//  RCDetailViewController.h
//  InstaRageChill
//
//  Created by Joseph McArthur Gill on 12/2/13.
//  Copyright (c) 2013 Joseph McArthur Gill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCVideoModel.h"

@interface RCDetailViewController : UIViewController


@property (strong, nonatomic) RCVideoModel* video;
@property (strong, nonatomic) IBOutlet UIWebView *webView;


@end
