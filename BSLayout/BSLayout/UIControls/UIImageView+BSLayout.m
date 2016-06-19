//
//  UIImageView+BSLayout.m
//  MakeFriends
//
//  Created by kai on 16/2/23.
//
//

#import "UIImageView+BSLayout.h"

@implementation UIImageView(BSLayout)

- (void)setImageName:(NSString *)imageName
{
    self.image = [UIImage imageNamed:imageName];
}

- (NSString *)imageName
{
    return nil;
}
@end
