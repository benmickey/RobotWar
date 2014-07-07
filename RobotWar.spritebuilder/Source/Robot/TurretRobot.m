//
//  TurretRobot.m
//  RobotWar
//
//  Created by Daniel Haaser on 6/27/14.
//  Copyright (c) 2014 MakeGamesWith.Us. All rights reserved.
//

#import "TurretRobot.h"
#import "Robot.h"
#import "RobotAction.h"
#import "Robot_Framework.h"
#import "GameConstants.h"
#import "MainScene.h"
#import "Helpers.h"


typedef NS_ENUM(NSInteger, TurretState) {
    kTurretStateScanning,
    kTurretStateFiring,
};

static const float GUN_ANGLE_TOLERANCE = 2.0f;

@implementation TurretRobot {
    TurretState _currentState;
    float _timeSinceLastEnemyHit;
        CGPoint _lastKnownPosition;
        CGFloat _lastKnownPositionTimestamp;
        
        int actionIndex;

}

- (id)init {
    if (self = [super init]) {
        _currentState = kTurretStateScanning;
    }
    
    return self;
}

- (void)scannedRobot:(Robot *)robot atPosition:(CGPoint)position {
    
    // Calculate the angle between the turret and the enemy
    float angleBetweenTurretAndEnemy = [self angleBetweenGunHeadingDirectionAndWorldPosition:position];
    
//    CCLOG(@"Enemy Position: (%f, %f)", position.x, position.y);
//    CCLOG(@"Enemy Spotted at Angle: %f", angleBetweenTurretAndEnemy);
    
        _lastKnownPosition = position;
    
    if (angleBetweenTurretAndEnemy > GUN_ANGLE_TOLERANCE) {
    }
    else if (angleBetweenTurretAndEnemy < -GUN_ANGLE_TOLERANCE) {
    }
    
    _timeSinceLastEnemyHit = self.currentTimestamp;
    _currentState = kTurretStateFiring;
}

- (void)run {
    actionIndex = 0;
    while (true) {
        while (_currentRobotState == RobotStateFiring) {
            [self performNextFiringAction];
        }
        
        while (_currentRobotState == RobotStateSearching) {
            [self performNextSearchingAction];
        }
        
        while (_currentRobotState == RobotStateDefault) {
            [self performNextDefaultAction];
        }
    }
}

- (void)performNextDefaultAction {
    switch (actionIndex%1) {
        case 0:
            [self moveAhead:100];
            break;
    }
    actionIndex++;
}

- (void) performNextFiringAction {
    if ((self.currentTimestamp - _lastKnownPositionTimestamp) > 1.f) {
        self.currentRobotState = RobotStateSearching;
    } else {
        CGFloat angle = [self angleBetweenGunHeadingDirectionAndWorldPosition:_lastKnownPosition];
        if (angle >= 0) {
            [self turnGunRight:abs(angle)];
        } else {
            [self turnGunLeft:abs(angle)];
        }
        [self shoot];
    }
}


- (void)performNextSearchingAction {
    switch (actionIndex%4) {
        case 0:
            [self moveAhead:50];
            break;
            
        case 1:
            [self turnRobotLeft:20];
            break;
            
        case 2:
            [self moveAhead:50];
            break;
            
        case 3:
            [self turnRobotRight:20];
            break;
    }
    actionIndex++;
}

-(void)gotHit{
    static int i = 20;
    i--;
    if (i <= 4) {
        int j;
        j = 0;
        j++;
        NSLog(@"TERMINATOR HAS %d HEALTH! IT IS INCREDIBLY LOW!!!", i);
        [self moveBack:500];
        [self turnRobotLeft:90];
        [self moveAhead:500];
                [self turnRobotLeft:90];
        if (j == 9) {
            [self shoot];
            [self shoot];        [self shoot];
            [self shoot];        [self shoot];
        }
    }else{
    NSLog(@"TERMINATOR HAS %d HEALTH!", i);
    CGPoint position;
        CCColor *redColor;
        [self _setRobotColor:redColor];
    float angleBetweenTurretAndEnemy = [self angleBetweenGunHeadingDirectionAndWorldPosition:position];
        if (angleBetweenTurretAndEnemy > GUN_ANGLE_TOLERANCE) {
            if (angleBetweenTurretAndEnemy < 0) {
                angleBetweenTurretAndEnemy = angleBetweenTurretAndEnemy * -1;
            }
            [self turnRobotLeft:angleBetweenTurretAndEnemy];
        }
        else if (angleBetweenTurretAndEnemy < -GUN_ANGLE_TOLERANCE) {
            if (angleBetweenTurretAndEnemy < 0) {
                angleBetweenTurretAndEnemy = angleBetweenTurretAndEnemy * -1;
            }
            [self turnRobotRight:angleBetweenTurretAndEnemy];
        }
    [self moveBack:50];
        [self shoot];
        [self shoot];
    [self moveAhead:0];
    }
}


@end
