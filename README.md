URLValidator
============

A block based class to check if a string forms a valid url and if the link is live

## Installation

* Drag the `URLValidator` folder into your project.
* Drag `URLValidator.h` and `URLValidator.m` files into your project 
* Import #URLValidator.h into your class


## How To Use

Provide a string, like so....

    NSString *fullURLString = @"http://www.google.com";

    [self.myValidator validateURLFromString:fullURLString completionHandler:^(URLCheckResult result) {
        if (result == URLAccepted){
            // The URL is valid
            [self.linkButton setEnabled:TRUE];
        }
        else{
            // The URL is invalid
            [self.linkButton setEnabled:FALSE];
        }
    }];

## Results

### URLMalformed
If you get this result then the string couldn't even be made into a url. It might contain spaces or other invalid characters.

### URLNotAccepted
If you get this result then the string was made into a URL but no reply was recieved at that address

### URLAccepted
If you get this result then the string was made into a URL and a reply was recieved from that address. A link with this result should be valid.


