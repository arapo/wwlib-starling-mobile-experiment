package 
{
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.system.Capabilities;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import org.wwlib.util.WwDebug;
    
    import starling.core.Starling;
    
    [SWF(width="480", height="320", frameRate="60", backgroundColor="#000000")]
    public class Startup extends Sprite
    {
        private var mStarling:Starling;
		
		private var __debug:WwDebug;

        
        public function Startup()
        {
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
            WwDebug.init(stage);
			__debug = WwDebug.instance;
			
			
            Starling.multitouchEnabled = true; // useful on mobile devices
            Starling.handleLostContext = true; // deactivate on mobile devices (to save memory)
            
            mStarling = new Starling(Game, stage);
            mStarling.simulateMultitouch = true;
            mStarling.enableErrorChecking = Capabilities.isDebugger;
            mStarling.start();
            
            // this event is dispatched when stage3D is set up
            mStarling.stage3D.addEventListener(Event.CONTEXT3D_CREATE, onContextCreated);
			
        }
        
        private function onContextCreated(event:Event):void
        {
            // set framerate to 30 in software mode
			
            if (Starling.context.driverInfo.toLowerCase().indexOf("software") != -1)
                Starling.current.nativeStage.frameRate = 30;
        }
    }
}