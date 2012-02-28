//
//  PSStyleSheet.h
//  PSKit
//
//  Created by Peter Shih on 8/10/11.
//  Copyright (c) 2011 Peter Shih.. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UILabel (PSStyleSheet)

+ (UILabel *)labelWithStyle:(NSString *)style;

@end

@interface PSStyleSheet : NSObject


/**
 PSStyleSheet is a plist driven label/button configuration class
 It tries to remedy the lack of a true stylesheet (like CSS) in UIKit
 
 How to use:
 *** First make sure you have a style sheet set. Omit the .plist extension ***
 *** Make sure you have a style sheet called "MyStyleSheet.plist" in your app bundle ***
 *** Now set it ASAP after app launches: [PSStyleSheet setStyleSheet:@"MyStyleSheet"]; ***
 
 1. UILabel *myLabel = ...
 2. [PSStyleSheet applyStyle:@"myLabelStyle" forLabel:myLabel];
 3. ???
 4. Profit!
 
 1. UIButton *myButton = ...
 2. [PSStyleSheet applyStyle:@"myButtonStyle" forButton:myButton];
 3. ???
 4. Profit!
 
 Future enhancements:
 - CSS to PLIST conversion script
 - Automated stylesheet updating by detecting when the stylesheet file is changed
 */


/**
 Loads styles from a plist file name
 */
+ (void)setStyleSheet:(NSString *)styleSheet;

+ (NSDictionary *)styleDictForStyle:(NSString *)style;

/**
 Apply a style to a UILabel
 */
+ (void)applyStyle:(NSString *)style forLabel:(UILabel *)label;

/**
 Appy a style to a UIButton
 */
+ (void)applyStyle:(NSString *)style forButton:(UIButton *)button;

/**
 Calculate the size required for a string of text bounded by a width given a style.
 Note: this is useful in table view dynamic row height calculations
*/
+ (CGSize)sizeForText:(NSString *)text width:(CGFloat)width style:(NSString *)style;

/**
 Below are individual components of a "Style", might make this private in the future
 */
+ (UIFont *)fontForStyle:(NSString *)style;
+ (UIColor *)textColorForStyle:(NSString *)style;
+ (UIColor *)highlightedTextColorForStyle:(NSString *)style;
+ (UIColor *)shadowColorForStyle:(NSString *)style;
+ (UIColor *)backgroundColorForStyle:(NSString *)style;
+ (CGSize)shadowOffsetForStyle:(NSString *)style;
+ (UITextAlignment)textAlignmentForStyle:(NSString *)style;
+ (NSInteger)numberOfLinesForStyle:(NSString *)style;
+ (UILineBreakMode)lineBreakModeForStyle:(NSString *)style;

@end
