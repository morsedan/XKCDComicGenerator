//
//  Comic.h
//  XKCDComics
//
//  Created by morse on 1/30/20.
//  Copyright © 2020 morse. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Comic : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic) int num;
@property (nonatomic) int month;
@property (nonatomic) int day;
@property (nonatomic) int year;
@property (nonatomic, copy) NSString *news;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *safeTitle;
@property (nonatomic, copy) NSString *transcript;
@property (nonatomic, copy) NSString *alt;
@property (nonatomic) NSURL *imageURL;

@end

NS_ASSUME_NONNULL_END
