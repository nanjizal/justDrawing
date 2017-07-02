# justDrawing
Simple very basic drawing api for cross toolkits, WIP, experimental.
Rework of https://github.com/hxDaedalus/hxDaedalus/tree/master/src/wings

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
Triangle, Circle support via strips. Flash Flambe as a target seems broken, for js you will need to patch some files from flambe git to haxelib. Target limited.

[flambe demo](https://rawgit.com/nanjizal/justDrawing/master/binFlambe/build/web/index.html)

## NME
works need to look at openfl for web demo?

# Canvas
[javascript canvas demo](https://rawgit.com/nanjizal/justDrawing/master/binCanvas/index.html)

# SVG
SVG implementation needs some tweaks it should be changed so that you can fill path should not be hard to implement.
[javascript SVG demo](https://rawgit.com/nanjizal/justDrawing/master/binSVG/index.html)

# Swing
[Java Swing you can download jar](https://github.com/nanjizal/justDrawing/blob/master/binSwing/MainSwing-Debug.jar)

# Pixels
No Main class yet untested.

### Kha & Heaps
No plans ?
