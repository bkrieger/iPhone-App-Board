//
//  BTKDetailViewController.m
//  Board
//
//  Created by Brandon Krieger on 11/5/12.
//  Copyright (c) 2012 Brandon Krieger. All rights reserved.
//

#import "BTKDetailViewController.h"

@interface BTKDetailViewController ()
- (void)configureView;
@end

@implementation BTKDetailViewController

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
        self.titleLabel.text = [self.detailItem objectForKey:@"title"];
        self.bodyLabel.text = [self.detailItem objectForKey:@"body"];
        NSString *timestamp = [self.detailItem objectForKey:@"updated_at"];
        NSString *year = [timestamp substringWithRange: NSMakeRange(0, 4)];
        NSString *month = [timestamp substringWithRange: NSMakeRange(5, 2)];
        NSString *day = [timestamp substringWithRange: NSMakeRange(8, 2)];
        NSString *hour = [timestamp substringWithRange: NSMakeRange(11, 2)];
        NSString *minute = [timestamp substringWithRange: NSMakeRange(14, 2)];
        self.timeLabel.text = [NSString stringWithFormat:@"%@:%@ GMT on %@/%@/%@",hour,minute,month,day,year];
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyy-MM-dd hh:mm:ss a"];
        NSDateFormatter *rfc3339DateFormatter = [[NSDateFormatter alloc] init];
        NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        
        [rfc3339DateFormatter setLocale:enUSPOSIXLocale];
        [rfc3339DateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
        [rfc3339DateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        
        // Convert the RFC 3339 date time string to an NSDate.
        NSDate *date = [rfc3339DateFormatter dateFromString:timestamp];
        
        NSString *userVisibleDateTimeString;
        if (date != nil) {
            // Convert the date object to a user-visible date string.
            NSDateFormatter *userVisibleDateFormatter = [[NSDateFormatter alloc] init];
            assert(userVisibleDateFormatter != nil);
            
            [userVisibleDateFormatter setDateStyle:NSDateFormatterShortStyle];
            [userVisibleDateFormatter setTimeStyle:NSDateFormatterShortStyle];
            
            userVisibleDateTimeString = [userVisibleDateFormatter stringFromDate:date];
        }
        self.timeLabel.text = userVisibleDateTimeString;
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
