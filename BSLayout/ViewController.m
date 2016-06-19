//
//  ViewController.m
//  BSLayout
//
//  Created by kai on 16/1/13.
//  Copyright © 2016年 BSUIKit. All rights reserved.
//

#import "ViewController.h"
#import "BSXmlLayout.h"
#import "BSVLayout.h"

#import "UIView+BSLayout.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSLog(@"start create.");
    UIView *view = [BSXmlLayout createFromXml:@"mainview.xml" owner:self];
    NSLog(@"finish create.");
    
    BSVLayout *layout = [[BSVLayout alloc] init];
    layout.rect = self.view.bounds;
    [layout addLayoutItem:view];
    
    [self.view setLayout:layout];
    [self.view addSubview:view];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    NSLog(@"begin layout.");
    [self.view bsLayout];
    NSLog(@"finish layout.");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LayoutCell"];
    if (!cell) {
        cell = (UITableViewCell *)[BSXmlLayout createFromXml:@"cell.xml" owner:nil];
    } else {
        return cell;
    }
    return cell;
    
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
@end
