

#import <UIKit/UIKit.h>

@interface PopMenuViewController : UIViewController
/** 背景图片 */
@property(nonatomic,strong) UIImage *backgroundImage;
/** 存储button的title */
@property(nonatomic,strong) NSArray *titleArray;
/** 存储button的image */
@property(nonatomic,strong) NSArray *imageName;
/** 控制器动画时间 */
@property(assign, nonatomic)NSTimeInterval controllerDuration;
/** 按钮动画时间 */
@property(assign, nonatomic)NSTimeInterval buttonDuration;

@end
