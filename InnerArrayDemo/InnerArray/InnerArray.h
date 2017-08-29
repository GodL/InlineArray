//
//  InnerArray.h
//  InnerArrayDemo
//
//  Created by imac on 2017/8/29.
//  Copyright © 2017年 com.InnerArray.GodL. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface InnerArray<ObjectType> : NSObject

+ (instancetype)arrayWithInnerCount:(NSInteger)count;

- (instancetype)initWithInnerCount:(NSInteger)count;

- (instancetype)initWithInnerCount:(NSInteger)count otherArray:( NSArray * _Nullable )arr;

@property (nonatomic,assign,readonly) NSInteger innerCount;

@property (nonatomic,assign,readonly) NSInteger count;

- (void)addObject:(ObjectType _Nullable)obj;

- (void)addObjectsFromArray:( NSArray * _Nullable )arr;

@end

NS_ASSUME_NONNULL_END
