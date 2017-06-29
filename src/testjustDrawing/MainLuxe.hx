package testjustDrawing;
import luxe.Game;
import luxe.Input.Key;
import luxe.Input.KeyEvent;
import justDrawing.Surface;
    using testjustDrawing.Draw;
class MainLuxe extends Game {
    override function ready() {
        var surface = new Surface( new Array<phoenix.geometry.Geometry>() );
        surface.testing();
    }
    override function onkeyup( e: KeyEvent ) {
        if (e.keycode == Key.escape) {
            Luxe.shutdown();
        }
    }
    override function update( delta: Float ) {
        
    }
    override function config( config: luxe.GameConfig ) {
        config.render.antialiasing = 4;
        return config;
    }
}