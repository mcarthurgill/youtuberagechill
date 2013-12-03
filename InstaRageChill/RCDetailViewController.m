//
//  RCDetailViewController.m
//  InstaRageChill
//
//  Created by Joseph McArthur Gill on 12/2/13.
//  Copyright (c) 2013 Joseph McArthur Gill. All rights reserved.
//

#import "RCDetailViewController.h"

@interface RCDetailViewController ()
- (void)configureView;
@end

@implementation RCDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
