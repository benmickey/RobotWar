//
//  iRobot.h
//  RobotWar
//
//  Created by Benjamin Mickey on 7/7/14.
//  Copyright (c) 2014 MakeGamesWithUs. All rights reserved.
//

#import "Robot.h"

typedef NS_ENUM(NSInteger, RobotState) {
    RobotStateDefault,
    RobotStateTurnaround,
    RobotStateFiring,
    RobotStateSearching
};

@interface iRobot : Robot

@property (nonatomic, assign) RobotState currentRobotState;

@end
