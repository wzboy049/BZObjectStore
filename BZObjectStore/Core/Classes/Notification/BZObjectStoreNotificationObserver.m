//
// The MIT License (MIT)
//
// Copyright (c) 2014 BZObjectStore
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "BZObjectStoreNotificationObserver.h"

@interface BZObjectStoreNotificationObserver()
@property (nonatomic,strong) NSString *name;
@property (nonatomic,copy) void(^usingBlock)(NSNotification *note);
@property (nonatomic,strong) id observer;
@end

@implementation BZObjectStoreNotificationObserver

+ (instancetype)observerForName:(NSString*)name usingBlock:(void(^)(NSNotification *note))usingBlock
{
    BZObjectStoreNotificationObserver *osObserver = [[self alloc]init];
    osObserver.name = name;
    osObserver.usingBlock = usingBlock;
    osObserver.enabled = YES;
    return osObserver;
}


- (void)setEnabled:(BOOL)enabled
{
    if (enabled) {
        if (self.observer) {
            return;
        } else {
            NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
            self.observer = [center addObserverForName:self.name object:nil queue:nil usingBlock:self.usingBlock];
        }
    } else {
        if (!self.observer) {
            return;
        } else {
            NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
            [center removeObserver:self.observer];
            self.observer = nil;
        }
    }
}

- (void)dealloc
{
    self.enabled = NO;
}

@end
