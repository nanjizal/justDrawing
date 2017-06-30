package testjustDrawing;
import java.lang.System;
import java.javax.swing.JPanel;
import java.javax.swing.JFrame;
import java.awt.Color;
import justDrawing.SurfaceJPanel;
import java.awt.Dimension;
import java.awt.Graphics2D;
import justDrawing.Surface;
import haxe.Timer;
    using testjustDrawing.Draw;
class MainSwing extends JFrame{
    var surface: Surface;
    public static function main() { new MainSwing(); } public function new(){
        super();
        setTitle('justDrawing swing example');
        System.setProperty("sun.java2d.opengl","True");
        var width = 1024;
        var height = 768;
        setSize( width, height );
        setDefaultCloseOperation( JFrame.EXIT_ON_CLOSE );
        setBackground( Color.white );
        var jpanel = new SurfaceJPanel();
        surface = new Surface( jpanel );
        jpanel.paintFunction = paintFunction;
        getContentPane().setPreferredSize( new Dimension( width, height ) );
        getContentPane().add( jpanel );
        setLocationRelativeTo(null);
        pack();
        setVisible( true );
        // for repeated redraw, not needed.
        //var timer = new Timer( Math.floor( 1000/60 ) );
        //timer.run = renderTimer;
    }
    function paintFunction( g: Graphics2D ):Void {
        surface.graphics2D = g;
        surface.testing();
    }
    function renderTimer():Void {
        repaint();
    }
}