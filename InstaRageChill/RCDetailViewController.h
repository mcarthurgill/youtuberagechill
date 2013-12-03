//
//  RCDetailViewController.h
//  InstaRageChill
//
//  Created by Joseph McArthur Gill on 12/2/13.
//  Copyright (c) 2013 Joseph McArthur Gill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
