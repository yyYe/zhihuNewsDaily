//
//  DetailsPageVC+ReturnValve.h
//  
//
//  Created by loufq on 16/1/8.
//
//

#import "DetailsPageVC.h"

@interface DetailsPageVC (ReturnValve)

- (void)jumpDetailsBtnTapped:(NSArray *)list Number:(NSInteger)number dictData:(NSDictionary *)data;

- (void)jumpHeaderViewDetailsTapped:(NSDictionary *)data Number:(NSInteger)number;

@end
