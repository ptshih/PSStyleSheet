//
//  PSStyleSheet.h
//  SevenMinuteLibrary
//
//  Created by Peter Shih on 8/10/11.
//  Copyright 2011 Seven Minute Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSStyleSheet : NSObject

+ (void)setStyleSheet:(NSString *)styleSheet;
+ (void)applyStyle:(NSString *)style forLabel:(UILabel *)label;

+ (UIFont *)fontForStyle:(NSString *)style;
+ (UIColor *)textColorForStyle:(NSString *)style;
+ (UIColor *)highlightedTextColorForStyle:(NSString *)style;
+ (UIColor *)shadowColorForStyle:(NSString *)style;
+ (CGSize)shadowOffsetForStyle:(NSString *)style;
+ (UITextAlignment)textAlignmentForStyle:(NSString *)style;

// TODO: Add UILineBreakMode

@end
