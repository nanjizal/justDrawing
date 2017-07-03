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
        surface.quadraticHeart();
        surface.cubicHeart();
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
    public inline static function quadraticHeart( surface: Surface ){
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
    public inline static function cubicHeart( surface: Surface ){
        trace( 'heart cubic curves' );
        surface.beginFill( 0x29f500 , fillAlpha );
        surface.lineStyle( 5.,0xf50072 , lineAlpha );
        var s = 0.5;
        var cx = 500 - 10;
        var cy = 100 - 22;
        surface.moveTo( cx, cy );
        var cx = cx - 75*s;
        var cy = cy - 40*s;
        surface.curveTo( cx+75*s, cy+37*s, cx+70*s, cy+25*s, cx+50*s, cy+25*s );
        surface.curveTo( cx+20*s, cy+25*s, cx+20*s, cy+62.5*s, cx+20*s, cy+62.5*s );
        surface.curveTo( cx+20*s, cy+80*s, cx+40*s, cy+102*s, cx+75*s, cy+120*s );
        surface.curveTo( cx+110*s, cy+102*s, cx+130*s, cy+80*s, cx+130*s, cy+62.5*s );
        surface.curveTo( cx+130*s, cy+62.5*s, cx+130*s, cy+25*s, cx+100*s, cy+25*s );
        surface.curveTo( cx+85*s, cy+25*s, cx+75*s, cy+37*s, cx+75*s, cy+40*s );
        surface.endFill();
    }
}