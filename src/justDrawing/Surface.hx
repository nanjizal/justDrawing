package justDrawing;

#if format

#elseif flambe

#elseif (flash || openfl || nme)

#elseif luxe
import luxe.*;
import phoenix.*;
import phoenix.geometry.*;
import phoenix.Batcher;
#elseif svg

#elseif js

#elseif java

#end


#if format
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
    public inline static function getColor( col: Int, ?alpha: Float ): new java.awt.Color {
        var a:Int = Std.int( alpha * 255 );
        return new java.awt.Color( color | (a << 24), true);
    }
    #end
    
    #if svg
    public function repaint(){
        for( all in svgShapes ) {
            var node: Node = cast all;
            svgElement.appendChild( node );
        }
    }
    public function remove( element: SVGElement ): Void {
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
    
    #if format
    var pixelShapes: Array<PixelShapeEnum>();
    #elseif flambe
        //
    #elseif (flash || openfl || nme)
        //
    #elseif luxe
        //
    #elseif svg
    var svgShapes: new Array<SVGElement>();
    #elseif js
        //
    #elseif java
    var path: GeneralPath();
    #end
    
    
    
    public function new( graphics_: TargetCanvas ){
        graphics = graphics_;
        inFill   = false;
        
        #if format
            pixelShapes = new Array<PixelShapeEnum>();
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
        #if format
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
            while( svgShapes.length != 0 ) remove( svgShapes.pop() );
        #elseif js
            graphics.clearRect( 0, 0, width, height );
        #elseif java
            graphics.clearRect(     graphics.bounds.x, graphics.bounds.y
                                ,   graphics.bounds.width, graphics.bounds.height );
        #end
    }
    public function lineStyle(  thick: Float, color: Int, ?alpha: Float = 1. ): Void {
        thickness = thick;
        lineColor = color;
        lineAlpha = alpha;
        
        #if format
            //
        #elseif flambe
            //
        #elseif (flash || openfl || nme)
            graphics.lineStyle( thickness, color, alpha );
        #elseif luxe
            //
        #elseif svg
            //
        #elseif js
            surface.lineWidth = thick;
            surface.strokeStyle = getColor( lineColor, lineAlpha );
        #elseif java
        	graphics.setColor( getColor( lineColor, lineAlpha ) );
            graphics.setStroke( new java.awt.BasicStroke( thickness ) );
        #end
    }
    public function beginFill( color: Int, ?alpha: Float ): Void {
        fillColor = color;
        fillAlpha = alpha;
        inFill = true;
        
        #if format
            //
        #elseif flambe
            //
        #elseif (flash || openfl || nme)
            graphics.beginFill(color, alpha);
        #elseif luxe
            //
        #elseif svg
            // 
        #elseif js
            graphics.fillStyle = getColor( fillColor, fillAlpha );
            graphics.beiginPath();
        #elseif java
            graphics.setPaint( getColor( fillColor, fillAlpha ) );
        #end
    }
    public function endFill(): Void {
        inFill = false;
        
        #if format
            //
        #elseif flambe
            //
        #elseif (flash || openfl || nme)
            graphics.endFill();
        #elseif luxe
            //
        #elseif svg
            //
        #elseif js
            graphics.stroke();
            graphics.closePath();
            graphics.fill();
        #elseif java
            //
        #end
    }
    public function moveTo( x: Float, y: Float ): Void {
        prevX = x;
        prevY = y;
        
        #if format
            //
        #elseif flambe
            //
        #elseif (flash || openfl || nme)
            graphics.moveTo( x, y );
        #elseif luxe
            //
        #elseif svg
            //
        #elseif js
            graphics.beginPath();
            graphics.moveTo( x, y );
        #elseif java
            path.reset();
            path.moveTo(x, y);
        #end
    }
    public function lineTo( x: Float, y: Float ): Void {
        #if format
            var aLine = new PixelLine( graphics, prevX, prevY, x, y, w );
        	aLine.plot( lineColor, lineAlpha );
            pixelShapes[ pixelShapes.length ] = ELine( aLine );
        #elseif flambe
            var dx = prevX - x;
            var dy = prevY - y;
            var distance = Math.sqrt( dx * dx + dy * dy );
            var angle = Math.atan2( dy, dx );
            var shape: Sprite = new FillSprite( lineColor, distance, thickness)
                                .setRotation(FMath.toDegrees( angl e))
                                .setXY( x, y )
                                .setAnchor( 0, thickness / 2 )
                                .setAlpha( lineAlpha );
            shape.pixelSnapping = false;
            graphics.addChild( new Entity().add( shape ) );
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
            var aLine: SVGElement = cast Browser.document.createElementNS( svgNameSpace, 'line');
            aLine.setAttribute('x1', Std.string( prevX ) );
            aLine.setAttribute('y1', Std.string( prevY ) );
            aLine.setAttribute('x2', Std.string( x ) );
            aLine.setAttribute('y2', Std.string( y ) );
            aLine.setAttribute('stroke', getColor( lineColor, lineAlpha ) );
            aLine.setAttribute('stroke-width', Std.string( thickness ) );
            var node: Node = cast element;
            svgElement.appendChild( node );
            svgShapes.push( element );
        #elseif js
            graphics.lineTo( x, y );
            graphics.closePath();
            graphics.stroke();
        #elseif java
            path.lineTo( x, y );
            graphics.draw( path );
        #end
        
        prevX = x;
        prevY = y;
    }
    public function quadTo( cx: Float, cy: Float, ax: Float, ay: Float ): Void {
        #if format
            var quadratic = new PixelQuadratic( graphics, prevX, prevY, ax, ay, ex, ey, thickness );
            quadratic.plot( lineColor, lineAlpha );
            pixelShapes[ pixelShapes.length ] = EQuadratic( quadratic );
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
        #elseif js
            graphics.quadraticCurveTo( cx, cy, ax, ay );
            graphics.stroke();
        #elseif java
            path.quadTo(cx, cy, ax, ay);
            graphics.draw( path );
        #end
    }
    public function drawCircle( cx: Float, cy: Float, radius: Float ): Void {
        #if format
            var circle = new PixelCircle( graphics, cx, cy, r );
            if( inFill ) circle.fill( fillColor, fillAlpha );
            circle.plot( lineColor, lineAlpha, thickness );
            pixelShapes[ pixelShapes.length ] = ECircle( circle );
        #elseif flambe
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
            svgCircle.setAttribute('stroke', getColor( lineFill, lineAlpha ) );
            svgCircle.setAttribute('stroke-width', Std.string( thickness ) );
            var node: Node = cast element;
            svgElement.appendChild( node );
            svgShapes.push( element );
        #elseif js
            surface.beginPath();
            surface.arc( cx, cy, radius, 0, 2*Math.PI, false );
            surface.stroke();
            surface.closePath();
        #elseif java
            var r = Std.int( radius * 2 );
            var x = Std.int( cx - radius );
            var y = Std.int( cy - radius );
            graphics.fillOval( x, y, r, r );
            graphics.drawOval( x, y, r, r );
        #end
    }
    public function drawRect( x: Float, y: Float, width: Float, height: Float ): Void {
        #if format
            var rect = new PixelRectangle( graphics, x, y, width, height );
            if( inFill ) rect.fill( fillColor, fillAlpha );
            rect.plot( lineColor, lineAlpha, thickness );
            pixelShapes[ pixelShapes.length ] = ERectangle( rect );
        #elseif flambe
            var shape = new FillSprite(_color, width, height)
                            .setXY(x, y)
                            .setAlpha(_alpha);
            shape.pixelSnapping = false;
            graphics.addChild(new Entity().add(shape));
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
            graphics.fillRect( Std.int(x), Std.int(y), Std.int(width), Std.int(height) );
            graphics.drawRect( Std.int(x), Std.int(y), Std.int(width), Std.int(height) );
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
        #if format
            var aTri = new PixelTriangle( graphics, pointsArr );
            if( inFill  ) aTri.fill( fillColor, fillAlpha );
            aTri.plot( lineColor, lineAlpha, thickness );
            pixelShapes[ pixelShapes.length ] =  ETriangle( aTri );
        #elseif flambe
            var i = 0;
            while( i < points.length ){
                if( i == 0 ){
                    moveTo( points[ i ], points[ i + 1 ] );
                } else {
                    lineTo( points[ i ], points[ i + 1 ] );
                }
                i+=2;
            }
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
            var points = '';
            var x1: Float;
            var y1: Float;
            var i: Int = 0;
            while( i < pointsArr.length ){
                points += Std.string( pointsArr[i] ) + ',' + Std.string( pointsArr[i+1] ) + ' ';
                i+=2;
            }
            aTri.setAttribute('points', points );
            if( inFill  ) aTri.setAttribute( "fill", getColor( fill, fillAlpha ) );
            aTri.setAttribute('stroke', getColor( line, lineAlpha ) );
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
            graphics.draw( path );
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
}
