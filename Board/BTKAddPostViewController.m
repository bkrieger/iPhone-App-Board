//
//  BTKAddPostViewController.m
//  Board
//
//  Created by Brandon Krieger on 11/5/12.
//  Copyright (c) 2012 Brandon Krieger. All rights reserved.
//

#import "BTKAddPostViewController.h"

@interface BTKAddPostViewController ()

@end

@implementation BTKAddPostViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(done)];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)post:(id)sender {
    NSString *url = @"http://cis195-messages.herokuapp.com/messages";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"POST"];
    
    NSString *data = [NSString stringWithFormat:@"message[title]=%@&message[body]=%@", _titleTextField.text, _bodyTextView.text];
    [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
    _loadingLabel.text = @"Loading...";
    [self.postButton setHidden:YES];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    _loadingLabel.text = @"";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Error" message:@"Unable to connect with server. Please check your internet connection." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [self.postButton setHidden:NO];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.navigationItem.rightBarButtonItem = doneButton;
    scrollViewDefaultOffset = self.scrollView.contentOffset;
    CGPoint point;
    CGRect bounds = [self.bodyTextView bounds];
    bounds = [self.bodyTextView convertRect:bounds toView:self.scrollView];
    point = bounds.origin;
    point.x = 0;
    point.y = point.y - 10;
    [self.scrollView setContentOffset:point animated:YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    self.navigationItem.rightBarButtonItem = nil;
    [self.scrollView setContentOffset:scrollViewDefaultOffset animated:YES];
}

- (void)done {
    [self.bodyTextView resignFirstResponder];
    [self.titleTextField resignFirstResponder];
    self.navigationItem.rightBarButtonItem = nil;
}

@end
