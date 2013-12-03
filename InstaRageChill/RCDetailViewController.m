//
//  RCDetailViewController.m
//  InstaRageChill
//
//  Created by Joseph McArthur Gill on 12/2/13.
//  Copyright (c) 2013 Joseph McArthur Gill. All rights reserved.
//

#import "RCDetailViewController.h"

@interface RCDetailViewController ()
{
    IBOutlet UIWebView* webView;
}

@end

@implementation RCDetailViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    RCVideoLink* link = self.video.link[0];
    
    NSString* videoId = nil;
    
    NSArray *queryComponents = [link.href.query componentsSeparatedByString:@"&amp;"];
    for (NSString* pair in queryComponents) {
        NSArray* pairComponents = [pair componentsSeparatedByString:@"="];
        if ([pairComponents[0] isEqualToString:@"v"]) {
            //fetch the video id and exit the loop
            videoId = pairComponents[1];
            break;
        }
    }
    
    if (!videoId) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Video ID not found in video URL" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles: nil]show];
        return;
    }
    
    NSLog(@"Embed video id: %@", videoId);
    
    NSString *htmlString = @"<html><head>\
    <meta name = \"viewport\" content = \"initial-scale = 1.0, user-scalable = no, width = 320\"/></head>\
    <body style=\"background:#000;margin-top:0px;margin-left:0px\">\
    <iframe id=\"ytplayer\" type=\"text/html\" width=\"320\" height=\"240\"\
    src=\"http://www.youtube.com/embed/%@?autoplay=1\"\
    frameborder=\"0\"/>\
    </body></html>";
    
    htmlString = [NSString stringWithFormat:htmlString, videoId, videoId];
    
    [webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:@"http://www.youtube.com"]];

    
}

@end