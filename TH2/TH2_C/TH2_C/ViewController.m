//
//  ViewController.m
//  TH2_C
//
//  Created by Hung Ga 123 on 4/12/16.
//  Copyright © 2016 Hung Ga. All rights reserved.
//

#import "ViewController.h"
#import "ChatViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Messenger";
    self.tableView.delegate =self;
    self.tableView.dataSource =self;
    // Do any additional setup after loading the view, typically from a nib.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Data_2" ofType:@""];
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    NSError *error;
    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
    self.jsonArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    NSLog(@"%@", self.jsonArray);
    
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.jsonArray.count;
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *dict = self.jsonArray[indexPath.row];
    // or  . . . = [self.jsonArray objectAtIndex:indexPath.row] ;
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cellSummary" forIndexPath:indexPath];
    UILabel *lbl = [cell.contentView viewWithTag:3];
    lbl.text = dict[@"description"];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatViewController *chatViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ChatViewController"];
    NSMutableDictionary *dict = self.jsonArray[indexPath.row];
   chatViewController.dictChat =dict;
    [self.navigationController pushViewController:chatViewController animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
