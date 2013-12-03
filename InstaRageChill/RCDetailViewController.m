//
//  RCDetailViewController.m
//  InstaRageChill
//
//  Created by Joseph McArthur Gill on 12/2/13.
//  Copyright (c) 2013 Joseph McArthur Gill. All rights reserved.
//

#import "RCDetailViewController.h"
#import "JSONModelLib.h"

@interface RCDetailViewController ()

@end

@implementation RCDetailViewController

@synthesize webView, video;

-(void)viewDidLoad
{
    [super viewDidLoad];
        
    NSString* videoId = self.video.link;
    
    if (!videoId) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Video ID not found in video URL" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles: nil]show];
        return;
    }
    
    NSLog(@"Embed video id: %@", videoId);
    
//    NSString *htmlString = @"<html><head>\
//    <meta name = \"viewport\" content = \"initial-scale = 1.0, user-scalable = no, width = 320\"/></head>\
//    <body style=\"background:#000;margin-top:0px;margin-left:0px\">\
//    <iframe id=\"ytplayer\" type=\"text/html\" width=\"320\" height=\"240\"\
//    src=\"http://www.youtube.com/embed/%@?autoplay=1\"\
//    frameborder=\"0\"/>\
//    </body></html>";
//    
//    htmlString = [NSString stringWithFormat:htmlString, videoId, videoId];
//    
//    [webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:@"http://www.youtube.com"]];
    
    NSError *error = nil;
    
    //Prepare the HTML from the template
    NSString *template = [NSString stringWithContentsOfFile:
                          [[NSBundle mainBundle]
                           pathForResource:@"YouTubeTemplate" ofType:@"txt"]
                                                   encoding:NSUTF8StringEncoding
                                                      error:&error];
    NSString *htmlStr = [NSString stringWithFormat: template,
                         webView.frame.size.width, webView.frame.size.height,
                         webView.frame.size.width, webView.frame.size.height,
                         videoId];
    
    //Write the HTML file to disk
    NSString *tmpDir = NSTemporaryDirectory();
    NSString *tmpFile = [tmpDir
                         stringByAppendingPathComponent: @"video.html"];
    [htmlStr writeToFile: tmpFile atomically:TRUE
                encoding: NSUTF8StringEncoding error:NULL];
    //Enable autoplay
    webView.mediaPlaybackRequiresUserAction = NO;
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.ragechill.com/embed/%@?width=%f&height=%f", videoId, webView.frame.size.width, webView.frame.size.height]]]];
    
    //Load the HTML
//    [webView loadRequest:[NSURLRequest requestWithURL:
//                                    [NSURL fileURLWithPath:tmpFile isDirectory:NO]]];
    //Autoplay doesn't work with loadHTMLString
    //[self.webView loadHTMLString:htmlStr baseURL:nil];
    
    
}

@end