package justDrawing;

#if pixel
import pixelDrawing.*;
#elseif flambe

#elseif (flash || openfl || nme)

#elseif luxe
import luxe.*;
import phoenix.*;
import phoenix.geometry.*;
import phoenix.Batcher;
#elseif svg
import js.html.svg.SVGElement;
import js.html.Node;
import js.Browser;
#elseif js

#elseif java
import java.awt.Graphics2D;
import java.awt.geom.GeneralPath;
#end


#if pixel
typedef TargetCanvas = hxPixels.Pixels;
#elseif flambe
typedef TargetCanvas = flambe.Entity;
#elseif (flash || openfl || nme)
typedef TargetCanvas = flash.display.Graphics;
#elseif luxe
typedef TargetCanvas = Array<phoenix.geometry.Geometry>;
typedef PVertex = phoenix.geometry.Vertex;
#elseif svg
typedef TargetCanvas = js.html.svg.SVGElement;
// path commands used when filling
@:enum
abstract PathCommand( String ) {
    var moveTo = 'M'; 
    var lineTo = 'L';
    var horizontalLine = 'H'; // not used
    var verticalLine = 'V';   // not used
    var curveTo = 'C';        // to do add!!
    var smoothCurveTo = 'S';  // not used need to calculate reflection of previous control points
    var quadTo = 'Q';         // quadratic Bézier curve
    var smoothQuadTo = 'T';   // not used
    var arcTo = 'A';          // definitely not used!
    var endPath = 'Z';        // endFill
}
#elseif js
typedef TargetCanvas = js.html.CanvasRenderingContext2D;
#elseif java
typedef TargetCanvas = justDrawing.SurfaceJPanel;
#end



// Tested against Luxe more thought required on arbitary shapes.
class Surface {
    var prevX:      Float = 0;
    var prevY:      Float = 0;
    var lineColor:  Int;
    var lineAlpha:  Float;
    var fillColor:  Int;
    var fillAlpha:  Float;
    var thickness:  Float;
    var width:      Int;
    var height:     Int;
    var inFill:     Bool = false;
    var graphics:   TargetCanvas;
    
    #if flambe 
    // for circles
    public inline static var totalSegments: Int = 45;
    #end
    
    // luxe must be before js and svg
    #if luxe
    public static inline function getColor( color: Int, alpha: Float ): luxe.Color {
        var color = new Color().rgb( color );
        color.a = alpha;
        return color;
    }
    #elseif (svg || js)
    public inline static function getColor( col: Int, ?alpha:Float ): String {
        var str: String;
        if( alpha != null && alpha != 1.0 ){
            var r = (col >> 16) & 0xFF;
            var g = (col >> 8) & 0xFF;
            var b = (col) & 0xFF;
            str ='rgba($r,$g,$b,$alpha)';
        } else {
            str ='#' + StringTools.hex( col, 6 );
        }
        return str;
    }
    #elseif java
    public inline static function getColor( col: Int, ?alpha: Float ): java.awt.Color {
        var a:Int = Std.int( alpha * 255 );
        return new java.awt.Color( col | (a << 24), true);
    }
    #end
    
    #if svg
    inline public static var svgNameSpace: String = "http://www.w3.org/2000/svg" ;
    public function repaint(){
        for( all in svgShapes ) {
            var node: Node = cast all;
            graphics.appendChild( node );
        }
    }
    public function remove( element: js.html.svg.SVGElement ): Void {
        if ( !graphics.hasChildNodes() ) return;
        var node: Node = cast element;
        graphics.removeChild( element );
    }
    #end
    #if luxe
    public inline static function vertexConverter( v: { x: Float, y: Float }, col: Color ):PVertex {
    		return new PVertex( new Vector( v.x, v.y ), col  );
    }
    #end
    
    #if pixel
    var pixelShapes: Array<ShapeEnum>  ;
    #elseif flambe
        //
    #elseif (flash || openfl || nme)
        //
    #elseif luxe
        //
    #elseif svg
    var svgShapes: Array<SVGElement>;
    #elseif js
        //
    #elseif java
    var path: GeneralPath;
    // must set before calling methods
    public var graphics2D: Graphics2D;
    #end
    
    
    
    public function new( graphics_: TargetCanvas ){
        graphics = graphics_;
        
        inFill   = false;
        
        #if pixel
            pixelShapes = new Array<ShapeEnum>();
        #elseif flambe
            //
        #elseif (flash || openfl || nme)
            //
        #elseif luxe
            //
        #elseif svg
            svgShapes = new Array<SVGElement>();
        #elseif js
            //
        #elseif java
            path = new GeneralPath();
        #end
    }
    public function clear(): Void {
        #if pixel
            var geom;
            while ((geom = pixelShapes.pop()) != null) {}
        #elseif flambe
            graphics.disposeChildren();
            prevX = 0;
            prevY = 0;
        #elseif (flash || openfl || nme)
            graphics.clear();
        #elseif luxe
            var geom;
            while ((geom = graphics.pop()) != null) geom.drop();
        #elseif svg
            currPathD = '';
            while( svgShapes.length != 0 ) remove( svgShapes.pop() );
        #elseif js
            graphics.clearRect( 0, 0, width, height );
        #elseif java
            var bounds = graphics.getBounds();
            graphics2D.clearRect( bounds.x, bounds.y, bounds.width, bounds.height );
        #end
    }
    public function lineStyle(  thick: Float, color: Int, ?alpha: Float = 1. ): Void {
        thickness = thick;
        lineColor = color;
        lineAlpha = alpha;
        
        #if pixel
            //
        #elseif flambe
            //
        #elseif (flash || openfl || nme)
            graphics.lineStyle( thickness, color, alpha );
        #elseif luxe
            //
        #elseif svg
            //if( inFill ) svgShapes[ svgShapes.length - 1 ].setAttribute('stroke', getColor( lineColor, lineAlpha ) );
        #elseif js
            graphics.lineWidth = thick;
            graphics.strokeStyle = getColor( lineColor, lineAlpha );
        #elseif java
            graphics2D.setStroke( new java.awt.BasicStroke( thickness ) );
            graphics2D.setColor( getColor( lineColor, lineAlpha ) );
        #end
    }
    #if svg
    public var currPathD: String;
    #end
    public function beginFill( color: Int, ?alpha: Float ): Void {
        fillColor = color;
        fillAlpha = alpha;
        inFill = true;
        
        #if pixel
            //
        #elseif flambe
            //
        #elseif (flash || openfl || nme)
            graphics.beginFill(color, alpha); 
        #elseif luxe
            //
        #elseif svg
            currPathD = '';
            var svgPath: SVGElement = cast Browser.document.createElementNS( svgNameSpace, 'path' );
            svgShapes.push( svgPath );
        #elseif js
            graphics.fillStyle = getColor( fillColor, fillAlpha );
            graphics.beginPath();
        #elseif java
        
        #end
    }
    public function endFill(): Void {
        var wasFill = inFill;
        inFill = false;
        
        #if pixel
            //
        #elseif flambe
            //
        #elseif (flash || openfl || nme)
            graphics.endFill();
        #elseif luxe
            //
        #elseif svg
            trace(' endFill ' + currPathD );
            var svgPath = svgShapes[ svgShapes.length - 1 ];
            svgPath.setAttribute('d', currPathD + PathCommand.endPath );
            svgPath.setAttribute( "fill", getColor( fillColor, fillAlpha ) );
            svgPath.setAttribute('stroke', getColor( lineColor, lineAlpha ) );
            svgPath.setAttribute('stroke-width', Std.string( thickness ) );
            var node: Node = cast svgPath;
            graphics.appendChild( node );
            currPathD = '';
        #elseif js
            graphics.stroke();
            graphics.closePath();
            graphics.fill();
        #elseif java
            path.closePath();
            if( wasFill ){
                graphics2D.setColor( getColor( fillColor, fillAlpha ) );
                graphics2D.fill( path );
                graphics2D.setColor( getColor( lineColor, lineAlpha ) );
                graphics2D.draw( path );
            }
        #end
    }
    public function moveTo( x: Float, y: Float ): Void {
        prevX = x;
        prevY = y;
        
        #if pixel
            //
        #elseif flambe
            //
        #elseif (flash || openfl || nme)
            graphics.moveTo( x, y );
        #elseif luxe
            //
        #elseif svg
            if( inFill ) currPathD += '' + PathCommand.moveTo + x + ',' + y + ' ';
        #elseif js
            graphics.beginPath();
            graphics.moveTo( x, y );
        #elseif java
            path.reset();
            path.moveTo(x, y);
        #end
    }
    public function lineTo( x: Float, y: Float ): Void {
        #if pixel
            var aLine = new Line( graphics, prevX, prevY, x, y, thickness );
        	aLine.plot( lineColor, lineAlpha );
            pixelShapes[ pixelShapes.length ] = ELine( aLine );
        #elseif flambe
            var dx = prevX - x;
            var dy = prevY - y;
            var distance = Math.sqrt( dx * dx + dy * dy );
            var angle = Math.atan2( dy, dx );
            var degrees = flambe.math.FMath.toDegrees( angle);
            var shape: flambe.display.Sprite = new flambe.display.FillSprite( 
                                lineColor, distance, thickness)
                                .setRotation( degrees )
                                .setXY( x, y )
                                .setAnchor( 0, thickness / 2 )
                                .setAlpha( lineAlpha );
            shape.pixelSnapping = false;
            graphics.addChild( new flambe.Entity().add( shape ) );
        #elseif (flash || openfl || nme)
            graphics.lineTo(x, y);
        #elseif luxe
            var geom = Luxe.draw.line({
                            p0: new Vector( prevX, prevY ),
                            p1: new Vector( x, y ),
                            color: getColor( lineColor, lineAlpha ) // may require optimize
                        });
            prevX = x;
            prevY = y;
            graphics[ graphics.length ] = geom;
        #elseif svg
            if( inFill ){
                if( inFill ) currPathD += ''+ PathCommand.lineTo + x + ',' + y + ' ';
            } else {
                var aLine: SVGElement = cast Browser.document.createElementNS( svgNameSpace, 'line');
                aLine.setAttribute('x1', Std.string( prevX ) );
                aLine.setAttribute('y1', Std.string( prevY ) );
                aLine.setAttribute('x2', Std.string( x ) );
                aLine.setAttribute('y2', Std.string( y ) );
                aLine.setAttribute('stroke', getColor( lineColor, lineAlpha ) );
                aLine.setAttribute('stroke-width', Std.string( thickness ) );
                var node: Node = cast aLine;
                graphics.appendChild( node );
                svgShapes.push( aLine );
            }
        #elseif js
            graphics.lineTo( x, y );
            //graphics.closePath();
            graphics.stroke();
        #elseif java
            path.lineTo( x, y );
            graphics2D.draw( path );
        #end
        
        prevX = x;
        prevY = y;
    }
    public static var cubicStep: Float = 0.03;
    public function curveTo( x1: Float, y1: Float, x2: Float, y2: Float, x3: Float, y3: Float ): Void {
        #if pixel
        /*
            //TODO: Needs fixing instead of below
            var cubic = new Cubic( graphics, prevX, prevY, x1, y1, x2, y2, x2, y3, thickness );
            cubic.plot( lineColor, lineAlpha );
            pixelShapes[ pixelShapes.length ] = ECubic( cubic );
            prevX = x3;
            prevY = y3;
        */
            var p0 = { x: prevX, y: prevY };
            var p1 = { x: x1, y: y1 };
            var p2 = { x: x2, y: y2 };
            var p3 = { x: x3, y: y3 };
            var approxDistance = distance( p0, p1 ) + distance( p1, p2 ) + distance( p2, p3 );
            var v: { x: Float, y: Float };
            if( approxDistance == 0 ) approxDistance = 0.000001;
            var step = Math.min( 1/( approxDistance*0.707 ), cubicStep );
            var arr = [ p0, p1, p2, p3 ];
            var t = 0.0;
            v = cubicBezier( 0.0, arr );
            lineTo( v.x, v.y );
            t += step;
            while( t < 1 ){
                v = cubicBezier( t, arr );
                lineTo( v.x, v.y );
                t += step;
            }
            v = cubicBezier( 1.0, arr );
            lineTo( v.x, v.y );
            prevX = x3;
            prevY = y3;
        #elseif flambe
            var p0 = { x: prevX, y: prevY };
            var p1 = { x: x1, y: y1 };
            var p2 = { x: x2, y: y2 };
            var p3 = { x: x3, y: y3 };
            var approxDistance = distance( p0, p1 ) + distance( p1, p2 ) + distance( p2, p3 );
            var v: { x: Float, y: Float };
            if( approxDistance == 0 ) approxDistance = 0.000001;
            var step = Math.min( 1/( approxDistance*0.707 ), cubicStep );
            var arr = [ p0, p1, p2, p3 ];
            var t = 0.0;
            v = cubicBezier( 0.0, arr );
            lineTo( v.x, v.y );
            t += step;
            while( t < 1 ){
                v = cubicBezier( t, arr );
                lineTo( v.x, v.y );
                t += step;
            }
            v = cubicBezier( 1.0, arr );
            lineTo( v.x, v.y );
        #elseif nme
            var p0 = { x: prevX, y: prevY };
            var p1 = { x: x1, y: y1 };
            var p2 = { x: x2, y: y2 };
            var p3 = { x: x3, y: y3 };
            var approxDistance = distance( p0, p1 ) + distance( p1, p2 ) + distance( p2, p3 );
            var v: { x: Float, y: Float };
            if( approxDistance == 0 ) approxDistance = 0.000001;
            var step = Math.min( 1/( approxDistance*0.707 ), cubicStep );
            var arr = [ p0, p1, p2, p3 ];
            var t = 0.0;
            v = cubicBezier( 0.0, arr );
            lineTo( v.x, v.y );
            t += step;
            while( t < 1 ){
                v = cubicBezier( t, arr );
                lineTo( v.x, v.y );
                t += step;
            }
            v = cubicBezier( 1.0, arr );
            lineTo( v.x, v.y );
        #elseif (flash || openfl )
            graphics.cubicCurveTo( x1, y1, x2, y2, x3, y3 );
        #elseif luxe
            var p0 = { x: prevX, y: prevY };
            var p1 = { x: x1, y: y1 };
            var p2 = { x: x2, y: y2 };
            var p3 = { x: x3, y: y3 };
            var approxDistance = distance( p0, p1 ) + distance( p1, p2 ) + distance( p2, p3 );
            var v: { x: Float, y: Float };
            if( approxDistance == 0 ) approxDistance = 0.000001;
            var step = Math.min( 1/( approxDistance*0.707 ), cubicStep );
            var arr = [ p0, p1, p2, p3 ];
            var t = 0.0;
            v = cubicBezier( 0.0, arr );
            lineTo( v.x, v.y );
            t += step;
            while( t < 1 ){
                v = cubicBezier( t, arr );
                lineTo( v.x, v.y );
                t += step;
            }
            v = cubicBezier( 1.0, arr );
            lineTo( v.x, v.y );
        #elseif svg
            var quadString = '' + PathCommand.curveTo +x1+','+ y1+' '+x2+','+y2 +' '+x3+','+y3;
            if( inFill ){
                currPathD += quadString;
            } else {
                var svgPath: SVGElement = cast Browser.document.createElementNS( svgNameSpace, 'path' );
                svgPath.setAttribute('d', quadString + PathCommand.endPath );
                svgPath.setAttribute('stroke', getColor( lineColor, lineAlpha ) );
                svgPath.setAttribute('stroke-width', Std.string( thickness ) );
                var node: Node = cast svgPath;
                graphics.appendChild( node );
                svgShapes.push( svgPath );
            }
        #elseif js
            graphics.bezierCurveTo( x1, y1, x2, y2, x3, y3 );
            graphics.stroke();
        #elseif java
            path.curveTo( x1, y1, x2, y2, x3, y3 );
            graphics2D.draw( path );
        #end
    }
    public function quadTo( cx: Float, cy: Float, ax: Float, ay: Float ): Void {
        #if pixel
            // needs research with Quadratic but works.
            var quadratic = new Quadratic( graphics, prevX, prevY, cx, cy, ax, ay, thickness );
            quadratic.plot( lineColor, lineAlpha );
            pixelShapes[ pixelShapes.length ] = EQuadratic( quadratic );
            prevX = ax;
            prevY = ay;
        #elseif flambe
            var p0 = { x: prevX, y: prevY };
            var p1 = { x: cx, y: cy };
            var p2 = { x: ax, y: ay }
            var approxDistance = distance( p0, p1 ) + distance( p1, p2 );
            var factor = 2;
            var v:{x: Float, y:Float };
            if( approxDistance == 0 ) approxDistance = 0.000001;
            var step = Math.min( 1/(approxDistance*0.707), 0.2 );
            var arr = [ p0, p1, p2 ];
            var t = 0.0;
            v = quadraticBezier( 0.0, arr );
            lineTo( v.x, v.y );
            t += step;
            while( t < 1 ){
                v = quadraticBezier( t, arr );
                lineTo( v.x, v.y );
                t+=step;
            }
            v = quadraticBezier( 1.0, arr );
            lineTo( v.x, v.y );
        #elseif (flash || openfl || nme)
            graphics.curveTo(cx, cy, ax, ay);
        #elseif luxe
            var p0 = { x: prevX, y: prevY };
            var p1 = { x: cx, y: cy };
            var p2 = { x: ax, y: ay }
            var approxDistance = distance( p0, p1 ) + distance( p1, p2 );
            var factor = 2;
            var v:{x: Float, y:Float };
            if( approxDistance == 0 ) approxDistance = 0.000001;
            var step = Math.min( 1/(approxDistance*0.707), 0.2 );
            var arr = [ p0, p1, p2 ];
            var t = 0.0;
            v = quadraticBezier( 0.0, arr );
            lineTo( v.x, v.y );
            t += step;
            while( t < 1 ){
                v = quadraticBezier( t, arr );
                lineTo( v.x, v.y );
                t+=step;
            }
            v = quadraticBezier( 1.0, arr );
            lineTo( v.x, v.y );
        #elseif svg
        var quadString = '' + PathCommand.quadTo +cx+','+ cy+' '+ax+','+ay + ' ';
            if( inFill ){
                currPathD += quadString;
            } else {
                var svgPath: SVGElement = cast Browser.document.createElementNS( svgNameSpace, 'path' );
                svgPath.setAttribute('d', quadString + PathCommand.endPath );
                svgPath.setAttribute('stroke', getColor( lineColor, lineAlpha ) );
                svgPath.setAttribute('stroke-width', Std.string( thickness ) );
                var node: Node = cast svgPath;
                graphics.appendChild( node );
                svgShapes.push( svgPath );
            }
        #elseif js
            graphics.quadraticCurveTo( cx, cy, ax, ay );
            graphics.stroke();
        #elseif java
            path.quadTo(cx, cy, ax, ay);
            graphics2D.draw( path );
        #end
    }
    #if flambe
    inline function drawElipseStrip( x: Float,       y: Float
                                        ,   width: Float,   height: Float, ?horizontal: Bool = true ){
        if( !inFill ) return;
        var tot: Int;
        var delta: Float;
        var rx0     = width/2;
        var ry0     = height/2;
        var cx0     = x + rx0;
        var cy0     = y + ry0;
        if( horizontal ) {
            tot = Std.int( Math.floor( height) );
            for( i in 0...tot ){
                delta = Math.pow( Math.pow( rx0, 2 )*( 1 - Math.pow( i - ry0 , 2 )/Math.pow( ry0, 2 ) ), 0.5 );
                drawRectFill( cx0 - delta, y + i, 2*delta, 1 );
            }
        } else {
            tot = Std.int( Math.floor( width ) );
            for( i in 0...tot ){
                delta = Math.pow( Math.pow( ry0, 2 )*( 1 - Math.pow( i - rx0 , 2 )/Math.pow( rx0, 2 ) ), 0.5 );
                drawRectFill( x - i, cy0 - delta, 1, 2*delta );
            }
        }
    }
    inline function drawRectFill( x: Float, y: Float, width: Float, height: Float ){
        var shape = new flambe.display.FillSprite( fillColor, width, height )
                        .setXY( x, y )
                        .setAlpha( fillAlpha );
        shape.pixelSnapping = false;
        graphics.addChild(new flambe.Entity().add(shape));
    }
    #end
    public function drawCircle( cx: Float, cy: Float, radius: Float ): Void {
        #if pixel
            var circle = new Circle( graphics, cx, cy, radius );
            if( inFill ) circle.fill( fillColor, fillAlpha );
            circle.plot( lineColor, lineAlpha, thickness );
            pixelShapes[ pixelShapes.length ] = ECircle( circle );
        #elseif flambe
            drawElipseStrip( cx - radius, cy - radius, radius * 2, radius * 2 );
            var startX:Float = cx;
            var startY:Float = cy;
            for (i in 0 ... totalSegments + 1){
                var ratio = (i / totalSegments);
                var v = ratio * (flambe.math.FMath.PI * 2);
                if (i == 0 ){
                    moveTo( cx + Math.cos(v) * radius, cx + Math.sin(v) * radius );
                } else {
                    lineTo( cy + Math.cos(v) * radius, cy + Math.sin(v) * radius );
                }
            }
        #elseif (flash || openfl || nme)
            graphics.drawCircle(cx, cy, radius);
        #elseif luxe
            if( inFill ){
                var geom = Luxe.draw.circle({ x: cx, y: cy, r: radius,
                                color: getColor( fillColor, fillAlpha )
                            });
                graphics[ graphics.length ] = geom;
            }
            var geom = Luxe.draw.ring({ x: cx, y: cy, r: radius,
                            color: getColor( lineColor, lineAlpha )
                        });
            graphics[ graphics.length ] = geom;
        #elseif svg
            var svgCircle: SVGElement = cast Browser.document.createElementNS( svgNameSpace, 'circle' );
            svgCircle.setAttribute( "cx", Std.string( cx ) );
            svgCircle.setAttribute( "cy", Std.string( cy ) );
            svgCircle.setAttribute( "r", Std.string( radius ) );
            if( inFill ) svgCircle.setAttribute( "fill", getColor( fillColor, fillAlpha ) );
            svgCircle.setAttribute('stroke', getColor( lineColor, lineAlpha ) );
            svgCircle.setAttribute('stroke-width', Std.string( thickness ) );
            var node: Node = cast svgCircle;
            graphics.appendChild( node );
            svgShapes.push( svgCircle );
        #elseif js
            graphics.beginPath();
            graphics.arc( cx, cy, radius, 0, 2*Math.PI, false );
            graphics.stroke();
            graphics.closePath();
        #elseif java
            var r = Std.int( radius * 2 );
            var x = Std.int( cx - radius );
            var y = Std.int( cy - radius );
            graphics2D.setColor( getColor( fillColor, fillAlpha ) );
            graphics2D.fillOval( x, y, r, r );
            graphics2D.setColor( getColor( lineColor, lineAlpha ) );
            graphics2D.drawOval( x, y, r, r );
            moveTo( Std.int(x), Std.int(y) );
        #end
    }
    public function drawRect( x: Float, y: Float, width: Float, height: Float ): Void {
        #if pixel
            var rect = new Rectangle( graphics, x, y, width, height );
            if( inFill ) rect.fill( fillColor, fillAlpha );
            rect.plot( lineColor, lineAlpha, thickness );
            pixelShapes[ pixelShapes.length ] = ERectangle( rect );
        #elseif flambe
            var tempX = prevX;
            var tempY = prevY;
            drawRectFill( x, y, width, height );
            moveTo( x, y );
            lineTo( x + width, y );
            lineTo( x + width, y + width );
            lineTo( x, y + width );
            lineTo( x, y );
            prevX = tempX;
            prevY = tempY;
        #elseif (flash || openfl || nme)
            graphics.drawRect(x, y, width, height);
        #elseif luxe
            if( inFill ){
                var geom;
                if( lineAlpha != 0. ){
                    geom = Luxe.draw.box({ x: x+1., y: y+1., w: width-2., h: height-2.,
                        color: getColor( fillColor, fillAlpha )
                    });
                    geom.depth = -1;
                } else {
                    geom = Luxe.draw.box({ x: x, y: y, w: width, h: height,
                        color: getColor( fillColor, fillAlpha )
                    });
                    geom.depth = -1;
                }
                graphics[ graphics.length ] = geom;
            }
            var geom = Luxe.draw.rectangle({ x: x, y: y, w: width, h: height,
                        color: getColor( lineColor, lineAlpha )
                    });
            graphics[ graphics.length ] = geom;
        #elseif svg
            var svgRect: SVGElement = cast Browser.document.createElementNS( svgNameSpace, 'rect' );
            svgRect.setAttribute( "x", Std.string( x ) );
            svgRect.setAttribute( "y", Std.string( y ) );
            svgRect.setAttribute( "width", Std.string( width ) );
            svgRect.setAttribute( "height", Std.string( height ) );
            if( inFill ) svgRect.setAttribute( "fill", getColor( fillColor, fillAlpha ) );
            svgRect.setAttribute('stroke', getColor( lineColor, lineAlpha ) );
            svgRect.setAttribute('stroke-width', Std.string( thickness ) );
            var node: Node = cast svgRect;
            graphics.appendChild( node );
            svgShapes.push( svgRect );
        #elseif js
            graphics.beginPath();
            graphics.moveTo( x, y );
            graphics.lineTo(x + width, y);
            graphics.lineTo(x + width, y + height);
            graphics.lineTo(x, y + height);
            graphics.stroke();
            graphics.closePath();
        #elseif java
            graphics2D.setColor( getColor( fillColor, fillAlpha ) );
            graphics2D.fillRect( Std.int(x), Std.int(y), Std.int(width), Std.int(height) );
            graphics2D.setColor( getColor( lineColor, lineAlpha ) );
            graphics2D.drawRect( Std.int(x), Std.int(y), Std.int(width), Std.int(height) );
            moveTo( Std.int(x), Std.int(y) );
        #end
    }
    public function drawEquilaterialTri( x: Float, y: Float, radius: Float, direction: Float ): Void{
        var third = (Math.PI * 2) / 3;
        var points = new Array<Float>();
        var x1: Float;
        var y1: Float;
        for( i in 0...3 ){
            x1 = x + radius * Math.cos( direction + i * third );
            y1 = y + radius * Math.sin( direction + i * third );
            points.push( x1 );
            points.push( y1 );
        }
        drawTri( points );
    }
    public function drawTri( points: Array<Float> ): Void {
        #if pixel
            var aTri = new Triangle( graphics, points );
            if( inFill  ) aTri.fill( fillColor, fillAlpha );
            aTri.plot( lineColor, lineAlpha, thickness );
            pixelShapes[ pixelShapes.length ] =  ETriangle( aTri );
        #elseif flambe
            var tri = new TriangleShape(  points[0], points[1]
                                        , points[2], points[3] 
                                        , points[4], points[5] );
            tri.drawStrips( drawRectFill );
            var i = 0;
            while( i < points.length ){
                if( i == 0 ){
                    moveTo( points[ i ], points[ i + 1 ] );
                } else {
                    lineTo( points[ i ], points[ i + 1 ] );
                }
                i+=2;
            }
            lineTo( points[ 0 ], points[ 1 ] );
        #elseif (flash || openfl || nme)
            var i = 0;
            while( i < points.length ){
                if( i == 0 ){
                    graphics.moveTo( points[ i ], points[ i + 1 ] );
                } else {
                    graphics.lineTo( points[ i ], points[ i + 1 ] );
                }
                i += 2;
            }
            graphics.lineTo( points[ 0 ], points[ 1 ] );
        #elseif luxe
            var shape = new Geometry({
                            primitive_type: phoenix.PrimitiveType.triangles,
                            batcher: Luxe.renderer.batcher
                        });
            var i = 0;
            var col = getColor( fillColor, fillAlpha );
            shape.depth = -1;
            while( i < points.length ){
                if( i == 0 ){
                    moveTo( points[ i ], points[ i + 1 ] );
                } else {
                    lineTo( points[ i ], points[ i + 1 ] );
                }
                shape.add( vertexConverter( { x: points[ i ], y: points[ i + 1 ] }, col ) );
                i+=2;
            }
            lineTo( points[ 0 ], points[ 1 ] );
        #elseif svg
            var aTri: SVGElement = cast Browser.document.createElementNS( svgNameSpace, 'polygon');
            var pointsStr = '';
            var x1: Float;
            var y1: Float;
            var i: Int = 0;
            while( i < points.length ){
                pointsStr += Std.string( points[i] ) + ',' + Std.string( points[i+1] ) + ' ';
                i+=2;
            }
            aTri.setAttribute('points', pointsStr );
            if( inFill  ) aTri.setAttribute( "fill", getColor( fillColor, fillAlpha ) );
            aTri.setAttribute('stroke', getColor( lineColor, lineAlpha ) );
            aTri.setAttribute('stroke-width', Std.string( thickness ) );
            var node: Node = cast aTri;
            graphics.appendChild( node );
            svgShapes.push( aTri );
        #elseif js
            graphics.beginPath();
            var i = 0;
            while( i < points.length ){
                if( i == 0 ){
                    graphics.moveTo( points[ i ], points[ i + 1 ] );
                } else {
                    graphics.lineTo( points[ i ], points[ i + 1 ] );
                }
                    i+=2;
                }
            //graphics.lineTo( points[ 0 ], points[ 1 ] );
            graphics.stroke();
            graphics.closePath();
        #elseif java
            var i = 0;
            while( i < points.length ){
                if( i == 0 ){
                    path.moveTo( points[ i ], points[ i + 1 ] );
                } else {
                    path.lineTo( points[ i ], points[ i + 1 ] );
                }
                i+=2;
            }
            path.lineTo( points[ 0 ], points[ 1 ] );
        #end
    }
    public static inline function arcTan( p0: { x: Float, y: Float }
                                        , p1: { x: Float, y: Float }
                                        ): Float {
        return Math.atan2( p1.y - p0.y, p1.x - p0.x );
    }
    public static inline function distance(     p0: { x: Float, y: Float }
                                            ,   p1: { x: Float, y: Float }
                                            ): Float {
        var x = p0.x-p1.x;
        var y = p0.y-p1.y;
        return Math.sqrt(x*x + y*y);
    }
    public inline static function quadraticBezier(  t: Float
                                                ,   arr: Array<{ x: Float, y: Float }>
                                                ): { x: Float,y: Float } {
                                                    return {  x: _quadraticBezier( t, arr[0].x, arr[1].x, arr[2].x )
                                                            , y: _quadraticBezier( t, arr[0].y, arr[1].y, arr[2].y ) };
    }
    private inline static function _quadraticBezier ( t: Float
                                                    , startPoint: Float
                                                    , controlPoint: Float
                                                    , endPoint: Float
                                                    ): Float {
        var u = 1 - t;
        return Math.pow( u, 2) * startPoint + 2 * u * t * controlPoint + Math.pow( t, 2 ) * endPoint;
    }
    public inline static function cubicBezier(   t: Float
                                        ,   arr: Array<{ x: Float, y: Float }>
                                        ): { x: Float,y: Float } {
                                            return {  x: _cubicBezier( t, arr[ 0 ].x, arr[ 1 ].x, arr[ 2 ].x, arr[ 3 ].x )
                                                    , y: _cubicBezier( t, arr[ 0 ].y, arr[ 1 ].y, arr[ 2 ].y, arr[ 3 ].y ) };
    }
    private inline static function _cubicBezier(  t:                Float
                                                , startPoint:       Float
                                                , controlPoint1:    Float
                                                , controlPoint2:    Float
                                                , endPoint:         Float 
                                                ): Float {
                    var u = 1 - t;
                    return  Math.pow( u, 3 ) * startPoint + 3 * Math.pow( u, 2 ) * t * controlPoint1 +
                    3* u * Math.pow( t, 2 ) * controlPoint2 + Math.pow( t, 3 ) * endPoint;
    }
}
