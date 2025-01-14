//
//  ViewController.m
//  LineChart
//
//  Created by warmStep on 2021/9/11.
//

#import "ViewController.h"
#import "ORLineChartView.h"

@interface ViewController () <ORLineChartViewDataSource, ORLineChartViewDelegate>

@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, strong) ORLineChartView *lineChartView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    _datas = @[@(0.12), @(0.2),@(0.497),@(0.274),@(2.0),@(1.5),@(0.297),@(0.274),@(0.358),@(0.235),@(0.18),@(0.8),@(0.5),@(0.12),@(0.163)];
//    _datas = @[@(0.12)];
//        _datas = @[@(0), @(2), @(3), @(14)];
    
    
    _lineChartView = [[ORLineChartView alloc] initWithFrame:CGRectMake(20, 0, [UIScreen mainScreen].bounds.size.width-20, 350)];
    _lineChartView.config.gradientLocations = @[@(0.8), @(1.2)];
    _lineChartView.xValue = @[@(2021), @(2021), @(2021), @(2021), @(2021),@(2021), @(2021), @(2021), @(2021), @(2021), @(2021), @(2021), @(2021), @(2021), @(2021)];
    _lineChartView.defaultSelectIndex = 1;
    _lineChartView.config.showShadowLine = NO;
    _lineChartView.backgroundColor = UIColor.groupTableViewBackgroundColor;
    _lineChartView.layer.cornerRadius = 10;
    _lineChartView.layer.masksToBounds = YES;
    _lineChartView.config.xTitleColor = UIColor.grayColor;
    _lineChartView.config.chartLineColor = [UIColor grayColor];
    _lineChartView.config.chartLineWidth = 2;
    _lineChartView.dataSource = self;
    _lineChartView.delegate = self;
    
        
    [self.view addSubview:_lineChartView];
    _lineChartView.center = self.view.center;

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    _lineChartView.config.style = _lineChartView.config.style == ORLineChartStyleSlider ? ORLineChartStyleControl : ORLineChartStyleSlider;
    [_lineChartView reloadData];

//    [_lineChartView showDataAtIndex:arc4random() % _datas.count animated:YES];

    return;
    
    /*
     随机数据源
     随机样式
     随机颜色
     */
    
    NSMutableArray *array = [NSMutableArray array];

    for (int i = 0; i < 20; i ++) {
        NSInteger num = arc4random() % 1000;
        [array addObject:[NSString stringWithFormat:@"%ld",(long)num]];
    }
    
    _datas = [array copy];

    _lineChartView.config.style = _lineChartView.config.style == ORLineChartStyleSlider ? ORLineChartStyleControl : ORLineChartStyleSlider;
    _lineChartView.config.gradientColors = @[[[UIColor or_randomColor] colorWithAlphaComponent:0.3],[[UIColor or_randomColor] colorWithAlphaComponent:0.3]];
    
    [_lineChartView reloadData];
}


#pragma mark - ORLineChartViewDataSource
- (NSInteger)numberOfHorizontalDataOfChartView:(ORLineChartView *)chartView {
    return _datas.count;
}

- (CGFloat)chartView:(ORLineChartView *)chartView valueForHorizontalAtIndex:(NSInteger)index {
    return [_datas[index] doubleValue];
}

- (NSInteger)numberOfVerticalLinesOfChartView:(ORLineChartView *)chartView {
    return 6;
}

- (NSAttributedString *)chartView:(ORLineChartView *)chartView attributedStringForIndicaterAtIndex:(NSInteger)index {
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"value: %g", [_datas[index] doubleValue]]];
    return string;
}

- (NSDictionary<NSAttributedStringKey,id> *)labelAttrbutesForVerticalOfChartView:(ORLineChartView *)chartView {
    return @{NSFontAttributeName : [UIFont systemFontOfSize:12], NSForegroundColorAttributeName : [UIColor grayColor]};
}

- (NSDictionary<NSAttributedStringKey,id> *)labelAttrbutesForHorizontalOfChartView:(ORLineChartView *)chartView {
    return @{NSFontAttributeName : [UIFont systemFontOfSize:12], NSForegroundColorAttributeName : [UIColor grayColor]};
}

////custom left values
//- (CGFloat)chartView:(ORLineChartView *)chartView valueOfVerticalSeparateAtIndex:(NSInteger)index {
//    NSArray *number1 = @[@(0),@(0.2),@(0.4),@(0.6),@(0.8),@(0.10)];
//    return [number1[index] doubleValue];
//}

#pragma mark - ORLineChartViewDelegate
- (void)chartView:(ORLineChartView *)chartView didSelectValueAtIndex:(NSInteger)index {
    NSLog(@"did select index %ld and value  is %g", index, [_datas[index] doubleValue]);
}

- (void)chartView:(ORLineChartView *)chartView indicatorDidChangeValueAtIndex:(NSInteger)index {
    NSLog(@"indicater did change index %ld and value  is %g", index, [_datas[index] doubleValue]);
}

@end
