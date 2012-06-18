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
	import starling.utils.Color;
	import starling.utils.deg2rad;
	import starling.display.MovieClip;
	import flash.media.Sound;
	import starling.textures.Texture;

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
		private var __brushBehavior:String;
		private var __brushDynamicColor:String;
		
		private var __scalevar:Number = 0;
		private var __colorvar:Number = 0;
		
		private var __rainbowvar:Number = 0;
		private var __red:Number = 0;
		private var __green:Number = 0;
		private var __blue:Number = 0;
		private var __offset1:Number = 0;
		private var __offset2:Number = ((2 * Math.PI) / 3);
		private var __offset3:Number = ((4 * Math.PI) / 3);
		private var __frequency:Number = 0;
		private var __amplitude:Number = 0;
		private var __center:Number = 0;
		
		private var __prevx:Number=0;
		private var __prevy:Number = 0;
		
		private var mMovie:MovieClip;
        
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
			
			//Movie Test
			var frames:Vector.<Texture> = Assets.getTextureAtlas().getTextures("flight");
            mMovie = new MovieClip(frames, 15);
            
            // add sounds
            var stepSound:Sound = Assets.getSound("Step");
            mMovie.setFrameSound(2, stepSound);
            
            // move the clip to the center and add it to the stage
            mMovie.x = WwDeviceInfo.instance.width - mMovie.width;// - (20 * WwDeviceInfo.instance.assetScaleFactor);
            mMovie.y = (20 * WwDeviceInfo.instance.assetScaleFactor);
			mMovie.scaleX = .5;
			mMovie.scaleY = .5;
            addChild(mMovie);
			
            // like any animation, the movie needs to be added to the juggler!
            // this is the recommended way to do that.
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
        }
		
        private function onAddedToStage(event:Event):void
        {
            Starling.juggler.add(mMovie);
        }
        
        private function onRemovedFromStage(event:Event):void
        {
            Starling.juggler.remove(mMovie);
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
						
						switch(__brushDynamicColor)
						{
							case "rainbow":
								
								/*** http://krazydad.com/tutorials/makecolors.php ***/
							
								__rainbowvar += (2 * Math.PI) / 30;
								
								__frequency = 1;
								
								/***normal***/
								__amplitude = 255/2;
								__center = 255/2;
								
								/***pastels***/
								//__amplitude = 25;
								//__center = 230;
								
								/***value = Math.sin(frequency*increment+offset)*amplitude + center;***/
								/***value = Math.sin(   __rainbowvar    +offset)*amplitude + center;***/
								
								__red = Math.sin(__frequency * __rainbowvar + __offset1) * __amplitude + __center;
								__green = Math.sin(__frequency * __rainbowvar + __offset2) * __amplitude + __center; 
								__blue = Math.sin(__frequency * __rainbowvar + __offset3) * __amplitude + __center; 
								
								mBrush.color = Color.rgb(__red, __green, __blue);
							
							break;
							
							case "random_rainbow":
							
								__colorvar += 1000000;
								mBrush.color = __colorvar;
								
							break;
							
							default:
						}
						
						switch (__brushBehavior) 
						{
							case "rotate_random":
								mBrush.rotation = Math.random() * Math.PI * 2.0;
							break;
							
							case "rotate_normal":
								mBrush.rotation +=  1*((2*Math.PI)/360);
							break;
							
							case "rotate_normal20x":
								mBrush.rotation +=  deg2rad(20);
							break;
							
							case "pulse":
							
								__scalevar += (Math.PI/20);
							
								mBrush.scaleX = (Math.sin(__scalevar)+2)/4;
								mBrush.scaleY = (Math.sin(__scalevar)+2)/4;
							break;
							
							case "dash":
							
								__debug.msg("rotation" + mBrush.rotation)
							
								mBrush.rotation = Math.atan2(__prevy-location.y,__prevx-location.x)-(Math.PI/2)
							
								__prevx = location.x;
								__prevy = location.y;
							break;
						
							default:
							
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
				switch (hex_color)
				{
					
					case "rainbow":
						__brushDynamicColor = "rainbow";
					break;
					
					case "random_rainbow":
						__brushDynamicColor = "random_rainbow";
					break;
					
					default: 
						__brushDynamicColor = "";
					
						//__activeColor =  uint(hex_color);
						mBrush.color = __activeColor;
						__debug.msg("brushColorFromString: " + hex_color + ", " + mBrush.color); 
					break;
				}
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
		
		public function set brushBehavior(s:String):void
		{
			__brushBehavior = s;
		}
        
        public override function dispose():void
        {
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            mRenderTexture.dispose();
            super.dispose();
        }

    }
}