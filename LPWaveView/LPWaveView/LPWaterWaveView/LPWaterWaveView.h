//
//  LPWaterWaveView.h
//  LPWaveView
//
//  Created by apple on 2017/6/22.
//  Copyright © 2017年 bluceLiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPWaterWaveView : UIView
/*
 * the speed of wave //波浪速度
 */
@property(nonatomic,assign)CGFloat waveSpeed;
/*
 * 波浪振幅 amplitude of wave
 */
@property(nonatomic,assign)CGFloat waveAmlitude;

/*
   start waving
*/
- (void)wave;

/*
  stop waving
 */

- (void)stop;

@end
