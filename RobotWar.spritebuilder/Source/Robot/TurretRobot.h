//
//  TurretRobot.h
//  RobotWar
//
//  Created by Daniel Haaser on 6/27/14.
//  Copyright (c) 2014 MakeGamesWith.Us. All rights reserved.
//

#import "Robot.h"

typedef NS_ENUM(NSInteger, RobotState) {
    RobotStateDefault,
    RobotStateTurnaround,
    RobotStateFiring,
    RobotStateSearching
};

@interface TurretRobot : Robot

@property CGPoint lastKnownPosition;

@property (nonatomic, assign) RobotState currentRobotState;

@end
