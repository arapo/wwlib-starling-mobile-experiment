package 
{
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.system.Capabilities;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import org.wwlib.starling.WwSprite;
	import org.wwlib.util.WwDebug;
	import org.wwlib.util.WwDeviceInfo;
    
    import starling.core.Starling;
    
    [SWF(width="1024", height="768", frameRate="60", backgroundColor="#000000")]
    public class Startup extends Sprite
    {
        private var mStarling:Starling;
		
		private var __debug:WwDebug;
		private var __deviceInfo:WwDeviceInfo;

        
        public function Startup()
        {
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
            WwDebug.init(stage);
			__debug = WwDebug.instance;
			__deviceInfo = WwDeviceInfo.init();
			__debug.msg("os: " + __deviceInfo.os);
			__debug.msg("devStr: " + __deviceInfo.devString);
			__debug.msg("device: " + __deviceInfo.device);
			__debug.msg("width: " + __deviceInfo.width);
			__debug.msg("height: " + __deviceInfo.height);
			__debug.msg("x: " + __deviceInfo.centerX);
			__debug.msg("y: " + __deviceInfo.centerY);
			__debug.msg("scale: " + __deviceInfo.scale);
			__debug.msg("isDebugger: " + __deviceInfo.isDebugger);
			__debug.msg("resolutionX: " + __deviceInfo.resolutionX);
			__debug.msg("resolutionY: " + __deviceInfo.resolutionY);
			
			WwSprite.__baseScaleFactor = __deviceInfo.assetScaleFactor;
			
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