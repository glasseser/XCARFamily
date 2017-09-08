//
//  choiceCategory_View.m
//  car_video
//
//  Created by custom on 16/12/20.
//  Copyright © 2016年 self. All rights reserved.
//

#import "choiceCategory_View.h"
#import "dotLine_View.h"
#import "moveCell.h"

#define KEnd_W 60

@interface choiceCategory_View ()<moveCellDelegate,CALayerDelegate>

@property (nonatomic , weak) moveCell *recommandLabel;
@property (nonatomic , weak) dotLine_View *dotLineBorder;//虚线边框

@property (nonatomic , strong) NSMutableArray *positions;
@property (nonatomic , strong) NSMutableArray *moveCells_sectionOne;
@property (nonatomic , strong) NSMutableArray *moveCells_sectionTwo;

@property (nonatomic , assign) CGFloat moveCell_W;
@property (nonatomic , assign) CGFloat moveCell_H;

@property (nonatomic , assign) BOOL moveCellCanBeMoved;

@end

@implementation choiceCategory_View

- (void)drawRect:(CGRect)rect {
    
    CGFloat w = KEnd_W;
    CGFloat l = w*0.3;
    CGFloat lineW = 2;
    CGFloat x = (self.bounds.size.width-w)*0.5+lineW*0.5;
    CGFloat y = (self.bounds.size.height-l);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetLineCap(ctx, kCGLineCapButt);
    CGContextSetLineJoin(ctx, kCGLineJoinMiter);
    CGContextSetLineWidth(ctx, lineW);
    CGContextSetRGBStrokeColor(ctx, 125/255.0, 204/255.0, 233/255.0, 1.0);
    CGContextMoveToPoint(ctx, x+lineW*0.5, y+l-lineW*0.5);
    CGContextAddLineToPoint(ctx, x+w*0.5-lineW*0.5, y+lineW*0.5);
    CGContextMoveToPoint(ctx, x+w*0.5-lineW*0.5, y+lineW*0.5);
    CGContextAddLineToPoint(ctx, x+w-lineW*0.5, y+l-lineW*0.5);
    CGContextStrokePath(ctx);
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]){
        [self initOpacity];
        [self setupSubViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame choices:(NSArray *)choices other:(NSArray *)others {
    if (self = [super initWithFrame:frame]){
        self.currentChoiceChannels = [choices mutableCopy];
        self.otherChoiceChnnels = [others mutableCopy];
        [self initOpacity];
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 30)];
    titleLabel.font = [UIFont systemFontOfSize:13];
    titleLabel.textColor = colorsWithSameRGB(160);
    titleLabel.text = [NSString stringWithFormat:@"   长按拖动排序/点击删除"];
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    CGFloat moveCellW = [self getMoveCellWidth];
    CGFloat moveCellH = [self calculateMoveCellHeight];
    _moveCell_W = moveCellW;
    _moveCell_H = moveCellH;
    
    //推荐板块是写死的
    moveCell *recommandLabel = [self quickCreateCell:@"推荐"];
    recommandLabel.frame = CGRectMake(_cell_borderMarin+_cell_horizonMargin, CGRectGetMaxY(titleLabel.frame)+_cell_toDifferentViewMargin, moveCellW, moveCellH);
    recommandLabel.userInteractionEnabled = NO;
    recommandLabel.backgroundColor = colorsWithSameRGB(231);
    self.recommandLabel = recommandLabel;
    
    //设置已选频道
    self.positions = [self getCellCenters:self.currentChoiceChannels.count section:0];
    for (int i = 0 ; i < _positions.count ;++i){
        NSString *content = [self.currentChoiceChannels objectAtIndex:i];
        moveCell *label = [self quickCreateCell:content];
        label.tag = i+1;
        label.position = [NSIndexPath indexPathForItem:i inSection:0];
        NSValue *pointValue = [self.positions objectAtIndex:i];
        CGPoint point = [pointValue CGPointValue];
        label.center = point;
        [self.moveCells_sectionOne addObject:label];
    }
    
    //点击订阅更多频道
    NSValue *pointValue;
    if (self.positions.count){
        pointValue = [self.positions lastObject];
    }else{
        pointValue = [NSValue valueWithCGPoint:recommandLabel.center];
    }
    CGPoint point = [pointValue CGPointValue];
    
    UILabel *moreChannelLabel = [self createView:CGRectMake(0, point.y + moveCellH*0.5 +_cell_toDifferentViewMargin, self.bounds.size.width, 40) text:@"点击订阅更多频道" textColor:[UIColor whiteColor] font:15 backColor:colorsWithRGB(125, 204, 233)];
    self.moreChannelLabel = moreChannelLabel;
    
    //未选频道
    [self.positions addObjectsFromArray:[[self getCellCenters:self.otherChoiceChnnels.count section:1] copy]];
    NSInteger choiceCount = self.currentChoiceChannels.count;
    for (int i = (int)choiceCount ; i < _positions.count ;++i){
        NSString *content = [self.otherChoiceChnnels objectAtIndex:i-choiceCount];
        moveCell *label = [self quickCreateCell:content];
        label.tag = i+1;
        label.position = [NSIndexPath indexPathForItem:i inSection:1];
        NSValue *pointValue = [self.positions objectAtIndex:i];
        CGPoint point = [pointValue CGPointValue];
        label.center = point;
        [self.moveCells_sectionTwo addObject:label];
    }
    
    //虚线边框
    dotLine_View *dotLine = [[dotLine_View alloc] initWithFrame:CGRectMake(0, 0, _moveCell_W, _moveCell_H)];
    [self addSubview:dotLine];
    self.dotLineBorder = dotLine;
    dotLine.hidden = YES;
}

- (void)initOpacity {
    self.backgroundColor = [UIColor whiteColor];
    [self.layer setBorderColor:colorsWithSameRGB(211).CGColor];
    [self.layer setBorderWidth:0.8];
    
    _moveCellCanBeMoved = NO;
     
     //下面值默认，但是可以直接修改以改变UI显示
     _cell_borderMarin = 2;
     _cell_horizonMargin = 15;
     _cell_verticalMargin = 10;
    _cell_toDifferentViewMargin = _cell_verticalMargin*0.8;
    _moveCellFontSize = [self getMoveCellFontSize];
}

- (void)setSubViewsFrame {
    CGFloat moveCellH = [self calculateMoveCellHeight];
    
    self.positions = [self getCellCenters:self.moveCells_sectionOne.count section:0];
    //点击订阅更多频道
    NSValue *pointValue;
    if (self.positions.count){
        pointValue = [self.positions lastObject];
    }else{
        pointValue = [NSValue valueWithCGPoint:_recommandLabel.center];
    }
    CGPoint point = [pointValue CGPointValue];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.moreChannelLabel.frame = CGRectMake(0, point.y + moveCellH*0.5 +_cell_toDifferentViewMargin, self.bounds.size.width, 40);
    }];
    
    [self.positions addObjectsFromArray:[[self getCellCenters:self.moveCells_sectionTwo.count section:1] copy]];
}

- (UILabel *)createView:(CGRect)frame
                   text:(NSString *)text
              textColor:(UIColor *)textColor
                   font:(CGFloat)font
              backColor:(UIColor *)bgColor {
    
    UILabel *v = [[UILabel alloc] initWithFrame:frame];
    v.backgroundColor = bgColor;
    [self addSubview:v];
    v.text = [NSString stringWithFormat:@"%@",text];
    v.textColor = textColor;
    v.font = [UIFont systemFontOfSize:font];
    v.textAlignment = NSTextAlignmentCenter;
    
    v.layer.masksToBounds = YES;
    [v.layer setBorderColor:colorsWithSameRGB(241).CGColor];
    [v.layer setBorderWidth:1.0];
    v.layer.cornerRadius = 3;
    
    return v;
}

- (moveCell *)quickCreateCell:(NSString *)text {
    CGFloat moveCellW = _moveCell_W;
    CGFloat moveCellH = _moveCell_H;
    moveCell *label = [[moveCell alloc]initWithFrame:CGRectMake(0, 0, moveCellW, moveCellH)];
    label.textLabel.text = text;
    [self addSubview:label];
    label.delegate = self;
    return label;
}

//返回水平方向上的cell的宽度
- (CGFloat)getMoveCellWidth {
    CGFloat leftMargin = _cell_borderMarin+_cell_horizonMargin;
    CGFloat midTotalMargin = (theNumberOfMoveCellInHorizon-1)*_cell_horizonMargin;
    return (self.bounds.size.width - leftMargin*2 - midTotalMargin)/theNumberOfMoveCellInHorizon;
}

//获取cell的高度
- (CGFloat)calculateMoveCellHeight {
    return [self getMoveCellWidth]*0.5;
}

//后去cell的文字的正确font
- (NSInteger)getMoveCellFontSize {
    
    CGFloat currentCellHeight = [self calculateMoveCellHeight];
    NSInteger cellFontSize = 14;//默认
    NSString *content = @"推荐";
    CGFloat contentHeight = [content sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:cellFontSize]}].height;
    while (contentHeight < currentCellHeight/7*4) {
        cellFontSize++;
        contentHeight = [content sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:cellFontSize]}].height;
    }
    return cellFontSize;
}
//计算子控件的坐标
- (NSMutableArray *)getCellCenters:(NSInteger)cellCount section:(NSInteger)section {
    
    NSMutableArray *positionsArray = [@[] mutableCopy];
    CGFloat leftMargin = _cell_borderMarin+_cell_horizonMargin;
    CGFloat moveCellW = [self getMoveCellWidth];
    CGFloat moveCellH = [self calculateMoveCellHeight];
    
    CGFloat foundationY;
    if (section == 0){
        foundationY = CGRectGetMaxY(_titleLabel.frame);
    }else{
        foundationY = CGRectGetMaxY(_moreChannelLabel.frame);
    }
    
    //从左到右
    int i = section == 0?1:0;
    NSInteger total = section == 0?cellCount+1:cellCount;
    for (; i<total; i++) {
        
        CGFloat centerX;
        CGFloat centerY;
        
        //列
        NSInteger col = i % theNumberOfMoveCellInHorizon;
        //行
        NSInteger row = i / theNumberOfMoveCellInHorizon;
        
        if (col == 0){
            centerX = leftMargin + moveCellW*0.5;
        }else{
            centerX = leftMargin + (moveCellW + _cell_horizonMargin)*col + moveCellW*0.5;
        }
        
        if (row == 0){
            centerY = foundationY + _cell_toDifferentViewMargin + moveCellH*0.5;
        }else{
            centerY = foundationY + _cell_toDifferentViewMargin + (moveCellH + _cell_verticalMargin)*row + moveCellH*0.5;
        }
        
        NSValue *pointValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerY)];
        [positionsArray addObject:pointValue];
    }
    return positionsArray;
}

#pragma mark - moveCellDelegate
- (void)moveCell:(moveCell *)moveCell
    touchesBegan:(NSSet<UITouch *> *)touches
       withEvent:(UIEvent *)event {
    
    if (moveCell.position.section == 1){
        
        //将这个cell移动到第一组中
        _moveCellCanBeMoved = NO;
        return ;
    }
    
    if (event.type == UIEventTypeTouches){
        _moveCellCanBeMoved = YES;
        [self bringSubviewToFront:moveCell];
        CGRect rect = moveCell.frame;
        rect.size = CGSizeMake(_moveCell_W+5, _moveCell_H+5);
        moveCell.frame = rect;
        for (NSValue *pointValue in _positions) {
            CGPoint point = [pointValue CGPointValue];
            if (CGRectContainsPoint(rect, point)){
                moveCell.center = point;
                break;
            }
        }
    }else{
        _moveCellCanBeMoved = NO;
        
    }
}

- (void)moveCell:(moveCell *)move_Cell
    touchesMoved:(NSSet<UITouch *> *)touches
       withEvent:(UIEvent *)event {
    
    move_Cell.moveCellIsMoving = YES;
    if (!_moveCellCanBeMoved){
        return ;
    }
    CGPoint prePoint = [[touches anyObject] previousLocationInView:self];
    CGPoint currentPoint = [[touches anyObject] locationInView:self];
    CGPoint currentCenter = move_Cell.center;
    
    CGFloat moveX = currentPoint.x - prePoint.x;
    CGFloat moveY = currentPoint.y - prePoint.y;
    
    currentCenter.x += moveX;
    currentCenter.y += moveY;
    move_Cell.center = currentCenter;
    
    //显示虚线边框
    NSValue *pointValue = [_positions objectAtIndex:move_Cell.position.item];
    CGPoint dotLinePoint = [pointValue CGPointValue];
    self.dotLineBorder.hidden = NO;
    self.dotLineBorder.center = dotLinePoint;
    
    //更换数组
    NSMutableArray *replaceArray = [NSMutableArray array];
    
    //确保被移动的是第一组的cell , 下面操作知只是为了找到cell对应的item
    for (int i = 0;i<_moveCells_sectionOne.count;++i){
        
        NSValue *pointValue = [_positions objectAtIndex:i];
        CGPoint point = [pointValue CGPointValue];
        CGRect rect = CGRectMake(point.x-_moveCell_W*0.5, point.y-_moveCell_H*0.5, _moveCell_W, _moveCell_H);
        
        if (CGRectContainsPoint(rect, currentCenter)){
            
            if (i == move_Cell.position.item){
                move_Cell.destinationPosition = -1;
            }else{
                move_Cell.destinationPosition = i;
            }
            break;
        }
    }
    
    //下面是替换数组的位置
    if (move_Cell.destinationPosition == -1){
        return ;
    }
    
    NSInteger destinationIndex = move_Cell.destinationPosition;
    
    [_moveCells_sectionOne removeObject:move_Cell];
    for (moveCell *cell in _moveCells_sectionOne){
        [replaceArray addObject:cell];
    }
    
    [replaceArray insertObject:move_Cell atIndex:destinationIndex];
    _moveCells_sectionOne = replaceArray;
    
    //重新设置cell的position
    for (int i =0;i<_moveCells_sectionOne.count;++i){
        moveCell *cell = [_moveCells_sectionOne objectAtIndex:i];
        cell.position = [NSIndexPath indexPathForItem:i inSection:0];
    }
    
    [self moveCellAnimationAction:moveCellAnimationTypePanBetweenEachOther];
    [self reSetDataSource];
}

- (void)moveCell:(moveCell *)moveCell
    touchesEnded:(NSSet<UITouch *> *)touches
       withEvent:(UIEvent *)event {
    //隐藏虚线边框
    self.dotLineBorder.hidden = YES;
    
    if (moveCell.moveCellIsMoving && moveCell.position.section != 1){
        _moveCellCanBeMoved = NO;
        moveCell.destinationPosition = -1;
        CGRect rect = moveCell.frame;
        rect.size = CGSizeMake(_moveCell_W, _moveCell_H);
        moveCell.frame = rect;
        
        for (int i =0;i<_positions.count;++i){
            NSValue *pointValue = [_positions objectAtIndex:i];
            CGPoint point = [pointValue CGPointValue];
            if (moveCell.position.item == i){
                moveCell.center = point;
            }
        }
    }else if (!moveCell.moveCellIsMoving){
        //不管是第一组还是第二组，点击就交换两组的位置
        NSInteger section = moveCell.position.section;
        if (section == 0){
            [self.moveCells_sectionTwo addObject:moveCell];
            [self.moveCells_sectionOne removeObject:moveCell];
        }else if (section == 1){
            [self.moveCells_sectionOne addObject:moveCell];
            [self.moveCells_sectionTwo removeObject:moveCell];
        }
        [self moveCellAnimationAction:moveCellAnimationTypeJumpToOtherSection];
        [self reSetDataSource];
    }
}

- (NSMutableArray *)moveCells_sectionOne{
    if (!_moveCells_sectionOne){
        _moveCells_sectionOne = [@[] mutableCopy];
    }
    return _moveCells_sectionOne;
}

- (NSMutableArray *)moveCells_sectionTwo{
    if (!_moveCells_sectionTwo){
        _moveCells_sectionTwo = [@[] mutableCopy];
    }
    return _moveCells_sectionTwo;
}

/*
 moveCell的动画操作
 */
- (void)moveCellAnimationAction:(moveCellAnimationType)type {
    if (type == moveCellAnimationTypePanBetweenEachOther){
        self.dotLineBorder.hidden = YES;
        [UIView animateWithDuration:0.3 animations:^{
            
            for (int i = 0;i<_moveCells_sectionOne.count;++i){
                
                moveCell *cell = [_moveCells_sectionOne objectAtIndex:i];
                
                if (cell.destinationPosition != -1){
                    cell.destinationPosition = -1;
                    continue;
                }
                
                NSValue *pointValue = [_positions objectAtIndex:i];
                CGPoint point = [pointValue CGPointValue];
                cell.center = point;
            }
            
        } completion:^(BOOL finished) {
            
        }];
    }else if (type == moveCellAnimationTypeJumpToOtherSection){
        
        [self setSubViewsFrame];
        
        [UIView animateWithDuration:0.3 animations:^{
            
            for (int i = 0;i<_moveCells_sectionOne.count;++i){
                
                moveCell *cell = [_moveCells_sectionOne objectAtIndex:i];
                cell.destinationPosition = -1;
                cell.position = [NSIndexPath indexPathForItem:i inSection:0];
                
                NSValue *pointValue = [_positions objectAtIndex:i];
                CGPoint point = [pointValue CGPointValue];
                cell.center = point;
            }
            
            for (int i = 0;i<_moveCells_sectionTwo.count;++i){
                
                moveCell *cell = [_moveCells_sectionTwo objectAtIndex:i];
                cell.destinationPosition = -1;
                cell.position = [NSIndexPath indexPathForItem:i inSection:1];
                
                NSValue *pointValue = [_positions objectAtIndex:i+_moveCells_sectionOne.count];
                CGPoint point = [pointValue CGPointValue];
                cell.center = point;
            }
            
        } completion:^(BOOL finished) {
            
        }];
    }
}

/*
 重新设置数据资源
 */
- (void)reSetDataSource {
    NSMutableArray *currentChoiceArray = [@[] mutableCopy];
    NSMutableArray *otherChoiceArray = [@[] mutableCopy];
    for (moveCell *cell in self.moveCells_sectionOne){
        NSString *content = cell.textLabel.text;
        [currentChoiceArray addObject:content];
    }
    
    for (moveCell *cell in self.moveCells_sectionTwo){
        NSString *content = cell.textLabel.text;
        [otherChoiceArray addObject:content];
    }
    
    self.currentChoiceChannels = [currentChoiceArray mutableCopy];
    self.otherChoiceChnnels = [otherChoiceArray mutableCopy];
}

#pragma mark - --------------------------本视图触摸事件----------------------------
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGFloat w = KEnd_W;
    CGFloat l = w*0.6;
    CGFloat x = (self.bounds.size.width-w)*0.5;
    CGFloat y = (self.bounds.size.height-l);
    
    UITouch *touch = [touches anyObject];
    CGPoint pre_point = [touch previousLocationInView:self];
    CGPoint current_point = [touch locationInView:self];
    if (CGRectContainsPoint(CGRectMake(x, y, w, l), pre_point)) {
        if (current_point.y<pre_point.y) {
            if ([self.delegate respondsToSelector:@selector(choiceCategory_View:btnClick:)]) {
                [self.delegate choiceCategory_View:self btnClick:nil];
            }
        }
    }
}

@end
