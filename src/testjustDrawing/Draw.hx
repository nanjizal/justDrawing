package testjustDrawing;
import justDrawing.Surface;
import testjustDrawing.Draw;
using testjustDrawing.Draw;
class Draw {
    public static function testing( surface: Surface ){
        surface.whiteBackground();
        surface.redCircleBlueOutline();
        surface.yellowEquilateralTriangleGreenOutline();
        surface.purpleRectangleOrangeOutline();
        surface.heart();
    }
    public inline static var fillAlpha: Float = 1.;
    public inline static var lineAlpha: Float = 1.;
    public inline static function whiteBackground( surface: Surface ){
        trace( 'draw white background' );
        surface.beginFill( 0xffffff, fillAlpha );
        surface.lineStyle( 2., 0xff0000, lineAlpha );
        surface.drawRect( 1, 1, 1024-2, 768-2 );
        surface.endFill();
    }
    public inline static function redCircleBlueOutline( surface: Surface ){
        trace( 'draw red circle with a blue outline' );
        surface.beginFill( 0xff0000, fillAlpha );
        surface.lineStyle( 2., 0x0000ff, lineAlpha );
        surface.drawCircle( 100, 100, 30 );
        surface.endFill();
    }
    public inline static function yellowEquilateralTriangleGreenOutline( surface: Surface ){
        trace( 'draw a yellow equilateral triangle with green outline' );
        surface.beginFill( 0xffff00, fillAlpha );
        surface.lineStyle( 2., 0x00ff00, lineAlpha );
        surface.drawEquilaterialTri( 300, 100, 30, -Math.PI/2 );
        surface.endFill();
    }
    public inline static function purpleRectangleOrangeOutline( surface: Surface ){
        trace( 'draw a purple rectangle with orange outline' );
        surface.beginFill( 0x551a8b, fillAlpha );
        surface.lineStyle( 2., 0xffa500, lineAlpha );
        surface.drawRect( 100-30, 300-30, 60, 60 );
        surface.endFill();
    }
    public inline static function heart( surface: Surface ){
        trace( 'heart quadratic curves' );
        surface.beginFill( 0xC1D208, fillAlpha );
        surface.lineStyle( 5., 0x34DDDD, lineAlpha );
        var cx = 300;
        var cy = 300;
        surface.moveTo( cx - 27, cy - 20 );
        surface.quadTo( cx - 15, cy - 30, cx, cy - 15 );
        surface.quadTo( cx + 15, cy - 30, cx + 27, cy - 20 );
        surface.quadTo( cx + 34, cy - 5, cx + 20, cy + 6 );
        surface.quadTo( cx + 25, cy, cx, cy + 30 );
        surface.quadTo( cx - 25, cy, cx - 20, cy + 6 );
        surface.quadTo( cx - 34, cy - 5, cx - 28, cy - 20 );
        surface.endFill();
    }
}