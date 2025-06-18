#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "FPThemeKit.h"
#import "FPThemeManager.h"
#import "FPThemeProxy.h"
#import "IGMTheme.h"

FOUNDATION_EXPORT double FPThemeKitVersionNumber;
FOUNDATION_EXPORT const unsigned char FPThemeKitVersionString[];

