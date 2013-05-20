TCSpinner
=========

A UIView subclass containing four circles that animate towards one another.



Features
--------

-   A TCSpinner UIView that is configurable

-   Easy to use properties to change color, fade in/out, fade speed, spinner
    speed, and timing function

-   Exposes configuration properties on CABasicAnimation to allow the
    manipulation of the animation

-   Light weight, Clean, Easy to read, self explaining code you will enjoy using
    in your projects.



![](<https://raw.github.com/crizzwald/TCSpinner/master/Screenshot.png>)



Requirements
------------

-   iOS 6.0 or later

-   ARC memory management.



Usage
-----

Add the dependency to your Podfile:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
platform :iOS, '6.0'
pod 'TCSpinner'
...
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



Or copy the following to your project:

-   TCSpinner.h

-   TCSpinner.m

Initialize an instance of a TCSpinner by passing in a UIColor and CGRect (or use
init for default values).

Use the TCSpinner instance in your code as you would use any other UIView.



Basic Description

Initializing a TCSpinner UIView:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (id)initWithColor:(UIColor )color frame:(CGRect)frame;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Start Animating and Stop Animating:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)startAnimating;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)stopAnimating;
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Configuration Properties:

-   UIColor color;

-   BOOL fadeIn;

-   BOOL fadeOut;

-   float fadeSpeed;

-   float spinnerSpeed;

-   CAMediaTimingFunction timingFunction;



Other methods are documented in the TCSpinner.h header file.



License
-------

Copyright (c) 2013 Todd Crown [toddcrown@gmail.com][1]

[1]: <mailto:toddcrown@gmail.com>



Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions: The above copyright notice and this
permission notice shall be included in all copies or substantial portions of the
Software.



THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
