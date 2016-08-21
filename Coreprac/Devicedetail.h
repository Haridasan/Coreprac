//
//  Devicedetail.h
//  Coreprac
//
//  Created by haridasan on 19/07/16.
//  Copyright © 2016 Tcs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Devicedetail : NSObject{
    NSString *name;
    NSString *company;
    NSString *version;
}
@property(nonatomic,retain)NSString *name;
@property(nonatomic,retain)NSString *company;
@property(nonatomic,retain)NSString *version;

@end
