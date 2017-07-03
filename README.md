# justDrawing
Simple very basic drawing api for cross toolkits, WIP, experimental.

Rework of https://github.com/hxDaedalus/hxDaedalus/tree/master/src/wings 

but with aspects of justTriangles, like simple svg path parsing.

![justdrawingkiwi](https://user-images.githubusercontent.com/20134338/27797254-dca94ef6-6004-11e7-846c-1a6b0e336c3d.png)


### Example use
``` haxe
surface.beginFill( 0xff0000, 1. );
surface.lineStyle( 2., 0x0000ff, 1. );
surface.drawCircle( 100, 100, 30 );
surface.endFill();
```
and for svg path data as a string.
``` haxe
var surfacePath = new SurfacePath( surface );
var p = new SvgPath( surfacePath );
surface.beginFill( 0xcccccc, 0.5 );
surface.lineStyle( 1., 0x666666, lineAlpha );
p.parse( bird_d, 0, 0 );
surface.endFill();
```
## Luxe
[luxe demo](https://rawgit.com/nanjizal/justDrawing/master/binLuxe/web/index.html)

## Flambe 
Triangle, Circle support via strips. Flash Flambe as a target seems broken, for js you will need to patch some files from flambe git to haxelib. Target limited.

[flambe demo](https://rawgit.com/nanjizal/justDrawing/master/binFlambe/build/web/index.html)

## NME / OpenFL
[openfl web demo](https://rawgit.com/nanjizal/justDrawing/master/binOpenFL/Exports/html5/release/bin/index.html)

## Canvas
[javascript canvas demo](https://rawgit.com/nanjizal/justDrawing/master/binCanvas/index.html)

## SVG
SVG implementation needs some tweaks it should be changed so that you can fill path should not be hard to implement.

[javascript SVG demo](https://rawgit.com/nanjizal/justDrawing/master/binSVG/index.html)

## Swing
[Java Swing you can download jar](https://github.com/nanjizal/justDrawing/blob/master/binSwing/MainSwing-Debug.jar)

### Pixels
Creates a png file:

![h](https://github.com/nanjizal/justDrawing/blob/master/binPixels/neko/out_shapes.png)

### Kha & Heaps
No plans ?
