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
    
    //scroll view
    scroller.contentLayoutMode = MGLayoutGridStyle;
    scroller.bottomPadding = 8;
    scroller.backgroundColor = [UIColor colorWithWhite:0.25 alpha:1];
    
    //search box
    searchBox = [MGBox boxWithSize:CGSizeMake(320,44)];
    searchBox.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1];
    
    //search text field
    UITextField* fldSearch = [[UITextField alloc] initWithFrame:CGRectMake(4,4,312,35)];
    fldSearch.borderStyle = UITextBorderStyleRoundedRect;
    fldSearch.backgroundColor = [UIColor whiteColor];
    fldSearch.font = [UIFont systemFontOfSize:24];
    fldSearch.delegate = self;
    fldSearch.placeholder = @"Search YouTube...";
    fldSearch.clearButtonMode = UITextFieldViewModeAlways;
    fldSearch.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [searchBox addSubview: fldSearch];
    
    //add search box
    [scroller.boxes addObject: searchBox];
    
    [scroller layoutWithSpeed:0.3 completion:nil];
}

//runs when enter is pressed
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self searchYoutubeVideosForTerm:textField.text];
    return YES;
}


-(void)searchYoutubeVideosForTerm:(NSString*)term
{
    NSLog(@"Searching for '%@'...", term);
    
    //URL escape the term
    term = [term stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString* searchCall = [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/search?q=%@&maxResults=20&videoSyndicated=true&videoEmbeddable=true&format=5&part=snippet&type=video&safeSearch=none&key=AIzaSyAnRB0cI8KKaA2WHjUlY-2uy85FySbrHQs", term];
    
    [JSONHTTPClient getJSONFromURLWithString: searchCall
                                  completion:^(NSDictionary *json, JSONModelError *err) {
                                      NSLog(@"Got JSON back from Youtube: %@", json);
                                      videos = [RCVideoModel arrayOfModelsFromDictionaries:
                                                json[@"items"]
                                                ];
                                      
                                      if (videos) {
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



-(void)showVideos
{
    //get rid of videos present
    [scroller.boxes removeObjectsInRange:NSMakeRange(1, scroller.boxes.count-1)];
    
    //add boxes for all videos
    for (int i=0;i<videos.count;i++) {
        
        //get the data
        RCVideoModel* video = videos[i];
        NSURL *thumb = [[NSURL alloc] initWithString:video.thumbnail];
        
        //create a photobox box
        PhotoBox *box = [PhotoBox photoBoxForURL:thumb title:video.title];
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
