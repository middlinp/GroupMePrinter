//
//  PrintView.m
//  GroupMePrinter2
//
//  Created by Middlin, Paul on 5/7/14.
//  Copyright (c) 2014 PaulSpot. All rights reserved.
//

#import "PrintView.h"


@implementation PrintView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (id)initWithMessages:(NSArray*)messages
{
   self.messages = messages;
   
   const int width = 600;
   const int rowHeight = 50;
   NSRect frame = NSMakeRect(0, 0, width, rowHeight * messages.count );
   self = [super initWithFrame:frame];
   if (self) {
      // Initialization code here.
   }
   return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
   [super drawRect:dirtyRect];
   [[NSColor whiteColor] set]; NSRectFill([self bounds]);
   
   int y=0;
   for (NSDictionary* thing in self.messages)
   {
      // Drawing code here.
      CGFloat yLoc = y*50;
      
      NSRect itemRect = NSInsetRect( NSMakeRect(0, yLoc, 1000, 50 ), 5, 5 );
      
      [[NSColor greenColor] set]; NSRectFill(itemRect);
      
      NSMutableDictionary * stringAttributes;
      stringAttributes = [NSMutableDictionary dictionary];
      [stringAttributes setObject:[NSFont fontWithName:@"Monaco" size:10] forKey:NSFontAttributeName];
      [stringAttributes setObject:[NSColor blackColor] forKey:NSForegroundColorAttributeName];
      [[thing objectForKey:@"text"] drawAtPoint:NSMakePoint(10.0, yLoc + 5) withAttributes:stringAttributes];
      y++;
   }
}

// Return the number of pages available for printing
- (BOOL)knowsPageRange:(NSRangePointer)range {
   NSRect bounds = [self bounds];
   float printHeight = [self calculatePrintHeight];
   
   range->location = 1;
   range->length = NSHeight(bounds) / printHeight + 1;
   return YES;
}

// Return the drawing rectangle for a particular page number
- (NSRect)rectForPage:(long)page {
   NSRect bounds = [self bounds];
   float pageHeight = [self calculatePrintHeight];
   return NSMakeRect( NSMinX(bounds), NSMaxY(bounds) - page * pageHeight,
                     NSWidth(bounds), pageHeight );
}

// Calculate the vertical size of the view that fits on a single page
- (float)calculatePrintHeight {
   // Obtain the print info object for the current operation
   NSPrintInfo *pi = [[NSPrintOperation currentOperation] printInfo];
   
   // Calculate the page height in points
   NSSize paperSize = [pi paperSize];
   float pageHeight = paperSize.height - [pi topMargin] - [pi bottomMargin];
   
   // Convert height to the scaled view
   float scale = [[[pi dictionary] objectForKey:NSPrintScalingFactor]
                  floatValue];
   return pageHeight / scale;
}

-(void)adjustPageHeightNew:(CGFloat *)newBottom top:(CGFloat)oldTop bottom:(CGFloat)oldBottom limit:(CGFloat)bottomLimit
{
   
}

@end
