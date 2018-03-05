//
//  NSString+URL.m
//  CropInterface
//
//  Created by Swarup Mahanti on 9/22/17.
//  Copyright © 2017 Swarup Mahanti. All rights reserved.
//

#import "NSString+URL.h"

@implementation NSString (URL)

/**
 * https://stackoverflow.com/questions/18692023/how-to-validate-url-in-iphone-app
 */
- (BOOL)isValidURL {
    //test for http or https
    NSString* urlRegEx = @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlPredic = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlPredic evaluateWithObject:self];
}

@end
