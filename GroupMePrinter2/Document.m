//
//  Document.m
//  GroupMePrinter2
//
//  Created by Middlin, Paul on 5/6/14.
//  Copyright (c) 2014 PaulSpot. All rights reserved.
//

#import "Document.h"
#import "PrintView.h"

@implementation Document

- (id)init
{
    self = [super init];
    if (self) {
      // Add your subclass-specific initialization here.
    }
    return self;
}

- (NSString *)windowNibName
{
   // Override returning the nib file name of the document
   // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
   return @"Document";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
   [super windowControllerDidLoadNib:aController];
   // Add any code here that needs to be executed once the windowController has loaded the document's window.
}

+ (BOOL)autosavesInPlace
{
    return YES;
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
   // Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning nil.
   // You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
   NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
   @throw exception;
   return nil;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
   // Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning NO.
   // You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
   // If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
   //NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
   //@throw exception;
   
   self.contents = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers|NSJSONReadingAllowFragments error:outError];
   
   
   
   return YES;
}


// peep this: https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/Printing/osxp_printapps/osxp_printapps.html
- (NSPrintOperation *)printOperationWithSettings:(NSDictionary *)printSettings error:(NSError **)outError
{
   PrintView* printView = [[PrintView alloc] initWithMessages:self.contents];
   NSPrintInfo* printInfo = [NSPrintInfo sharedPrintInfo];
   NSPrintOperation* printOp = [NSPrintOperation printOperationWithView:printView printInfo:printInfo];
   return printOp;
}

@end
