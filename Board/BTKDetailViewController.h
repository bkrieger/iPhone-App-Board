//
//  BTKDetailViewController.h
//  Board
//
//  Created by Brandon Krieger on 11/5/12.
//  Copyright (c) 2012 Brandon Krieger. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BTKDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UITextView *bodyLabel;

@end
