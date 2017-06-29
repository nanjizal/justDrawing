package testjustDrawing;
import flambe.Entity;
import flambe.System;
import flambe.asset.AssetPack;
import flambe.asset.Manifest;
import flambe.display.FillSprite;
import flambe.display.ImageSprite;
import justDrawing.Surface;
    using testjustDrawing.Draw;
class MainFlambe {
    public static function main(): Void {
        System.init();
        // Load up the compiled pack in the assets directory named "bootstrap"
        var manifest = Manifest.fromAssets("bootstrap");
        var loader = System.loadAssetPack(manifest);
        loader.get(onSuccess);
    }
    private static function onSuccess ( pack :AssetPack ){
        // Add a solid color background
        var background = new FillSprite(0x202020, System.stage.width, System.stage.height);
        System.root.addChild(new Entity().add(background));
        
        var graphics = new Entity();
        System.root.addChild(graphics);
        var surface = new Surface( graphics );
        surface.testing();
    }
}