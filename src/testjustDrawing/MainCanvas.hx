package testjustDrawing;
import js.Browser;
import htmlHelper.canvas.CanvasWrapper;
import js.html.CanvasRenderingContext2D;
import justDrawing.Surface;
    using testjustDrawing.Draw;
class MainCanvas{
    public static function main(){ new MainCanvas(); } public function new(){
        var canvas = new CanvasWrapper();
        canvas.width = 1024;
        canvas.height = 768;
        Browser.document.body.appendChild( cast canvas );
        var surface = new Surface( canvas.getContext2d() );
        surface.testing();
    }
}