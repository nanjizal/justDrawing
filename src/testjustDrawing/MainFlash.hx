package testjustDrawing;
import flash.Lib;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import justDrawing.Surface;
    using testjustDrawing.Draw;
class MainFlash extends Sprite{
    public static function main(): Void {
        Lib.current.addChild( new MainFlash() );
    }
    public function new(){
        super();
        var viewSprite = new Sprite();
        var surface = new Surface( viewSprite.graphics );
        addChild( viewSprite );
        surface.testing();
        Lib.current.stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
    }
    function onKeyDown( event: KeyboardEvent ): Void {
        if (event.keyCode == 27) { // ESC
            #if flash
                flash.system.System.exit(1);
            #elseif sys
                Sys.exit(1);
            #end
        }
    }
}