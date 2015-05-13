//
//  AutoSizeCell.m
//  AutoSizingTableCells
//
//  Created by Brian Mancini on 7/26/14.
//  Copyright (c) 2014 RedTurn. All rights reserved.
//

#import "AutoSizeCell.h"


@implementation AutoSizeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.images = [[NSMutableArray alloc] init];
        
        [self setupSubviews];

    }
    
    return self;
}

-(void)setupSubviews
{
    self.category = [UILabel new];
    self.category.lineBreakMode = NSLineBreakByWordWrapping;
    self.category.numberOfLines = 0;
    self.category.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.pastTense = [UILabel new];
    self.pastTense.lineBreakMode = NSLineBreakByWordWrapping;
    self.pastTense.numberOfLines = 0;
    self.pastTense.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.contentHolder = [UIView new];
    self.contentHolder.backgroundColor = [UIColor blueColor];
    self.contentHolder.translatesAutoresizingMaskIntoConstraints = NO;
 
    
    [self.contentHolder addSubview:self.category];
    [self.contentHolder addSubview:self.pastTense];
    NSLog(@"current array of images %@", self.images);

    
    [self.contentView addSubview:self.contentHolder];
    
    NSDictionary *viewDictionary = @{@"categoryView":self.category,
                                     @"pastTenseView":self.pastTense,
                                     @"contentHolder":self.contentHolder
                                     };
    
    [self.contentHolder addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[categoryView]|" options:0 metrics:nil views:viewDictionary]];
    [self.contentHolder addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[pastTenseView]|" options:0 metrics:nil views:viewDictionary]];
    [self.contentHolder addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[categoryView]-5-[pastTenseView]|" options:0 metrics:nil views:viewDictionary]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[contentHolder]-10-|" options:0 metrics:nil views:viewDictionary]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[contentHolder]-5-|" options:0 metrics:nil views:viewDictionary]];
    
    // Add images
    for (NSString *imageName in @[@"gallery_1",@"gallery_2",@"gallery_3"]) {
 
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];

        button.backgroundColor = [UIColor blackColor];
        
        [self.contentHolder addSubview:button];
        
        
        [button addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[imageView(100)]" options:0 metrics:nil views:@{@"imageView":button}]];
        [button addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[imageView(100)]" options:0 metrics:nil views:@{@"imageView":button}]];
        
        [self.contentHolder addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[imageView]" options:0 metrics:nil views:@{@"imageView":button}]];
        [self.contentHolder addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[pastTenseView]-5-[imageView]" options:0 metrics:nil views:@{@"pastTenseView":self.pastTense,@"imageView":button}]];
        
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // Make sure the contentView does a layout pass here so that its subviews have their frames set, which we
    // need to use to set the preferredMaxLayoutWidth below.
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    
    // Set the preferredMaxLayoutWidth of the mutli-line bodyLabel based on the evaluated width of the label's frame,
    // as this will allow the text to wrap correctly, and as a result allow the label to take on the correct height.
    self.category.preferredMaxLayoutWidth = CGRectGetWidth(self.category.frame);
    self.pastTense.preferredMaxLayoutWidth = CGRectGetWidth(self.pastTense.frame);
}

@end
