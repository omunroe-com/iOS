
#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, MEGAChatStatus);

@interface UIColor (MNZCategory)

#pragma mark - Black

+ (UIColor *)mnz_black262626;
+ (UIColor *)mnz_black333333;
+ (UIColor *)mnz_black000000_01;

#pragma mark - Blue

+ (UIColor *)mnz_blue007AFF;
+ (UIColor *)mnz_blue2BA6DE;

#pragma mark - Gray

+ (UIColor *)mnz_gray666666;
+ (UIColor *)mnz_gray777777;
+ (UIColor *)mnz_gray999999;
+ (UIColor *)mnz_grayCCCCCC;
+ (UIColor *)mnz_grayE2EAEA;
+ (UIColor *)mnz_grayE3E3E3;
+ (UIColor *)mnz_grayEEEEEE;
+ (UIColor *)mnz_grayFCFCFC;
+ (UIColor *)mnz_grayF7F7F7;
+ (UIColor *)mnz_grayF9F9F9;

#pragma mark - Green

+ (UIColor *)mnz_green00BFA5;
+ (UIColor *)mnz_green13E03C;
+ (UIColor *)mnz_green31B500;

#pragma mark - Orange

+ (UIColor *)mnz_orangeFFA500;

#pragma mark - Red

+ (UIColor *)mnz_redMain;
+ (UIColor *)mnz_redProI;
+ (UIColor *)mnz_redProII;
+ (UIColor *)mnz_redProIII;

#pragma mark - White

+ (UIColor *)mnz_whiteFFFFFF_02;

#pragma mark - Utils

+ (UIColor *)colorFromHexString:(NSString *)hexString;
+ (UIColor *)mnz_colorForStatusChange:(MEGAChatStatus)onlineStatus;

@end
