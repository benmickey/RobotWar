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
    while (true) {
        switch (_currentState) {
            case kTurretStateScanning:
                [self turnRobotLeft:20];
                [self moveAhead:60];
                [self hitWall:180 hitAngle:90];
                [self shoot];
                break;
                
            case kTurretStateFiring:
                if (self.currentTimestamp - _timeSinceLastEnemyHit > 2.5f) {
                    [self cancelActiveAction];
                    _currentState = kTurretStateScanning;
                } else {
                    [self shoot];
                }
                break;
        }
    }
}

- (void)_bulletHitEnemy:(Bullet*)bullet {
    _timeSinceLastEnemyHit = self.currentTimestamp;
    _currentState = kTurretStateFiring;
}

-(void)gotHit{
    static int i = 20;
    i--;
    if (i <= 4) {
        int j;
        j = 0;
        j++;
        NSLog(@"TERMINATOR HAS %d HEALTH! IT IS INCREDIBLY LOW!!!", i);
        [self moveBack:200];
        [self turnRobotLeft:90];
        [self moveAhead:200];
        if (j == 2) {
            [self shoot];
            [self shoot];        [self shoot];
            [self shoot];        [self shoot];
            [self shoot];        [self shoot];
            [self shoot];        [self shoot];
            [self shoot];        [self shoot];
            [self shoot];        [self shoot];
            [self shoot];        [self shoot];
            [self shoot];        [self shoot];
            [self shoot];        [self shoot];
            [self shoot];        [self shoot];
            [self shoot];        [self shoot];
            [self shoot];        [self shoot];
            [self shoot];
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
    [self moveBack:320];
        [self shoot];
        [self shoot];
        [self shoot];
        [self shoot];
    [self moveAhead:0];
    }
}

@end
