//
//  ViewController.m
//  ProjectChihiro
//
//  Created by Thiago Nitschke Simões on 16/03/20.
//  Copyright © 2020 thnitschke. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController () <UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *movieTitles;
}

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    movieTitles = [NSMutableArray arrayWithArray: @[@"a",@"b",@"c"]];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return movieTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"cell"];
    return cell;
}


@end

