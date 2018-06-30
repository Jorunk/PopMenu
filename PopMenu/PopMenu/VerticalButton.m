
#import "VerticalButton.h"

@implementation VerticalButton



- (void)awakeFromNib
{
    self.imageView.contentMode = UIViewContentModeCenter;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:12];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //调整图片
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = self.bounds.size.width;
    CGFloat imageH = self.imageView.frame.size.height;
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    //调整文字
    CGFloat lableX = 0;
    CGFloat lableY = self.imageView.frame.size.height;
    CGFloat lableW = self.bounds.size.height;
    CGFloat lableH = self.bounds.size.height - self.titleLabel.frame.origin.y;
    ;
    self.titleLabel.frame = CGRectMake(lableX, lableY, lableW, lableH);
}

@end