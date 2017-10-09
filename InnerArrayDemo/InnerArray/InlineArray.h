//
//  InnerArray.h
//  InnerArrayDemo
//
//  Created by imac on 2017/8/29.
//  Copyright © 2017年 com.InnerArray.GodL. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface InlineArray<ObjectType> : NSObject

+ (instancetype)array;

@property (nonatomic,assign,readonly) NSInteger count;

- (void)addObject:(ObjectType)obj;

- (void)prependObject:(ObjectType)obj;

- (void)addObjectsFromArray:(nullable NSArray *)arr;

- (nullable ObjectType)objectAtIndex:(NSInteger)idx;

- (void)insertObject:(ObjectType)obj atIndex:(NSInteger)idx;

- (void)removeObjectAtIndex:(NSInteger)idx;

- (void)removeAllObjects;

@end

NS_ASSUME_NONNULL_END
