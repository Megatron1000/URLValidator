//The MIT License (MIT)
//
//Copyright (c) 2013 Mark Bridges
//
//Permission is hereby granted, free of charge, to any person obtaining a copy of
//this software and associated documentation files (the "Software"), to deal in
//the Software without restriction, including without limitation the rights to
//use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//the Software, and to permit persons to whom the Software is furnished to do so,
//subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "URLValidator.h"

@interface URLValidator ()

@property (nonatomic, copy) URLCheckCompletionHandler completionHandler;

@end

@implementation URLValidator

- (void)validateURLFromString:(NSString*)urlString completionHandler:(URLCheckCompletionHandler)completionHandler{

    self.completionHandler = completionHandler;

    if (self.connection) {
        [self.connection cancel];
    }

    if (![self validateStringAsURL:urlString]) {
        self.completionHandler(URLMalformed);
    }
    else{
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        self.connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{

    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    NSInteger code = [httpResponse statusCode];

    if (code == 200) {
        self.completionHandler(URLAccepted);
    }
    else{
        self.completionHandler(URLNotAccepted);
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{

    self.completionHandler(URLNotAccepted);
}

- (BOOL)validateStringAsURL:(NSString*)urlString{

    if (urlString.length==0) {
        return FALSE;
    }

    BOOL validURL = FALSE;

    NSURL *candidateURL = [NSURL URLWithString:urlString];
    if (candidateURL && candidateURL.scheme && candidateURL.host) {
        validURL = TRUE;
    }
    return validURL;
}

@end
