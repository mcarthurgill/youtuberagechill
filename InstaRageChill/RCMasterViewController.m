//
//  RCMasterViewController.m
//  InstaRageChill
//
//  Created by Joseph McArthur Gill on 12/2/13.
//  Copyright (c) 2013 Joseph McArthur Gill. All rights reserved.
//

#import "RCMasterViewController.h"
#import "RCDetailViewController.h"
#import "RCVideoModel.h"
#import "PhotoBox.h"


#import "MGBox.h"
#import "MGScrollView.h"
#import "JSONModelLib.h"

@interface RCMasterViewController () <UITextFieldDelegate> {
    IBOutlet MGScrollView* scroller;
    MGBox *searchBox;
    NSArray* videos;
    
}
@end

@implementation RCMasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //setup the scroll view
    scroller.contentLayoutMode = MGLayoutGridStyle;
    scroller.bottomPadding = 8;
    scroller.backgroundColor = [UIColor colorWithWhite:0.25 alpha:1];
    
    //setup the search box
    searchBox = [MGBox boxWithSize:CGSizeMake(320,44)];
    searchBox.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1];
    
    //setup the search text field
    UITextField* fldSearch = [[UITextField alloc] initWithFrame:CGRectMake(4,4,312,35)];
    fldSearch.borderStyle = UITextBorderStyleRoundedRect;
    fldSearch.backgroundColor = [UIColor whiteColor];
    fldSearch.font = [UIFont systemFontOfSize:24];
    fldSearch.text = @"Ed Sheeran";
    fldSearch.delegate = self;
    fldSearch.placeholder = @"Search YouTube...";
    fldSearch.clearButtonMode = UITextFieldViewModeAlways;
    fldSearch.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [searchBox addSubview: fldSearch];
    
    //add search box
    [scroller.boxes addObject: searchBox];
    
    [scroller layoutWithSpeed:0.3 completion:nil];
    
    //fire up the first search
    [self searchYoutubeVideosForTerm: fldSearch.text];
}

-(void)searchYoutubeVideosForTerm:(NSString*)term
{
    NSLog(@"Searching for '%@'...", term);
    
    //URL escape the term
    term = [term stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString* searchCall = [NSString stringWithFormat:@"http://gdata.youtube.com/feeds/api/videos?q=%@&max-results=20&alt=json", term];
    
    [JSONHTTPClient getJSONFromURLWithString: searchCall
                                  completion:^(NSDictionary *json, JSONModelError *err) {
                                      //got JSON back
                                      NSLog(@"Got JSON back from Youtube: %@", json);
                                      videos = [RCVideoModel arrayOfModelsFromDictionaries:
                                                json[@"feed"][@"entry"]
                                                ];
                                      
                                      if (videos) {
                                        //show the videos
                                        [self showVideos];
                                         NSLog(@"Loaded models"); 
                                      }

                                      if (err) {
                                          [[[UIAlertView alloc] initWithTitle:@"Error"
                                                                      message:[err localizedDescription]
                                                                     delegate:nil
                                                            cancelButtonTitle:@"Close"
                                                            otherButtonTitles: nil] show];
                                          return;
                                      }
                                  }];

}

//fire up API search on Enter pressed
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self searchYoutubeVideosForTerm:textField.text];
    return YES;
}

-(void)showVideos
{
    //clean the old videos
    [scroller.boxes removeObjectsInRange:NSMakeRange(1, scroller.boxes.count-1)];
    
    //add boxes for all videos
    for (int i=0;i<videos.count;i++) {
        
        //get the data
        RCVideoModel* video = videos[i];
        RCMediaThumbnail* thumb = video.thumbnail[0];
        
        //create a box
        PhotoBox *box = [PhotoBox photoBoxForURL:thumb.url title:video.title];
        box.onTap = ^{
            [self performSegueWithIdentifier:@"videoViewSegue" sender:video];
        };
        
        //add the box
        [scroller.boxes addObject:box];
    }
    
    //re-layout the scroll view
    [scroller layoutWithSpeed:0.3 completion:nil];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    RCDetailViewController* controller = segue.destinationViewController;
    controller.video = sender;
}

@end
