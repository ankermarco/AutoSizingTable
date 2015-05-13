//
//  AutoSizingController.m
//  AutoSizingTableCells
//
//  Created by Brian Mancini on 7/26/14.
//  Copyright (c) 2014 RedTurn. All rights reserved.
//

#import "AutoSizingController.h"
#import "AutoSizeCell.h"
#import "AutoSizeCellContents.h"

@interface AutoSizingController()

@property NSMutableArray *texts;


@end
@implementation AutoSizingController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.texts = [NSMutableArray new];
    AutoSizeCellContents *cellContents = [[AutoSizeCellContents alloc] init];
    cellContents.category = @"Category One";
    cellContents.pastTense = @"This is some long text that should wrap. It is multiple long sentences that may or may not have spelling and grammatical errors. Yep it should wrap quite nicely and serve as a nice example!";
    
    [cellContents.images addObject:@"gallery_1"];
    [cellContents.images addObject:@"gallery_2"];
    [cellContents.images addObject:@"gallery_3"];
    [self.texts addObject:cellContents];

    AutoSizeCellContents *cellContents2 = [[AutoSizeCellContents alloc] init];
    cellContents2.category = @"Category Two";
    cellContents2.pastTense = @"This is some long text that should wrap. It is multiple long sentences that may or may not have spelling and grammatical errors.";
    [cellContents2.images addObject:@"gallery_4"];
    [cellContents2.images addObject:@"gallery_5"];

    [self.texts addObject:cellContents2];
    
    AutoSizeCellContents *cellContents3 = [[AutoSizeCellContents alloc] init];
    cellContents3.category = @"Category Three";
    cellContents3.pastTense = @"This is some long text that should wrap. It is multiple long sentences that may or may not have spelling and grammatical errors. Yep it should wrap quite nicely and serve as a nice example! This is some long text that should wrap. It is multiple long sentences that may or may not have spelling and grammatical errors. Yep it should wrap quite nicely and serve as a nice example! This is some long text that should wrap. It is multiple long sentences that may or may not have spelling and grammatical errors. Yep it should wrap quite nicely and serve as a nice example!";
    [cellContents3.images addObject:@"gallery_6"];
    [cellContents3.images addObject:@"gallery_7"];

    [self.texts addObject:cellContents3];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.texts.count;
}

- (NSString *)getCategoryAtIndexPath:(NSIndexPath *)indexPath
{
    return [(AutoSizeCellContents *)[self.texts objectAtIndex:indexPath.row] category];
}

- (NSString *)getPastTenseAtIndexPath:(NSIndexPath *)indexPath
{
    return [(AutoSizeCellContents *)[self.texts objectAtIndex:indexPath.row] pastTense];
}

- (NSArray *)getImagesAtIndexPath:(NSIndexPath *)indexPath
{
    return [(AutoSizeCellContents *)[self.texts objectAtIndex:indexPath.row] images];
}

-(void)configureCell:(AutoSizeCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    // Configure the cell for this indexPath
    cell.category.text = [self getCategoryAtIndexPath:indexPath];
    cell.pastTense.text = [self getPastTenseAtIndexPath:indexPath];

    for (NSString *imageName in [self getImagesAtIndexPath:indexPath]) {
        NSLog(@"image name %@",imageName);
        [cell.images addObject:@"hellp"];
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Create a reusable cell
    AutoSizeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"plerp"];
    if(!cell) {
        cell = [[AutoSizeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"plerp"];
        [self configureCell:cell atIndexPath:indexPath];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AutoSizeCell *cell = [[AutoSizeCell alloc] init];
    [self configureCell:cell atIndexPath:indexPath];
    
    // Do the layout pass on the cell, which will calculate the frames for all the views based on the constraints
    // (Note that the preferredMaxLayoutWidth is set on multi-line UILabels inside the -[layoutSubviews] method
    // in the UITableViewCell subclass
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    // Get the actual height required for the cell
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
    // Add an extra point to the height to account for the cell separator, which is added between the bottom
    // of the cell's contentView and the bottom of the table view cell.
    height += 1;
    
    return height;
}

@end
