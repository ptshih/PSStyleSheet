PSStyleSheet
---
This is a custom stylesheet driven by a plist file

PSStyleSheet is a plist driven label/button configuration class
It tries to remedy the lack of a true stylesheet (like CSS) in UIKit

How to use:
*** First make sure you have a style sheet set. Omit the .plist extension ***
*** Make sure you have a style sheet called "MyStyleSheet.plist" in your app bundle ***
*** Now set it ASAP after app launches: [PSStyleSheet setStyleSheet:@"MyStyleSheet"]; ***

1. UILabel *myLabel = ...
2. [PSStyleSheet applyStyle:@"myLabelStyle" forLabel:myLabel];
3. ???
4. Profit!

1. UIButton *myButton = ...
2. [PSStyleSheet applyStyle:@"myButtonStyle" forButton:myButton];
3. ???
4. Profit!

Future enhancements:
- CSS to PLIST conversion script
- Automated stylesheet updating by detecting when the stylesheet file is changed

LICENSE
---
Copyright (C) 2011 Peter Shih. All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this
list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation
and/or other materials provided with the distribution.

* Neither the name of the author nor the names of its contributors may be used
to endorse or promote products derived from this software without specific
prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.