package 
{
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.system.Capabilities;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
    
    import starling.core.Starling;
    
    [SWF(width="320", height="480", frameRate="60", backgroundColor="#228888")]
    public class Startup extends Sprite
    {
        private var mStarling:Starling;
		
		private var _SHOW_DEBUG_MESSAGES:Boolean = false;
		private var debugText:TextField = new TextField();
        
        public function Startup()
        {
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
            
			// Setup Debug UI
            debugText.background = true;
            debugText.backgroundColor = 0xffffffff;
            debugText.autoSize = TextFieldAutoSize.LEFT;
            addChild(debugText);
			debugMsg("debugText");
			
            Starling.multitouchEnabled = true; // useful on mobile devices
            Starling.handleLostContext = true; // deactivate on mobile devices (to save memory)
            
			debugMsg("new Starling(Game, stage)");
            mStarling = new Starling(Game, stage);
            mStarling.simulateMultitouch = true;
            mStarling.enableErrorChecking = Capabilities.isDebugger;
			debugMsg("mStarling.start()");
            mStarling.start();
            
            // this event is dispatched when stage3D is set up
            mStarling.stage3D.addEventListener(Event.CONTEXT3D_CREATE, onContextCreated);
			debugMsg("Startup: complete");
        }
        
        private function onContextCreated(event:Event):void
        {
            // set framerate to 30 in software mode
            
			debugMsg("onContextCreated");
			debugMsg(Starling.context.driverInfo.toLowerCase());
			
            if (Starling.context.driverInfo.toLowerCase().indexOf("software") != -1)
                Starling.current.nativeStage.frameRate = 30;
        }
		
		public function debugMsg(msg:String):void
		{
			if (_SHOW_DEBUG_MESSAGES)
			{
				debugText.appendText(msg + "\n");
			}
		}
    }
}