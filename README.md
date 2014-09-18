# Axial Hexagonal Grid

Axial hexagonal grid, tile and coordinate system for HTML5 Canvas.

## Reference material and inspirational sources

- [Red Blob Games](http://www.redblobgames.com/grids/hexagons/)
- [DevMag](http://devmag.org.za/2013/08/31/geometry-with-hex-coordinates)

# Test-suite

Using jasmine-node, jasmine-reporters and guard to trigger specs when files change.

## Setup Test Environment

Requires ruby, node.js, npm and Cairo with xcb-shm from X11.

### Node Canvas and Cairo (on OS X Mavericks)

Using (node-)canvas for some specs which requires Cairo.

I installed Cairo with Homebrew, so I had to symlink some files from /opt/X11/lib/pkgconfig to /usr/local/lib/pkgconfig before I could install (node-)canvas as such:

```
    $ ln -s /opt/X11/lib/pkgconfig/{xcb-shm,xcb,pthread-stubs,xau,xproto,xdmcp,xcb-render,xrender,renderproto,x11,kbproto,xext,xextproto}.pc /usr/local/lib/pkgconfig
```

Go to project folder and run:

```
    $ bundle install
    $ npm install
```

### Hickups

In-case you get "out of memory" errors in the specs, it might be because of a conflict between pixman and libpng.

```
    $ brew uninstall pixman cairo libpng
    $ brew install pixman cairo libpng
    $ npm rebuild canvas
```

## Auto-running specs

Go to project folder and run:

```
    $ guard
```

## Manually running specs

Go to project folder and run:

```
    $ npm test
```

# Contributing

Submit pull-requests and report bugs over at the projects [GitHub Issue Tracking](https://github.com/RobertBrewitz/axial-hexagonal-grid/issues)

# License

The MIT License (MIT)

Copyright (c) 2014 Robert Brewitz Borg

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
