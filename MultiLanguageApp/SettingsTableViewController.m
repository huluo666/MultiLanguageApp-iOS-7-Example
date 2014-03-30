//
//  SettingsTableViewController.m
//  MultiLanguageApp
//
//  Created by Hasan_Sa on 3/30/14.
//  Copyright (c) 2014 Hasan_Sa. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "LocalisatorViewController.h"

@interface SettingsTableViewController ()
{
    UIStoryboard *storyboard;
}
@property (nonatomic,strong) NSDictionary *settingsDic;

@end

@implementation SettingsTableViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _settingsDic = @{LOCALIZATION(@"GeneralSettings"):LOCALIZATION(@"LanguageSettings")};
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.settingsDic allValues].count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
   return [self.settingsDic allKeys].count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.settingsDic allKeys][section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...

    cell.textLabel.text = [self.settingsDic allValues][indexPath.section];
    return cell;
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *srotyboardIdentifier = @"localisatorVC";
    LocalisatorViewController *localisatorVC = [storyboard instantiateViewControllerWithIdentifier:srotyboardIdentifier];
    [self.navigationController pushViewController:localisatorVC animated:YES];
}

@end
