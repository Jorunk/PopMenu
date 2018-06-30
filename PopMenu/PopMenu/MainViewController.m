
#import "MainViewController.h"
#import "PopMenuViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController


- (IBAction)publishClick:(id)sender {
    PopMenuViewController *pop = [[PopMenuViewController alloc] init];
    //选择想用的图片
    pop.backgroundImage = [UIImage imageNamed:@"love.jpg"];
    //选择当前背景为背景图片
//    pop.backgroundImage = [self imageWithView:self.view];
    pop.imageName = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    pop.titleArray = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    pop.controllerDuration = 0.8;
    pop.buttonDuration = 0.125;
    
    [self presentViewController:pop animated:NO completion:nil];
}


- (UIImage *)imageWithView:(UIView *)view
{
    CGSize size = CGSizeMake(view.bounds.size.width, view.bounds.size.height*0.9);
    
    // 开启位图上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    // 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 把控件上的图层渲染到上下文,layer只能渲染
    [view.layer renderInContext:ctx];
    
    // 生成新图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}

@end
