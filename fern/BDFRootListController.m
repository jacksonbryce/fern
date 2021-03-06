#import "Global.h"
#include "BDFRootListController.h"

UIWindow *settingsView;
UIColor *originalTint;

@implementation BDFRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}
	return _specifiers;
}

- (void)loadView {
	[super loadView];
	[UISwitch appearanceWhenContainedIn: self.class, nil].onTintColor = FERN_GREEN;
	[UISegmentedControl appearanceWhenContainedIn: self.class, nil].tintColor = FERN_GREEN;
}

- (void)openSupportMail {
    MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
    [mailer setSubject:@"Tweak Support - Fern"];
    [mailer setToRecipients:[NSArray arrayWithObjects:@"bryce@brycedev.com", nil]];
    [self.navigationController presentViewController:mailer animated:YES completion:nil];
    mailer.mailComposeDelegate = self;
    [mailer release];
}

- (void)openSupportTwitter {
    NSString *user = @"thebryc3isright";
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetbot:"]])
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tweetbot:///user_profile/" stringByAppendingString:user]]];
    else if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitterrific:"]])
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"twitterrific:///profile?screen_name=" stringByAppendingString:user]]];
    else if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetings:"]])
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"tweetings:///user?screen_name=" stringByAppendingString:user]]];
    else if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter:"]])
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"twitter://user?screen_name=" stringByAppendingString:user]]];
    else
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"https://mobile.twitter.com/" stringByAppendingString:user]]];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [self dismissViewControllerAnimated: YES completion: nil];
}

@end
