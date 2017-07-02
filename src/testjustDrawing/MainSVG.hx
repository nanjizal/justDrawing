package testjustDrawing;
import js.Browser;
import js.html.svg.SVGElement;
import htmlHelper.svg.SvgRoot;
import js.html.CanvasRenderingContext2D;
import justDrawing.Surface;
    using testjustDrawing.Draw;
class MainSVG{
    public static function main(){ new MainSVG(); } public function new(){
        var svgRoot = new SvgRoot();
        svgRoot.width = 1024;
        svgRoot.height = 768;
        var svg: SVGElement = svgRoot;
        var surface = new Surface( svg );
        surface.testing();
    }
}