//
//  WSCNTabBarItemModel.m
//  MHomeFramework
//
//  Created by AlexZhang on 2018/12/5.
//  Copyright © 2018 Micker. All rights reserved.
//

#import "WSCNTabBarItemModel.h"

@interface WSCNTabBarItemActivityModel()

@property (nonatomic, assign) BOOL show;    //showActivity

@end

@implementation WSCNTabBarItemActivityModel

- (BOOL)showActivity {
    if (self.show) {
        return YES;
    }
    
    self.show = NO;
    if (self.normal.length &&
        self.pressed.length &&
        self.night_Normal.length &&
        self.night_Pressed.length) {
        self.show = YES;
    }
    return self.show;
}

@end

@implementation WSCNTabBarItemModel

- (void)modelWithArray:(NSArray *)array {
    self.label = array[0];
    if (array.count <= 3) {
        self.normal = array[1];
        self.pressed = array[2];
        
    } else if (array.count >= 5){
        self.normal = array[1];
        self.pressed = array[2];
        self.night_Normal = array[3];
        self.night_Pressed = array[4];
        if (array.count >= 6) {
            NSDictionary *activty = array[5];
            self.activity = [WSCNTabBarItemActivityModel yy_modelWithDictionary:activty];
        }
    }
}

@end
