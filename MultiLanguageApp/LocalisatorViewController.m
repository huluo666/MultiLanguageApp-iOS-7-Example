//
//  LocalisatorViewController.m
//  CustomLocalisator
//
//  Created by Michael Azevedo on 06/03/2014.
//
//

#import "LocalisatorViewController.h"
#import "Localisator.h"

@interface LocalisatorViewController ()

@property (nonatomic, weak) IBOutlet UITableView *tableViewLanguages;

@property (nonatomic, strong) NSArray * allExtintions;

@end

@implementation LocalisatorViewController

#pragma mark - Init methods

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
    
    self.allExtintions = [[[Localisator sharedInstance] availableLanguages] copy];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveLanguageChangedNotification:)
                                                 name:kNotificationLanguageChanged
                                               object:nil];
    [self configureViewFromLocalisation];
}

-(void)configureViewFromLocalisation
{
    self.title = LOCALIZATION(@"LocalisatorViewTitle");
    
    [self.tableViewLanguages    reloadData];


}

#pragma mark - Notification methods

- (void) receiveLanguageChangedNotification:(NSNotification *) notification
{
    if ([notification.name isEqualToString:kNotificationLanguageChanged])
    {
        [self configureViewFromLocalisation];
    }
}

#pragma mark - UITableViewDataSource protocol conformance

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.allExtintions == nil)
        return 0;
    
    return [self.allExtintions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [self.tableViewLanguages dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSString *curLan = [[Localisator sharedInstance] currentLanguage];
    
    if (nil == curLan && 0 == indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    } else {
        
        if ([curLan isEqualToString:_allExtintions[indexPath.row]]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }

    cell.imageView.image = [UIImage imageNamed:self.allExtintions[indexPath.row]];
    cell.textLabel.text = LOCALIZATION(self.allExtintions[indexPath.row]);
    
    /* Now that the cell is configured we return it to the table view so that it can display it */
    
    return cell;
}

#pragma mark - UITableViewDelegate protocol conformance

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([[Localisator sharedInstance] setLanguage:self.allExtintions[indexPath.row]])
    {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:LOCALIZATION(@"CurrentLanguage") delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

#pragma mark - Memory management

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationLanguageChanged object:nil];
}

@end
