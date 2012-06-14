package scenes
{
	import flash.display.LoaderInfo;
    import flash.geom.Point;
    import flash.utils.Dictionary;
	import org.wwlib.starling.menu.WwMenuManager;
	import org.wwlib.util.WwDebug;
    
    import starling.display.BlendMode;
    import starling.display.Button;
    import starling.display.Image;
    import starling.events.Event;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
    import starling.text.TextField;
    import starling.textures.RenderTexture;
	import starling.animation.Transitions;
    import starling.animation.Tween;
	import starling.core.Starling;

    public class RenderTextureScene extends Scene
    {
        private var mRenderTexture:RenderTexture;
        private var mCanvas:Image;
		private var mCanvasFG:Image;
        private var mBrush:Image;
        private var mButton:Button;
        private var mColors:Dictionary;
		
		private var __MENU_START_Y:int = -283;
		private var __menuColor:Image;
		private var __menuBrush:Image;
		private var __menuScene:Image;
		private var __menuShare:Image;
		
		private var __transitions:Array;
		private var __menuManager:WwMenuManager;
		private var __debug:WwDebug;
		private var __activeColor:uint;
		private var __rotateBrush:Boolean = true;
        
        public function RenderTextureScene()
        {
			__debug = WwDebug.instance;
			
            mColors = new Dictionary();
            mRenderTexture = new RenderTexture(480, 320);
            
            mCanvas = new Image(mRenderTexture);
            addChild(mCanvas);
			
            mCanvasFG = new Image(Assets.getTexture("Foreground"));
			mCanvasFG.addEventListener(TouchEvent.TOUCH, onTouch);
            addChild(mCanvasFG);
            
            mBrush = new Image(Assets.getTexture("Brush"));
            mBrush.pivotX = mBrush.width / 2;
            mBrush.pivotY = mBrush.height / 2;
            mBrush.blendMode = BlendMode.NORMAL;
            
            mButton = new Button(Assets.getTexture("ButtonNormal"), "Mode: Draw");
            mButton.x = 690 / 2;  //TODO: fix scale for iphone.
            mButton.y = 570 / 2;
            mButton.addEventListener(Event.TRIGGERED, onButtonTriggered);
            addChild(mButton);
			
			__transitions = [Transitions.LINEAR, Transitions.EASE_OUT, Transitions.EASE_IN_OUT,
                            Transitions.EASE_OUT_BACK, Transitions.EASE_OUT_BOUNCE,
                            Transitions.EASE_OUT_ELASTIC];
							
			__menuManager = WwMenuManager.init(this);
			__menuManager.loadXML();
        }
        
        private function onTouch(event:TouchEvent):void
        {
            // touching the canvas will draw a brush texture. The 'drawBundled' method is not
            // strictly necessary, but it's faster when you are drawing with several fingers
            // simultaneously.
			
			
            
            mRenderTexture.drawBundled(function():void
            {
                var touches:Vector.<Touch> = event.getTouches(mCanvasFG);
            
                for each (var touch:Touch in touches)
                {
                    if (touch.phase == TouchPhase.BEGAN)
                        mColors[touch.id] = Math.random() * uint.MAX_VALUE;
						
                    if (touch.phase == TouchPhase.HOVER || touch.phase == TouchPhase.ENDED)
                        continue;
                    
                    var location:Point = touch.getLocation(mCanvasFG);
                    mBrush.x = location.x;
                    mBrush.y = location.y;
                    //mBrush.color = mColors[touch.id];
                    //mBrush.color = 000000;
					if (__rotateBrush)
					{
						mBrush.rotation = Math.random() * Math.PI * 2.0;
					}
                    
                    mRenderTexture.draw(mBrush);
                }
            });
        }     
        
        private function onButtonTriggered(event:Event):void
        {
            if (mBrush.blendMode == BlendMode.NORMAL)
            {
                mBrush.blendMode = BlendMode.ERASE;
                mButton.text = "Mode: Erase";
            }
            else
            {
                mBrush.blendMode = BlendMode.NORMAL;
                mButton.text = "Mode: Draw";
            }
        }
		
		public function set brushColorFromString(hex_color:String):void
		{
			__activeColor =  uint(hex_color);
			mBrush.color = __activeColor;
			__debug.msg("brushColorFromString: " + hex_color + ", " + mBrush.color);
		}
		
		public function set brush(img:Image):void
		{
			__debug.msg("set: brush: " + img);
			mBrush = img;
			mBrush.color = __activeColor;
		}
		
		public function set roatateBrush(f:Boolean):void
		{
			__rotateBrush = f;
		}
        
        public override function dispose():void
        {
            mRenderTexture.dispose();
            super.dispose();
        }
    }
}