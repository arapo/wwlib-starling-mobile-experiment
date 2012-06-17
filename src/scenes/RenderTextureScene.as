package scenes
{
	import flash.display.LoaderInfo;
    import flash.geom.Point;
    import flash.utils.Dictionary;
	import org.wwlib.starling.menu.WwMenuManager;
	import org.wwlib.starling.WwSprite;
	import org.wwlib.util.WwDebug;
	import org.wwlib.util.WwDeviceInfo;
    
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
        private var mBrush:Image;
        private var mButton:Button;
        private var mColors:Dictionary;
		
		private var __coloringPage:WwSprite;
		
		private var __transitions:Array;
		private var __menuManager:WwMenuManager;
		private var __debug:WwDebug;
		private var __activeColor:uint;
		private var __rotateBrush:Boolean = true;
        
        public function RenderTextureScene()
        {
			__debug = WwDebug.instance;
			__debug.msg("Starling.current.stage.stageWidth: " + Starling.current.stage.stageWidth);
			__debug.msg("Starling.current.stage.stageWidth: " + Starling.current.stage.stageHeight);
			__debug.msg("Starling.current.contentScaleFactor: " + Starling.current.contentScaleFactor);
			
            mColors = new Dictionary();
            mRenderTexture = new RenderTexture(WwDeviceInfo.instance.canvasWidth, WwDeviceInfo.instance.canvasHeight);
            
            mCanvas = new Image(mRenderTexture);
            addChild(mCanvas);
			
			__coloringPage = new WwSprite();
			__coloringPage.addEventListener(TouchEvent.TOUCH, onTouch);
			__coloringPage.loadImage("assets/coloring_pages/sullivan_snail_960.png");
			addChild(__coloringPage);
            
            //mBrush = new Image(Assets.getTexture("Brush"));
            //mBrush.pivotX = mBrush.width / 2;
            //mBrush.pivotY = mBrush.height / 2;
            //mBrush.blendMode = BlendMode.NORMAL;
            
            mButton = new Button(Assets.getTexture("ButtonNormal"), "Draw");
            mButton.x = 14 / WwDeviceInfo.instance.scale;  //TODO: fix scale for iphone.
            mButton.y = 580 / WwDeviceInfo.instance.scale;
            mButton.addEventListener(Event.TRIGGERED, onButtonTriggered);
			mButton.width = 75;
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
                var touches:Vector.<Touch> = event.getTouches(__coloringPage);
            
                for each (var touch:Touch in touches)
                {
                    if (touch.phase == TouchPhase.BEGAN)
                        mColors[touch.id] = Math.random() * uint.MAX_VALUE;
						
                    if (touch.phase == TouchPhase.HOVER || touch.phase == TouchPhase.ENDED)
                        continue;
                    
                    var location:Point = touch.getLocation(__coloringPage);
					if (mBrush != null)
					{
						mBrush.x = location.x;
						mBrush.y = location.y;
						
						if (__rotateBrush)
						{
							mBrush.rotation = Math.random() * Math.PI * 2.0;
						}
						
						mRenderTexture.draw(mBrush);
					}
                }
            });
        }     
        
        private function onButtonTriggered(event:Event):void
        {
			if (mBrush != null)
			{
				if (mBrush.blendMode == BlendMode.NORMAL)
				{
					mBrush.blendMode = BlendMode.ERASE;
					mButton.text = "Erase";
				}
				else
				{
					mBrush.blendMode = BlendMode.NORMAL;
					mButton.text = "Draw";
				}
			}
        }
		
		public function set brushColorFromString(hex_color:String):void
		{
			__activeColor =  uint(hex_color);
			if (mBrush != null)
			{
				mBrush.color = __activeColor;
				__debug.msg("brushColorFromString: " + hex_color + ", " + mBrush.color);
			}
		}
		
		public function set brush(img:Image):void
		{
			__debug.msg("set: brush: " + img);
			mBrush = img;
			mBrush.color = __activeColor;
		}
		
		public function set page(url:String):void
		{
			__debug.msg("set: page: " + url);
			mRenderTexture.clear();
			__coloringPage.loadImage(url);
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