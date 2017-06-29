# justDrawing
Simple very basic drawing api for cross toolkits, WIP, experimental.

### Example use
```haxe
surface.beginFill( 0xff0000, 1. );
surface.lineStyle( 2., 0x0000ff, 1. );
surface.drawCircle( 100, 100, 30 );
surface.endFill();
```
## Luxe
[luxe demo](https://rawgit.com/nanjizal/justDrawing/master/binLuxe/web/index.html)

## Flambe 
Flambe does not seem to have triangle render support so results are disappointing.
Gave up on flash build it seems to rely on hxsl which in depreciated, the js build needs some files copied from flambe git for flambe to run since haxelib flambe is out of date.

[flambe demo](https://rawgit.com/nanjizal/justDrawing/master/binFlambe/build/web/index.html)

## NME
works need to look at openfl for web demo?

# Canvas
No Main class yet

# SVG
No Main class yet

# Swing
No Main class yet

# Pixels
No Main class yet
