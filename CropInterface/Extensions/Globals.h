//
//  Globals.h
//  CropInterface
//
//  Created by Swarup Mahanti on 8/25/17.
//  Copyright © 2017 Swarup Mahanti. All rights reserved.
//

#ifndef Globals_h
#define Globals_h

#ifdef DEBUG
#define NSDLog( s, ... ) NSLog( @"<%@:(Line: %d)> %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define NSDLog( s, ... )
#endif

#endif /* Globals_h */
