//
//  TestVC.m
//  FPThemeKit_Example
//
//  Created by admin on 2025/5/6.
//  Copyright © 2025 fanpeng. All rights reserved.
//

#import "TestVC.h"
#import <FPThemeKit/FPThemeKit.h>
#import "TableCell.h"
//#import "GMViewControllerTest-Swift.h"  // 这个文件名为：ProductModuleName + -Swift.h
#import "FPThemeKit_Example-Swift.h"

@interface TestVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TestVC
- (IBAction)swiftJump:(id)sender {
    [self.navigationController pushViewController:GMViewControllerTest.new animated:YES];

}

- (IBAction)push:(id)sender {
    [self.navigationController pushViewController:TestVC.new animated:YES];
}
- (IBAction)normal:(id)sender {
    [FPThemeManager.share updateTheme:@"NORMAL"];

}
- (IBAction)night:(id)sender {
    [FPThemeManager.share updateTheme:@"NIGHT"];

}
- (IBAction)red:(id)sender {
    [FPThemeManager.share updateTheme:@"RED"];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.themeKit.tintColor = kColorWithKey(@"TINT");

    UINib *nib = [UINib nibWithNibName:@"TableCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"MyCustomCell"];

}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCustomCell" forIndexPath:indexPath];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}
@end
