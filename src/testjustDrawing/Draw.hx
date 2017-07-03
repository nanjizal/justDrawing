package testjustDrawing;
import justDrawing.Surface;
import testjustDrawing.Draw;
import justDrawing.justPath.SvgPath;
import justDrawing.justPath.SurfacePath;
using testjustDrawing.Draw;
class Draw {
    public static function testing( surface: Surface ){
        surface.whiteBackground();
        surface.redCircleBlueOutline();
        surface.yellowEquilateralTriangleGreenOutline();
        surface.purpleRectangleOrangeOutline();
        surface.quadraticHeart();
        surface.cubicHeart();
        surface.drawKiwi();
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
    public inline static function drawKiwi( surface: Surface ){
        var surfacePath = new SurfacePath( surface );
        surface.beginFill( 0xcccccc, 0.5 );
        surface.lineStyle( 1., 0x666666, lineAlpha );
        var p = new SvgPath( surfacePath );
        p.parse( bird_d, 0, 0 );
        surface.endFill();
    }
    
    static var bird_d = "M210.333,65.331C104.367,66.105-12.349,150.637,1.056,276.449c4.303,40.393,18.533,63.704,52.171,79.03c36.307,16.544,57.022,54.556,50.406,112.954c-9.935,4.88-17.405,11.031-19.132,20.015c7.531-0.17,14.943-0.312,22.59,4.341c20.333,12.375,31.296,27.363,42.979,51.72c1.714,3.572,8.192,2.849,8.312-3.078c0.17-8.467-1.856-17.454-5.226-26.933c-2.955-8.313,3.059-7.985,6.917-6.106c6.399,3.115,16.334,9.43,30.39,13.098c5.392,1.407,5.995-3.877,5.224-6.991c-1.864-7.522-11.009-10.862-24.519-19.229c-4.82-2.984-0.927-9.736,5.168-8.351l20.234,2.415c3.359,0.763,4.555-6.114,0.882-7.875c-14.198-6.804-28.897-10.098-53.864-7.799c-11.617-29.265-29.811-61.617-15.674-81.681c12.639-17.938,31.216-20.74,39.147,43.489c-5.002,3.107-11.215,5.031-11.332,13.024c7.201-2.845,11.207-1.399,14.791,0c17.912,6.998,35.462,21.826,52.982,37.309c3.739,3.303,8.413-1.718,6.991-6.034c-2.138-6.494-8.053-10.659-14.791-20.016c-3.239-4.495,5.03-7.045,10.886-6.876c13.849,0.396,22.886,8.268,35.177,11.218c4.483,1.076,9.741-1.964,6.917-6.917c-3.472-6.085-13.015-9.124-19.18-13.413c-4.357-3.029-3.025-7.132,2.697-6.602c3.905,0.361,8.478,2.271,13.908,1.767c9.946-0.925,7.717-7.169-0.883-9.566c-19.036-5.304-39.891-6.311-61.665-5.225c-43.837-8.358-31.554-84.887,0-90.363c29.571-5.132,62.966-13.339,99.928-32.156c32.668-5.429,64.835-12.446,92.939-33.85c48.106-14.469,111.903,16.113,204.241,149.695c3.926,5.681,15.819,9.94,9.524-6.351c-15.893-41.125-68.176-93.328-92.13-132.085c-24.581-39.774-14.34-61.243-39.957-91.247c-21.326-24.978-47.502-25.803-77.339-17.365c-23.461,6.634-39.234-7.117-52.98-31.273C318.42,87.525,265.838,64.927,210.333,65.331zM445.731,203.01c6.12,0,11.112,4.919,11.112,11.038c0,6.119-4.994,11.111-11.112,11.111s-11.038-4.994-11.038-11.111C434.693,207.929,439.613,203.01,445.731,203.01z";
    
}