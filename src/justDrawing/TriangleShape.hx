package justDrawing;
import justDrawing.RectangleShape;
class TriangleShape {
    public var ax: Float;
    public var bx: Float;
    public var cx: Float;
    public var ay: Float;
    public var by: Float;
    public var cy: Float;
    public var x( get, set ): Float;
    function get_x() {
        return Math.min( Math.min( ax, bx ), cx );
    }
    function set_x( x: Float ): Float {
        var dx = x - get_x();
        ax = ax + dx;
        bx = bx + dx;
        cx = cx + dx;
        return x;
    }
    public var y( get, set ): Float;   
    function get_y(): Float {
        return Math.min( Math.min( ay, by ), cy );
    }
    function set_y( y: Float ): Float {
        var dy = y - get_y();
        ay = ay + dy;
        by = by + dy;
        cy = cy + dy;
        return y;
    }
    public var right( get, never ): Float;
    public function get_right(): Float {
        return Math.max( Math.max( ax, bx ), cx );
    }
    public var bottom( get, never ): Float;
    public function get_bottom(): Float {
        return Math.max( Math.max( ay, by ), cy );
    }
    function moveDelta( dx: Float, dy: Float ){
        ax += dx;
        ay += dy;
        bx += dx;
        by += dy;
        cx += dx;
        cy += dy;
    }   
    public function new(   ax_: Float, ay_: Float
                         , bx_: Float, by_: Float 
                         , cx_: Float, cy_: Float
                        ){
        if( windingGood( ax_, ay_, bx_, by_, cx_, cy_ ) ){
                    ax = ax_;
                    ay = ay_;
                    bx = bx_;
                    by = by_;
                    cx = cx_;
                    cy = cy_;
                } else {    
                    ax = ax_;
                    ay = ay_;
                    bx = cx_;
                    by = cy_;
                    cx = bx_;
                    cy = by_;
                }
    }
    // A B C, you can find the winding by computing the cross product (B - A) x (C - A)
    inline static function windingGood( ax: Float, ay: Float, bx: Float, by: Float, cx: Float, cy: Float ): Bool{
        return ( ((bx - ax)*(cx - ax) - (by - by)*(cx - ax) ) < 0 );
    }
         //http://www.emanueleferonato.com/2012/06/18/algorithm-to-determine-if-a-point-is-inside-a-triangle-with-mathematics-no-hit-test-involved/
    public inline function hitTest( px: Float, py: Float ): Bool {
        if( px > x && px < right && py > y && py < bottom ) return true;
        var planeAB = ( ax - px )*( by - py ) - ( bx - px )*( ay - py );
        var planeBC = ( bx - px )*( cy - py ) - ( cx - px )*( by - py );
        var planeCA = ( cx - px )*( ay - py ) - ( ax - px )*( cy - py );
        return sign( planeAB ) == sign( planeBC ) && sign( planeBC ) == sign( planeCA );
    }
    inline function sign( n: Float ): Int {
        return Std.int( Math.abs( n )/n );
    }
    // create 1 px high horizontal strips.
    public function asStrips(): Array<RectangleShape>{
        var xi: Int         = Math.floor( x );
        var yi: Int         = Math.floor( y );
        var righti: Int     = Math.ceil( right );
        var bottomi: Int    = Math.ceil( bottom );
        var sx: Int = 0;
        var ex: Int = 0;
        var sFound: Bool;
        var eFound: Bool;
        var rect = new Array<RectangleShape>();
        // need to adjust for negative values thought required.
        for( y0 in yi...bottomi ){ // loop vertically
            sFound = false; // could remove if swapped floor and ceil on boundaries?
            eFound = false; // not needed perhaps just for safety at mo.
            for( x0 in xi...righti ){
                if( liteHit( x0, y0 ) ) { // start strip
                    sx = x0;
                    sFound = true;
                    break;
                }
            }
            if( sFound ){
                for( x0 in sx...righti ){ // end strip
                    if( !liteHit( x0, y0 ) ){
                        ex = x0;
                        eFound = true;
                        break;
                    }
                }
                if( eFound ) rect[ rect.length ] = new RectangleShape( sx, y0, ex - sx, 1 );
            }
        }
        return rect;
    }
    // no bounds checking
    public inline function liteHit( px: Float, py: Float ): Bool {
        var planeAB = ( ax - px )*( by - py ) - ( bx - px )*( ay - py );
        var planeBC = ( bx - px )*( cy - py ) - ( cx - px )*( by - py );
        var planeCA = ( cx - px )*( ay - py ) - ( ax - px )*( cy - py );
        return sign( planeAB ) == sign( planeBC ) && sign( planeBC ) == sign( planeCA );
    }
    // draws Triangle with horizontal strips 1px high.
    public function drawStrips( drawRect: Float->Float->Float->Float->Void ){
        var xi: Int         = Math.floor( x );
        var yi: Int         = Math.floor( y );
        var righti: Int     = Math.ceil( right );
        var bottomi: Int    = Math.ceil( bottom );
        var sx: Int = 0;
        var ex: Int = 0;
        var sFound: Bool;
        var eFound: Bool;
        // need to adjust for negative values thought required.
        for( y0 in yi...bottomi ){ // loop vertically
            sFound = false; // could remove if swapped floor and ceil on boundaries?
            eFound = false; // not needed perhaps just for safety at mo.
            for( x0 in xi...righti ){
                if( liteHit( x0, y0 ) ) { // start strip
                    sx = x0;
                    sFound = true;
                    break;
                }
            }
            if( sFound ){
                for( x0 in sx...righti ){ // end strip
                    if( !liteHit( x0, y0 ) ){
                        ex = x0;
                        eFound = true;
                        break;
                    }
                }
                if( eFound ) drawRect( sx, y0, ex - sx, 1 );
            }
        }
    }
}