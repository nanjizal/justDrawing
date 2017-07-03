package justDrawing.justPath;
import justDrawing.Surface;
import justDrawing.justPath.IPathContext;
class SurfaceContext implements IPathContext {
    var surface: Surface;
    public function new( surface_: Surface ){
        surface = surface_;
    }
    public function moveTo( x: Float, y: Float ): Void{
        surface.moveTo( x, y );
    }
    public function lineTo( x: Float, y: Float ): Void{
        surface.lineTo( x, y );
    }
    public function quadTo( x1: Float, y1: Float, x2: Float, y2: Float ): Void{
        surface.quadTo( x1, y1, x2, y2 );
    }
    public function curveTo( x1: Float, y1: Float, x2: Float, y2: Float, x3: Float, y3: Float ): Void{
        surface.curveTo( x1, y1, x2, y2, x3, y3 );
    }
}