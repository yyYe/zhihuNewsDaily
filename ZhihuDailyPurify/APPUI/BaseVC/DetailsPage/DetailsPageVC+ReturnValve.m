//
//  DetailsPageVC+ReturnValve.m
//  
//
//  Created by loufq on 16/1/8.
//
//

#import "DetailsPageVC+ReturnValve.h"
#import "DetailsModel.h"

@implementation DetailsPageVC (ReturnValve)

- (void)jumpDetailsBtnTapped:(NSArray *)list Number:(NSInteger)number dictData:(NSDictionary *)data {
    NSDictionary *dictData = [list objectAtIndex:number];
    NSNumber *idNumber = [dictData valueForKey:@"id"];
    long num = [idNumber longValue];
    NSString *idString = [NSString stringWithFormat:@"%ld",num];
    NSString *webString = [data valueForKey:@"share_url"];
    //取出点击的cell的id，把它替换到取到的数据接口最后面， 就是需要显示的完整链接
    NSString *WEBString =[webString stringByReplacingOccurrencesOfString:@"3892357" withString:idString];
    self.idString = idString;
    self.request = [NSURLRequest requestWithURL:[NSURL URLWithString:WEBString]];
}


- (void)jumpHeaderViewDetailsTapped:(NSDictionary *)data Number:(NSInteger)number {
    NSNumber *idNumber = [data valueForKey:@"id"];
    long num = [idNumber longValue];
    NSString *idString = [NSString stringWithFormat:@"%ld",num];
    NSString *webString = [data valueForKey:@"share_url"];
    //取出点击的cell的id，把它替换到取到的数据接口最后面， 就是需要显示的完整链接
    NSString *WEBString =[webString stringByReplacingOccurrencesOfString:@"3892357" withString:idString];
    self.idString = idString;
    self.request = [NSURLRequest requestWithURL:[NSURL URLWithString:WEBString]];
}

@end
