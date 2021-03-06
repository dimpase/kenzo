# Welcome to Kenzo

According to the title of its
[handbook](http://www-fourier.ujf-grenoble.fr/~sergerar/Kenzo/Kenzo-doc.pdf),
Kenzo is a "Symbolic Software for Effective Homology Computation" and
its main audience might be students and researchers in algebraic topology.
It is also a remarkable piece of LISP code, albeit in need of a little touch-up.

This repository contains a repackaged version of the Kenzo program by Francis Sergeraert
and collaborators. The original version of the program can be found
at http://www-fourier.ujf-grenoble.fr/~sergerar/Kenzo/ .
This version aims to update its infrastructure by providing the following:

1. A simple regression test suite based on [FiveAM](http://common-lisp.net/project/fiveam/)
2. Support for [SBCL](http://www.sbcl.org/)
3. Installation via the [Quicklisp](http://www.quicklisp.org/beta/) library
   manager

Items 1 and 2 are well underway. Item 3 is on hold, because there's apparently no license
attached to Kenzo. I have made several attempts to contact the author(s), but never gotten
a response.

*!!! WARNING !!!*

This is work in progress. The entire code now compiles fine w/ SBCL, but that's
just the first step. There are plenty of examples in
[publications](http://www-fourier.ujf-grenoble.fr/~sergerar/Papers/) and scattered
throughout the source. Many work (most?), some don't. *Let's get to work! ...*

## Getting up and running

Here are two simple methods to get going: plain ASDF and Quicklisp.

### Plain ASDF

To load Kenzo as provided by this repo, make sure ASDF knowns where to find
the source, e.g. by creating a link to this directory at

      ~/.local/share/common-lisp/source/

Then in your Lisp (e.g. in ECL) type
```lisp
(require :asdf)
(require :kenzo)
```

### Quicklisp

I'm a big fan and supporter of [Quicklisp](http://www.quicklisp.org/beta/), and use it for all my local projects.
Assuming you've installed Quicklisp in `C:\home\quicklisp` or `/home/joeuser/quicklisp`, your *local projects directory* will be `C:\home\quicklisp\local-projects` or `/home/joeuser/quicklisp/local-projects`.

Making Kenzo `quickload`-able is a piece of cake:

1. Clone the Kenzo repository into your local projects directory, i.e., `C:\home\quicklisp\local-projects\kenzo` or `/home/joeuser/quicklisp/local-projects/kenzo`.
2. Tell Quicklisp about Kenzo by adding the following two lines to the `system-index.txt` file in the local projects directory:
```
  kenzo\kenzo.asd
  kenzo\kenzo-test.asd
```
Verify that you're good to go by loading and running the Kenzo test suite. For example, in an `sbcl` prompt (I've tested this with SBCL 1.2.12 on Debian and Windows) you should see something like this:
```
* (ql:quickload :kenzo-test)
To load "kenzo-test":
  Load 1 ASDF system:
    kenzo-test
; Loading "kenzo-test"
.
(:KENZO-TEST)
* (in-package :fiveam)

#<PACKAGE "IT.BESE.FIVEAM">
* (run!)

Running test suite KENZO
 Running test F-CMPR ..........
 Running test L-CMPR ..........
 Running test S-CMPR .....
 ...
 Running test CDELTA
---done---
 Did 329 checks.
    Pass: 329 (100%)
    Skip: 0 ( 0%)
    Fail: 0 ( 0%)
```

Similarly, you'd load Kenzo via `(ql:quickload :kenzo)`.
