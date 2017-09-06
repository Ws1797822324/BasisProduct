//
//  XXTextView.m
//  Product
//
//  Created by Sen wang on 2017/8/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "XXTextView.h"


@interface XXTextView ()

@property (weak, nonatomic) UILabel *placeholderLabel;

@end

@implementation XXTextView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (!self) return nil;
    [self setUp];
    return self;
}

- (void)setUp {
    
    UILabel *placeholderLabel = [[UILabel alloc] init];
    placeholderLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_placeholderLabel = placeholderLabel];
    
    self.xx_placeholderColor = [UIColor lightGrayColor];
    self.xx_placeholderFont = [UIFont systemFontOfSize:16.0f];
    self.font = [UIFont systemFontOfSize:16.0f];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
}

#pragma mark - UITextViewTextDidChangeNotification

- (void)textDidChange {
    self.placeholderLabel.hidden = self.hasText;
}


- (void)setText:(NSString *)text {
    [super setText:text];
    
    [self textDidChange];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    
    [self textDidChange];
}


- (void)setXx_placeholderFont:(UIFont *)xx_placeholderFont {
    _xx_placeholderFont = xx_placeholderFont;
    self.placeholderLabel.font = xx_placeholderFont;
    [self setNeedsLayout];
}

- (void)setXx_placeholder:(NSString *)xx_placeholder {
    _xx_placeholder = [xx_placeholder copy];
    
    self.placeholderLabel.text = xx_placeholder;
    
    [self setNeedsLayout];
    
}


- (void)setXx_placeholderColor:(UIColor *)xx_placeholderColor {
    _xx_placeholderColor = xx_placeholderColor;
    self.placeholderLabel.textColor = xx_placeholderColor;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect frame = self.placeholderLabel.frame;
    frame.origin.y = self.textContainerInset.top;
    frame.origin.x = self.textContainerInset.left+6.0f;
    frame.size.width = self.frame.size.width - self.textContainerInset.left*2.0;
    
    CGSize maxSize = CGSizeMake(frame.size.width, MAXFLOAT);
    frame.size.height = [self.xx_placeholder boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.placeholderLabel.font} context:nil].size.height;
    self.placeholderLabel.frame = frame;
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:UITextViewTextDidChangeNotification];
}

@end
