//
//  PSStyleSheet.m
//  SevenMinuteLibrary
//
//  Created by Peter Shih on 8/10/11.
//  Copyright (c) 2011 Peter Shih.. All rights reserved.
//

#import "PSStyleSheet.h"

static NSMutableDictionary *_styles = nil;

@implementation PSStyleSheet

+ (void)initialize {
  NSString *styleSheetPath = [[NSBundle mainBundle] pathForResource:@"PSStyleSheet-Default" ofType:@"plist"];
  assert(styleSheetPath != nil);
  
  NSMutableDictionary *styleSheetDict = [NSMutableDictionary dictionaryWithContentsOfFile:styleSheetPath];
  assert(styleSheetDict != nil);
  _styles = [styleSheetDict retain];
}

+ (void)setStyleSheet:(NSString *)styleSheet {
  NSString *styleSheetPath = [[NSBundle mainBundle] pathForResource:styleSheet ofType:@"plist"];
  assert(styleSheetPath != nil);
  
  NSMutableDictionary *styleSheetDict = [NSMutableDictionary dictionaryWithContentsOfFile:styleSheetPath];
  assert(styleSheetDict != nil);
  
  [_styles addEntriesFromDictionary:styleSheetDict];
}

#pragma mark - Applying Styles Convenience Methods
+ (void)applyStyle:(NSString *)style forLabel:(UILabel *)label {
  label.font = [PSStyleSheet fontForStyle:style];
  label.textColor = [PSStyleSheet textColorForStyle:style];
  label.highlightedTextColor = [PSStyleSheet highlightedTextColorForStyle:style];
  label.shadowColor = [PSStyleSheet shadowColorForStyle:style];
  label.shadowOffset = [PSStyleSheet shadowOffsetForStyle:style];
  label.textAlignment = [PSStyleSheet textAlignmentForStyle:style];
}

+ (void)applyStyle:(NSString *)style forButton:(UIButton *)button {
  [button setTitleColor:[PSStyleSheet textColorForStyle:style] forState:UIControlStateNormal];
  [button setTitleColor:[PSStyleSheet highlightedTextColorForStyle:style] forState:UIControlStateHighlighted];
  [button setTitleShadowColor:[PSStyleSheet shadowColorForStyle:style] forState:UIControlStateNormal];
  button.titleLabel.font = [PSStyleSheet fontForStyle:style];
  button.titleLabel.shadowOffset = [PSStyleSheet shadowOffsetForStyle:style];
}

#pragma mark - Fonts
+ (UIFont *)fontForStyle:(NSString *)style {
  UIFont *font = nil;
  if ([[_styles objectForKey:style] objectForKey:@"fontName"] && [[_styles objectForKey:style] objectForKey:@"fontSize"]) {
    font = [UIFont fontWithName:[[_styles objectForKey:style] objectForKey:@"fontName"] size:[[[_styles objectForKey:style] objectForKey:@"fontSize"] integerValue]];
  }
  return font;
}

#pragma mark - Colors
+ (UIColor *)textColorForStyle:(NSString *)style {
  UIColor *color = nil;
  if ([[_styles objectForKey:style] objectForKey:@"textColor"]) {
    color = [UIColor colorWithHexString:[[_styles objectForKey:style] objectForKey:@"textColor"]];
  }
  return color;
}

+ (UIColor *)highlightedTextColorForStyle:(NSString *)style {
  UIColor *color = nil;
  if ([[_styles objectForKey:style] objectForKey:@"highlightedTextColor"]) {
    color = [UIColor colorWithHexString:[[_styles objectForKey:style] objectForKey:@"highlightedTextColor"]];
  }
  return color;
}

+ (UIColor *)shadowColorForStyle:(NSString *)style {
  UIColor *color = nil;
  if ([[_styles objectForKey:style] objectForKey:@"shadowColor"]) {
    color = [UIColor colorWithHexString:[[_styles objectForKey:style] objectForKey:@"shadowColor"]];
  }
  return color;
}

#pragma mark - Offsets
+ (CGSize)shadowOffsetForStyle:(NSString *)style {
  CGSize offset = CGSizeZero;
  if ([[_styles objectForKey:style] objectForKey:@"shadowOffset"]) {
    offset = CGSizeFromString([[_styles objectForKey:style] objectForKey:@"shadowOffset"]);
  }
  return offset;
}

#pragma mark - Text Alignment
+ (UITextAlignment)textAlignmentForStyle:(NSString *)style {
  // Defaults to UITextAlignmentLeft if undefined
  if ([[_styles objectForKey:style] objectForKey:@"textAlignment"]) {
    NSString *textAlignmentString = [[_styles objectForKey:style] objectForKey:@"textAlignment"];
    if ([textAlignmentString isEqualToString:@"center"]) {
      return UITextAlignmentCenter;
    } else if ([textAlignmentString isEqualToString:@"right"]) {
      return  UITextAlignmentRight;
    } else return UITextAlignmentLeft;
  } else {
    return UITextAlignmentLeft;
  }
}

@end
