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

- (instancetype)init {
    self = [super init];
    if (self) {
        CFArrayCallBacks callbacks = {0,0,0,0,&inlineArrayObjectEqualCallback};
        _privateArray = CFArrayCreateMutable(CFAllocatorGetDefault(), 0, &callbacks);
    }
    return self;
}

- (NSInteger)count {
    return CFArrayGetCount(self.privateArray) + _currentInlineCount;
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

- (void)insertObject:(id)obj atIndex:(NSUInteger)idx {
    NSParameterAssert(obj);
    if (_currentInlineCount < INLINECOUNT) {
        _inlineArray[_currentInlineCount] = obj;
        _currentInlineCount ++ ;
    }else if (idx < INLINECOUNT) {
        id last_obj = _inlineArray[INLINECOUNT-1];
        NSInteger i = INLINECOUNT - 2;
        while (i >= idx) {
            _inlineArray[i + 1] = _inlineArray[i];
            i--;
        }
        CFArrayInsertValueAtIndex(self.privateArray, 0, (__bridge const void *)(last_obj));
        _inlineArray[idx] = obj;
    } else {
        if (idx >= self.count) {
            CFArrayAppendValue(self.privateArray, (__bridge const void *)(obj));
        }else {
            CFArrayInsertValueAtIndex(self.privateArray, idx-INLINECOUNT, (__bridge const void *)(obj));
        }
    }
}

- (void)removeObjectAtIndex:(NSUInteger)idx {
    if (_currentInlineCount < INLINECOUNT) {
        while (idx < _currentInlineCount) {
            _inlineArray[idx] = _inlineArray[idx + 1];
            idx ++;
        }
        _currentInlineCount --;
    }else {
        if (idx < INLINECOUNT) {
            while (idx < INLINECOUNT - 1) {
                _inlineArray[idx] = _inlineArray[idx + 1];
                idx ++ ;
            }
            const void *value = CFArrayGetValueAtIndex(self.privateArray, 0);
            _inlineArray[INLINECOUNT - 1] = (__bridge id)(value);
            CFArrayRemoveValueAtIndex(self.privateArray, 0);
        }else {
            CFArrayRemoveValueAtIndex(self.privateArray, idx - INLINECOUNT);
        }
    }
}

- (void)removeAllObjects {
    while (_currentInlineCount) {
        _currentInlineCount --;
        _inlineArray[_currentInlineCount] = nil;
    }
    CFArrayRemoveAllValues(self.privateArray);
}

- (id)objectAtIndex:(NSUInteger)idx {
    return idx < INLINECOUNT ? _inlineArray[idx] : (__bridge id)CFArrayGetValueAtIndex(self.privateArray, INLINECOUNT - idx);
}

- (void)dealloc {
    CFRelease(self.privateArray);
    self.privateArray = NULL;
}

@end
