package testjustDrawing;
import hxPixels.Pixels;
import justDrawing.Surface;
    using testjustDrawing.Draw;
class MainPixels {
    public static function main(): Void { new MainPixels(); } public function new(){
        var pixels = new Pixels( 1024, 768 );
        var surface = new Surface( pixels );
        surface.testing();
        writeModifiedPNG( pixels, 'shapes' );
    }
    public function writeModifiedPNG( pixels:Pixels, fileName:String) {
        #if neko
        var dir = haxe.io.Path.directory(neko.vm.Module.local().name);
        #else
        var dir = haxe.io.Path.directory(Sys.executablePath());
        #end
        var outputFileName = "out_" + fileName + ".png";
        var file = sys.io.File.write(haxe.io.Path.join([dir, outputFileName]), true);
        var pngWriter = new format.png.Writer(file);
        var startTime = haxe.Timer.stamp();
        pixels.convertTo(PixelFormat.ARGB);
        trace('convert ${haxe.Timer.stamp() - startTime}');
        var pngData = format.png.Tools.build32ARGB(pixels.width, pixels.height, pixels.bytes);
        pngWriter.write(pngData);
        trace("written to '" + outputFileName + "'\n");
    }
}