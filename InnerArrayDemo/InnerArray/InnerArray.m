//
//  InnerArray.m
//  InnerArrayDemo
//
//  Created by imac on 2017/8/29.
//  Copyright © 2017年 com.InnerArray.GodL. All rights reserved.
//

#import "InnerArray.h"

@interface InnerArray ()

@property (nonatomic,assign,readwrite) NSInteger innerCount;

@property (nonatomic,assign,readwrite) NSInteger count;

@property (nonatomic) CFMutableArrayRef privateArray;

@end

@implementation InnerArray {
    void **_innerArray;
}

static Boolean innerArrayObjectEqualCallback(const void *obj1,const void *obj2) {
    NSObject *obj_1 = (__bridge NSObject *)(obj1);
    NSObject *obj_2 = (__bridge NSObject *)(obj2);
    return [obj_1 isEqual:obj_2];
}

+ (instancetype)arrayWithInnerCount:(NSInteger)count {
    return [[InnerArray alloc] initWithInnerCount:count];
}

- (instancetype)initWithInnerCount:(NSInteger)count {
    self = [super init];
    if (self) {
        if (count > 0) {
            _innerArray = calloc(count, sizeof(NSObject *));
        }
    }
    return self;
}

- (instancetype)initWithInnerCount:(NSInteger)count otherArray:(NSArray *)arr {
    self = [self initWithInnerCount:count];
    if (self) {
        [self addObjectsFromArray:arr];
    }
    return self;
}

- (NSInteger)maxInnerCount {
    return sizeof(_innerArray)/sizeof(NSObject *);
}

- (NSInteger)count {
    return CFArrayGetCount(self.privateArray) + self.innerCount;
}

- (CFMutableArrayRef)privateArray {
    if (!_privateArray) {
        CFArrayCallBacks callbacks = {0,0,0,0,&innerArrayObjectEqualCallback};
        _privateArray = CFArrayCreateMutable(CFAllocatorGetDefault(), 0, &callbacks);
    }
    return _privateArray;
}

- (void)addObjectsFromArray:(NSArray *)arr {
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addObject:obj];
    }];
}

- (void)addObject:(id)obj {
    NSParameterAssert(obj);
    if (self.innerCount < [self maxInnerCount]) {
        for (int i=0; i<[self maxInnerCount]; i++) {
            if (_innerArray[i] == NULL) {
                _innerArray[i] = (__bridge void *)(obj);
                self.innerCount += 1;
                return;
            }
        }
    }
    CFArrayAppendValue(self.privateArray, (__bridge const void *)(obj));
}

@end
