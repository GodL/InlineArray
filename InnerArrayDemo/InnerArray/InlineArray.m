//
//  InnerArray.m
//  InnerArrayDemo
//
//  Created by imac on 2017/8/29.
//  Copyright © 2017年 com.InnerArray.GodL. All rights reserved.
//

#import "InlineArray.h"

@interface InlineArray ()

@property (nonatomic,assign,readwrite) NSInteger count;

@property (nonatomic) CFMutableArrayRef privateArray;

@end

#define INLINECOUNT 5

@implementation InlineArray {
    NSInteger _currentInlineCount;
    id _inlineArray[INLINECOUNT];
}

static Boolean inlineArrayObjectEqualCallback(const void *obj1,const void *obj2) {
    NSObject *obj_1 = (__bridge NSObject *)(obj1);
    NSObject *obj_2 = (__bridge NSObject *)(obj2);
    return [obj_1 isEqual:obj_2];
}

+ (instancetype)array {
    return [self new];
}

- (NSInteger)count {
    return CFArrayGetCount(self.privateArray) + _currentInlineCount;
}

- (CFMutableArrayRef)privateArray {
    if (!_privateArray) {
        CFArrayCallBacks callbacks = {0,0,0,0,&inlineArrayObjectEqualCallback};
        _privateArray = CFArrayCreateMutable(CFAllocatorGetDefault(), 0, &callbacks);
    }
    return _privateArray;
}

- (void)addObject:(id)obj {
    [self insertObject:obj atIndex:self.count];
}

- (void)addObjectsFromArray:(NSArray *)arr {
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addObject:obj];
    }];
}

- (void)prependObject:(id)obj {
    [self insertObject:obj atIndex:0];
}

- (void)insertObject:(id)obj atIndex:(NSInteger)idx {
    NSParameterAssert(obj);
    if (_currentInlineCount < INLINECOUNT) {
        _inlineArray[_currentInlineCount] = obj;
        _currentInlineCount ++ ;
    }else if (idx < INLINECOUNT) {
        
    } else {
        if (idx >= self.count) {
            CFArrayAppendValue(self.privateArray, (__bridge const void *)(obj));
        }else {
            CFArrayInsertValueAtIndex(self.privateArray, idx-INLINECOUNT, (__bridge const void *)(obj));
        }
    }
    
}

@end
