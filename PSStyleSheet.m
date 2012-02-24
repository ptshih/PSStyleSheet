//
//  PSStyleSheet.m
//  PSKit
//
//  Created by Peter Shih on 8/10/11.
//  Copyright (c) 2011 Peter Shih.. All rights reserved.
//

#import "PSStyleSheet.h"

static PSStyleSheet *__defaultStyleSheet = nil;

@interface UIColor (PSStyleSheet)

+ (UIColor *)colorWithRGBHex:(UInt32)hex;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

@end

@implementation UIColor (PSStyleSheet)

+ (UIColor *)colorWithRGBHex:(UInt32)hex {
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}

// Returns a UIColor by scanning the string for a hex number and passing that to +[UIColor colorWithRGBHex:]
// Skips any leading whitespace and ignores any trailing characters
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert {
    NSScanner *scanner = [NSScanner scannerWithString:stringToConvert];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) return nil;
    return [UIColor colorWithRGBHex:hexNum];
}

@end

@interface UILabel (PSStyleSheet)

+ (CGSize)sizeForText:(NSString*)text width:(CGFloat)width font:(UIFont*)font numberOfLines:(NSInteger)numberOfLines lineBreakMode:(UILineBreakMode)lineBreakMode;

@end

@implementation UILabel (PSStyleSheet)

+ (CGSize)sizeForText:(NSString*)text width:(CGFloat)width font:(UIFont*)font numberOfLines:(NSInteger)numberOfLines lineBreakMode:(UILineBreakMode)lineBreakMode {
    
    if (numberOfLines == 0) numberOfLines = INT_MAX;
    
    CGFloat lineHeight = [@"A" sizeWithFont:font].height;
    return [text sizeWithFont:font constrainedToSize:CGSizeMake(width, numberOfLines*lineHeight) lineBreakMode:lineBreakMode];
}

@end


@interface PSStyleSheet ()

+ (PSStyleSheet *)defaultStyleSheet;

@property (nonatomic, retain) NSMutableDictionary *styles;

@end

@implementation PSStyleSheet

@synthesize
styles = _styles;

+ (PSStyleSheet *)defaultStyleSheet {
    if (!__defaultStyleSheet) {
        __defaultStyleSheet = [[self alloc] init];
    }
    return __defaultStyleSheet;
}

- (id)init {
    self = [super init];
    if (self) {
        self.styles = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)dealloc {
    self.styles = nil;
    [super dealloc];
}

+ (void)setStyleSheet:(NSString *)styleSheet {
    NSString *styleSheetPath = [[NSBundle mainBundle] pathForResource:styleSheet ofType:@"plist"];
    assert(styleSheetPath != nil);
    
    NSMutableDictionary *styleSheetDict = [NSMutableDictionary dictionaryWithContentsOfFile:styleSheetPath];
    assert(styleSheetDict != nil);
    
    [[[self class] defaultStyleSheet] setStyles:styleSheetDict];
}

#pragma mark - Applying Styles
+ (void)applyStyle:(NSString *)style forLabel:(UILabel *)label {
    label.font = [PSStyleSheet fontForStyle:style];
    label.textColor = [PSStyleSheet textColorForStyle:style];
    label.highlightedTextColor = [PSStyleSheet highlightedTextColorForStyle:style];
    label.shadowColor = [PSStyleSheet shadowColorForStyle:style];
    label.shadowOffset = [PSStyleSheet shadowOffsetForStyle:style];
    label.textAlignment = [PSStyleSheet textAlignmentForStyle:style];
    label.backgroundColor = [PSStyleSheet backgroundColorForStyle:style];
    label.numberOfLines = [PSStyleSheet numberOfLinesForStyle:style];
    label.lineBreakMode = [PSStyleSheet lineBreakModeForStyle:style];
}

+ (void)applyStyle:(NSString *)style forButton:(UIButton *)button {
    [button setTitleColor:[PSStyleSheet textColorForStyle:style] forState:UIControlStateNormal];
    [button setTitleColor:[PSStyleSheet highlightedTextColorForStyle:style] forState:UIControlStateHighlighted];
    [button setTitleShadowColor:[PSStyleSheet shadowColorForStyle:style] forState:UIControlStateNormal];
    button.titleLabel.font = [PSStyleSheet fontForStyle:style];
    button.titleLabel.shadowOffset = [PSStyleSheet shadowOffsetForStyle:style];
}

#pragma mark - Size calculation
+ (CGSize)sizeForText:(NSString *)text width:(CGFloat)width style:(NSString *)style {
    CGSize size = [UILabel sizeForText:text width:width font:[[self class] fontForStyle:style] numberOfLines:[[self class] numberOfLinesForStyle:style] lineBreakMode:[[self class] lineBreakModeForStyle:style]];
    return size;
}

#pragma mark - Fonts
+ (UIFont *)fontForStyle:(NSString *)style {
    UIFont *font = nil;
    if ([[[[self class] defaultStyleSheet].styles objectForKey:style] objectForKey:@"fontName"] && [[[[self class] defaultStyleSheet].styles objectForKey:style] objectForKey:@"fontSize"]) {
        font = [UIFont fontWithName:[[[[self class] defaultStyleSheet].styles objectForKey:style] objectForKey:@"fontName"] size:[[[[[self class] defaultStyleSheet].styles objectForKey:style] objectForKey:@"fontSize"] integerValue]];
    }
    return font;
}

#pragma mark - Colors
+ (UIColor *)textColorForStyle:(NSString *)style {
    UIColor *color = nil;
    if ([[[[self class] defaultStyleSheet].styles objectForKey:style] objectForKey:@"textColor"]) {
        color = [UIColor colorWithHexString:[[[[self class] defaultStyleSheet].styles objectForKey:style] objectForKey:@"textColor"]];
    }
    return color;
}

+ (UIColor *)highlightedTextColorForStyle:(NSString *)style {
    UIColor *color = nil;
    if ([[[[self class] defaultStyleSheet].styles objectForKey:style] objectForKey:@"highlightedTextColor"]) {
        color = [UIColor colorWithHexString:[[[[self class] defaultStyleSheet].styles objectForKey:style] objectForKey:@"highlightedTextColor"]];
    }
    return color;
}

+ (UIColor *)shadowColorForStyle:(NSString *)style {
    UIColor *color = nil;
    if ([[[[self class] defaultStyleSheet].styles objectForKey:style] objectForKey:@"shadowColor"]) {
        color = [UIColor colorWithHexString:[[[[self class] defaultStyleSheet].styles objectForKey:style] objectForKey:@"shadowColor"]];
    }
    return color;
}

+ (UIColor *)backgroundColorForStyle:(NSString *)style {
    UIColor *color = nil;
    if ([[[[self class] defaultStyleSheet].styles objectForKey:style] objectForKey:@"backgroundColor"]) {
        color = [UIColor colorWithHexString:[[[[self class] defaultStyleSheet].styles objectForKey:style] objectForKey:@"backgroundColor"]];
    } else {
        color = [UIColor clearColor];
    }
    return color;
}

#pragma mark - Offsets
+ (CGSize)shadowOffsetForStyle:(NSString *)style {
    CGSize offset = CGSizeZero;
    if ([[[[self class] defaultStyleSheet].styles objectForKey:style] objectForKey:@"shadowOffset"]) {
        offset = CGSizeFromString([[[[self class] defaultStyleSheet].styles objectForKey:style] objectForKey:@"shadowOffset"]);
    }
    return offset;
}

#pragma mark - Text Alignment
+ (UITextAlignment)textAlignmentForStyle:(NSString *)style {
    // Defaults to UITextAlignmentLeft if undefined
    if ([[[[self class] defaultStyleSheet].styles objectForKey:style] objectForKey:@"textAlignment"]) {
        NSString *textAlignmentString = [[[[self class] defaultStyleSheet].styles objectForKey:style] objectForKey:@"textAlignment"];
        if ([textAlignmentString isEqualToString:@"center"]) {
            return UITextAlignmentCenter;
        } else if ([textAlignmentString isEqualToString:@"right"]) {
            return  UITextAlignmentRight;
        } else return UITextAlignmentLeft;
    } else {
        return UITextAlignmentLeft;
    }
}

#pragma mark - Number of Lines
+ (NSInteger)numberOfLinesForStyle:(NSString *)style {
    NSInteger numberOfLines = 0; // If left empty, default to 0
    if ([[[[[self class] defaultStyleSheet].styles objectForKey:style] objectForKey:@"numberOfLines"] integerValue]) {
        numberOfLines = [[[[[self class] defaultStyleSheet].styles objectForKey:style] objectForKey:@"numberOfLines"] integerValue];
    }
    return numberOfLines;
}

#pragma mark - Line break mode
+ (UILineBreakMode)lineBreakModeForStyle:(NSString *)style {
    //  typedef enum {		
    //    UILineBreakModeWordWrap = 0,            // Wrap at word boundaries
    //    UILineBreakModeCharacterWrap,           // Wrap at character boundaries
    //    UILineBreakModeClip,                    // Simply clip when it hits the end of the rect
    //    UILineBreakModeHeadTruncation,          // Truncate at head of line: "...wxyz". Will truncate multiline text on first line
    //    UILineBreakModeTailTruncation,          // Truncate at tail of line: "abcd...". Will truncate multiline text on last line
    //    UILineBreakModeMiddleTruncation,        // Truncate middle of line:  "ab...yz". Will truncate multiline text in the middle
    //  } UILineBreakMode;
    UILineBreakMode lineBreakMode = UILineBreakModeTailTruncation;
    if ([[[[self class] defaultStyleSheet].styles objectForKey:style] objectForKey:@"lineBreakMode"]) {
        NSString *lineBreakModeString = [[[[self class] defaultStyleSheet].styles objectForKey:style] objectForKey:@"lineBreakMode"];
        if ([lineBreakModeString isEqualToString:@"wordWrap"]) {
            lineBreakMode = UILineBreakModeWordWrap;
        } else if ([lineBreakModeString isEqualToString:@"characterWrap"]) {
            lineBreakMode = UILineBreakModeCharacterWrap;
        } else {
            lineBreakMode = UILineBreakModeTailTruncation;
        }
    }
    return lineBreakMode;
}

@end
