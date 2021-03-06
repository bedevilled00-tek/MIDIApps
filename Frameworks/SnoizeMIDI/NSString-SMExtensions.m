/*
 Copyright (c) 2005-2006, Kurt Revis.  All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 * Neither the name of Kurt Revis, nor Snoize, nor the names of other contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */


#import "NSString-SMExtensions.h"
#import "SMUtilities.h"
#import "SMClient.h"


@implementation NSString (SMExtensions)

+ (NSString *)SnoizeMIDI_abbreviatedStringForByteCount:(NSUInteger)byteCount
{
    NSBundle *bundle = [NSBundle bundleForClass: [SMClient class]];
    NSString *abbreviatedString = nil;
    
    if (byteCount == 1) {
        abbreviatedString = NSLocalizedStringFromTableInBundle(@"1 byte", @"SnoizeMIDI", bundle, "string for 1 byte");
    } else {
        NSString *format = nil;
        
        if (byteCount < 1024) {
            format = NSLocalizedStringFromTableInBundle(@"%d bytes", @"SnoizeMIDI", bundle, "format for < 1024 bytes");
            abbreviatedString = [NSString stringWithFormat: format, byteCount];
        } else {
            double fractionalUnits = byteCount;
            
            fractionalUnits /= 1024.0;
            if (fractionalUnits < 1024.0) {
                format = NSLocalizedStringFromTableInBundle(@"%0.1f KB", @"SnoizeMIDI", bundle, "format for kilobytes");
            } else {
                fractionalUnits /= 1024.0;
                if (fractionalUnits < 1024.0) {
                    format = NSLocalizedStringFromTableInBundle(@"%0.1f MB", @"SnoizeMIDI", bundle, "format for megabytes");
                } else {
                    fractionalUnits /= 1024.0;
                    if (fractionalUnits < 1024.0) {
                        format = NSLocalizedStringFromTableInBundle(@"%0.1f GB", @"SnoizeMIDI", bundle, "format for gigabytes");
                    } else {
                        fractionalUnits /= 1024.0;
                        if (fractionalUnits < 1024.0) {
                            format = NSLocalizedStringFromTableInBundle(@"%0.1f TB", @"SnoizeMIDI", bundle, "format for terabytes");
                        } else {
                            fractionalUnits /= 1024.0;                            
                            format = NSLocalizedStringFromTableInBundle(@"%0.1f PB", @"SnoizeMIDI", bundle, "format for petabytes");
                        }
                    }                    
                }
            }
            
            abbreviatedString = [NSString stringWithFormat:format, fractionalUnits];
        }                
    }

    return abbreviatedString;
}

@end
