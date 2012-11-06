//
//  BTKAddPostViewController.h
//  Board
//
//  Created by Brandon Krieger on 11/5/12.
//  Copyright (c) 2012 Brandon Krieger. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BTKAddPostViewController : UIViewController <UITextFieldDelegate,UITextViewDelegate> {
    CGPoint scrollViewDefaultOffset;

}
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *bodyTextView;
- (IBAction)post:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *postButton;
@property (weak, nonatomic) IBOutlet UILabel *loadingLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

UIBarButtonItem* doneButton;