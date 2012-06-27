package 
{
    import flash.ui.Keyboard;
    import flash.utils.getDefinitionByName;
    import flash.utils.getQualifiedClassName;
	import org.wwlib.starling.WwSceneManager;
	import org.wwlib.starling.WwSprite;
	import org.wwlib.util.WwDeviceInfo;
    
    import scenes.AnimationScene;
    import scenes.BenchmarkScene;
    import scenes.CustomHitTestScene;
    import scenes.MovieScene;
    import scenes.RenderTextureScene;
    import scenes.Scene;
    import scenes.TextScene;
    import scenes.TextureScene;
    import scenes.TouchScene;
    
    import starling.core.Starling;
    import starling.display.BlendMode;
    import starling.display.Button;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.events.KeyboardEvent;
    import starling.text.TextField;
    import starling.textures.Texture;
    import starling.utils.VAlign;

    public class Game extends Sprite
    {

        
		private var __bg:WwSprite;
		private var __sceneManager:WwSceneManager;
		
        public function Game()
        {
            // The following settings are for mobile development (iOS, Android):
            //
            // You develop your game in a *fixed* coordinate system of 320x480; the game might 
            // then run on a device with a different resolution, and the assets class will
            // provide textures in the most suitable format.
            
            Starling.current.stage.stageWidth  = WwDeviceInfo.instance.width;
            Starling.current.stage.stageHeight =  WwDeviceInfo.instance.height;
            Assets.contentScaleFactor = Starling.current.contentScaleFactor;
            
            // load general assets
            
            Assets.prepareSounds();
            Assets.loadBitmapFonts();
            
            // create and show menu screen
			
			__bg = new WwSprite();
			__bg.loadImage("assets/coloring_pages/background_960.png");
			addChild(__bg);
			
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
            
			__sceneManager = WwSceneManager.init(this);
			addChild(__sceneManager);
			__sceneManager.loadXML();
        }
        
        private function onAddedToStage(event:Event):void
        {
            stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey);
        }
        
        private function onRemovedFromStage(event:Event):void
        {
            stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKey);
        }
        
        private function onKey(event:KeyboardEvent):void
        {
            if (event.keyCode == Keyboard.SPACE)
                Starling.current.showStats = !Starling.current.showStats;
            else if (event.keyCode == Keyboard.X)
                Starling.context.dispose();
        }
    }
}