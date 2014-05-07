//
//  PrintView.h
//  GroupMePrinter2
//
//  Created by Middlin, Paul on 5/7/14.
//  Copyright (c) 2014 PaulSpot. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PrintView : NSView
- (id)initWithMessages:(NSArray*)messages;
@property NSArray* messages;

@end
