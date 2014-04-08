

#import <Foundation/Foundation.h>

@interface Random : NSObject

+ (NSInteger)randomIntegerFrom:(NSInteger)fromInteger to:(NSInteger)toInteger;
+ (CGFloat)randomFloatFrom:(CGFloat)fromFloat to:(CGFloat)toFloat;

@end