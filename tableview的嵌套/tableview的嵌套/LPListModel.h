//
//  LPListModel.h
//  tableview的嵌套
//
//  Created by apple on 16/7/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@class CommentMessages;

@interface LPListModel : JSONModel

@property (nonatomic, copy) NSString *message;
@property(nonatomic,assign)float  height;//缓存的高度
@property (nonatomic, copy) NSString *message_type;

@property (nonatomic, assign) long long createDate;

@property (nonatomic, copy) NSString *objId;

@property (nonatomic, copy) NSString *checkStatus;

@property (nonatomic, strong) NSArray<NSString *> *messageSmallPics;

@property (nonatomic, copy) NSString *cid;

@property (nonatomic, copy) NSString *createDateStr;

@property (nonatomic, copy) NSString *timeTag;

@property (nonatomic, assign) NSInteger userId;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, strong) NSArray<NSString *> *messageBigPics;

@property (nonatomic, strong) NSArray<CommentMessages *> *commentMessages;

@property (nonatomic, copy) NSString *photo;

@property (nonatomic, assign) NSInteger message_id;
@end
@interface CommentMessages : JSONModel

@property (nonatomic, assign) NSInteger commentUserId;

@property (nonatomic, copy) NSString *commentPhoto;

@property (nonatomic, copy) NSString *commentText;

@property (nonatomic, copy) NSString *commentByUserName;

@property (nonatomic, copy) NSString *createDateStr;

@property (nonatomic, copy) NSString *commentUserName;

@property (nonatomic, copy) NSString *commentByPhoto;

@property (nonatomic, assign) long long createDate;

@property (nonatomic, copy) NSString *commentId;

@property (nonatomic, copy) NSString *commentByUserId;

@property (nonatomic, copy) NSString *checkStatus;

@end
