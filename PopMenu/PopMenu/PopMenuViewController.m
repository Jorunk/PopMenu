

#import "PopMenuViewController.h"
#import "VerticalButton.h"

@interface PopMenuViewController()

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) NSMutableArray *menuButtons;

@property(assign,nonatomic)NSUInteger upIndex;

@property(assign,nonatomic)NSUInteger downIndex;




@end

@implementation PopMenuViewController

#pragma mark -- 懒加载
- (NSMutableArray *)menuButtons
{
    if (_menuButtons == nil) {
        _menuButtons = [NSMutableArray array];
    }
    return _menuButtons;
}


/**
 设置控制器view，为view添加背景图片
 */
-(void)loadView{
    
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [view setBackgroundColor:[UIColor whiteColor]];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:self.backgroundImage];
    //模糊效果层
    UIView *blurView =[[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    [blurView setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:0.8]];
    
    [imageView  addSubview:blurView];
    [view addSubview:imageView ];
    
    self.view = view;
}

- (void)viewDidLoad {
    
    // 让控制器的view不能被点击
    self.view.userInteractionEnabled = NO;
    
    [super viewDidLoad];
    
    //添加菜单按钮
    [self setupMenu];
    
    //添加底部关闭按钮
    [self addBackButton];
    
    //定时器控制每个按钮弹出的时间
    self.timer = [NSTimer scheduledTimerWithTimeInterval:_buttonDuration target:self selector:@selector(popupMenu) userInfo:nil repeats:YES];
    
    //添加手势点击事件
    UITapGestureRecognizer *touch = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchesBegan:)];
    [self.view addGestureRecognizer:touch];
    
}



- (void)addBackButton{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"shareButtonCancel"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"shareButtonCancelClick"] forState:UIControlStateHighlighted];
    
    button.frame = CGRectMake(self.view.center.x - 150, self.view.frame.size.height - 44, 300, 44);
    [button addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
}

- (void)backClick
{
    [self back];

}


- (void)popupMenu{
    
    if (self.upIndex == self.menuButtons.count) {
        
        [self.timer invalidate];
        
        self.upIndex = 0;
        
        return;
    }
    
    VerticalButton *button = self.menuButtons[self.upIndex];
    
    [self initButtonAnimation:button];
    
    self.upIndex++;
   
}
/**
 为每个按钮添加动画
 */

- (void)initButtonAnimation:(UIButton *)button
{
    [UIView animateWithDuration:_controllerDuration delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        button.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished){
        self.downIndex = self.menuButtons.count - 1;
        // 标语动画执行完毕, 恢复点击事件
        self.view.userInteractionEnabled = YES;
    }];
    
}


/**
 初始化按钮
 */
- (void)setupMenu{
    
    //初始化变量
    int col = 0;
    int row = 0;
    CGFloat ButtonX = 0;
    CGFloat ButtonY = 0;
    
    //每一行有多少按钮
    int cols = 3;
    
    CGFloat width = 90;
    CGFloat margin = ([UIScreen mainScreen].bounds.size.width - cols * width) / (cols + 1);
    CGFloat originY = 300;
    
    for (int i = 0; i < self.imageName.count; i++) {
        VerticalButton *button = [VerticalButton buttonWithType:UIButtonTypeCustom];
        
        UIImage *image = [UIImage imageNamed:self.imageName[i]];
        NSString *title = self.titleArray[i];
        
        [button setImage:image forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateNormal];
        
        col = i % cols;
        row = i / cols;
        
        ButtonX = margin + col * (margin + width);
        ButtonY = row * (margin + width) + originY;
        
        button.frame = CGRectMake(ButtonX, ButtonY, width, width);
        
        button.transform = CGAffineTransformMakeTranslation(0, self.view.bounds.size.height);
        
        button.tag = 100 + i;
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.menuButtons addObject:button];
        
        [self.view addSubview:button];
        
    }
    
}

//点击按钮进行放大动画效果直到消失
- (void)buttonClick:(VerticalButton *)button{
    
    NSLog(@"%ld根据不同的按钮的tag值做什么操作写这里",button.tag);
    
    [UIView animateWithDuration:_controllerDuration animations:^{
        button.transform = CGAffineTransformMakeScale(2.0, 2.0);
        button.alpha = 0;
    }];
    [self back];
}


//设置按钮从后往前下落
- (void)buttonDown{
    
    if (self.downIndex == -1) {
        
        [self.timer invalidate];
        
        return;
    }
    
    VerticalButton *button = self.menuButtons[_downIndex];
    
    [self backAnimation:button];
    
    self.downIndex--;
}

//按钮下滑并返回上一级控制器
- (void)backAnimation:(UIButton *)button
{
    
    [UIView animateWithDuration:_controllerDuration animations:^{
        
        button.transform = CGAffineTransformMakeTranslation(0, self.view.bounds.size.height);
        
    } completion:^(BOOL finished) {
        
        [self dismissViewControllerAnimated:NO completion:nil];
        
    }];
    
}

//点击事件返回上一级控制器
-(void)touchesBegan:(UITapGestureRecognizer *)touches{
    
    [self back];
    
}

//返回上一级控制器
- (void)back
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:_buttonDuration target:self selector:@selector(buttonDown) userInfo:nil repeats:YES];

}


@end
