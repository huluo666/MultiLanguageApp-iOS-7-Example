//
//  HomeViewController.m
//  MultiLanguageApp
//
//  Created by Hasan_Sa on 3/30/14.
//  Copyright (c) 2014 Hasan_Sa. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *currentLanguageLabel;

@end

@implementation HomeViewController

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
    [self configureViewFromLocalisation];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveLanguageChangedNotification:)
                                                 name:kNotificationLanguageChanged
                                               object:nil];
    // Do any additional setup after loading the view.
}

- (void)configureViewFromLocalisation
{
    self.currentLanguageLabel.text = LOCALIZATION(@"CurrentLanguage");
    self.imageView.image = [UIImage imageNamed:LOCALIZATION(@"LanguageExtiontion")];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationLanguageChanged object:nil];
}
#pragma mark - Notification methods

- (void)receiveLanguageChangedNotification:(NSNotification *) notification
{
    if ([notification.name isEqualToString:kNotificationLanguageChanged])
    {
        [self configureViewFromLocalisation];
    }
}


@end
