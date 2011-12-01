//
//  PSStyleSheet.h
//  PSKit
//
//  Created by Peter Shih on 8/10/11.
//  Copyright (c) 2011 Peter Shih.. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSStyleSheet : NSObject

+ (void)setStyleSheet:(NSString *)styleSheet;
+ (void)applyStyle:(NSString *)style forLabel:(UILabel *)label;
+ (void)applyStyle:(NSString *)style forButton:(UIButton *)button;

+ (UIFont *)fontForStyle:(NSString *)style;
+ (UIColor *)textColorForStyle:(NSString *)style;
+ (UIColor *)highlightedTextColorForStyle:(NSString *)style;
+ (UIColor *)shadowColorForStyle:(NSString *)style;
+ (UIColor *)backgroundColorForStyle:(NSString *)style;
+ (CGSize)shadowOffsetForStyle:(NSString *)style;
+ (UITextAlignment)textAlignmentForStyle:(NSString *)style;

// TODO: Add UILineBreakMode

@end
