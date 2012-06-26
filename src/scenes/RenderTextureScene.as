package scenes
{
	import flash.display.LoaderInfo;
    import flash.geom.Point;
    import flash.utils.Dictionary;
	import org.wwlib.starling.menu.WwMenuManager;
	import org.wwlib.starling.WwBrush;
	import org.wwlib.starling.WwSprite;
	import org.wwlib.util.WwDebug;
	import org.wwlib.util.WwDeviceInfo;
	import starling.animation.Juggler;
    
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
        private var mBrush:WwBrush;
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
		
		private var __dashinterval:Number = 0;
		private var __dashvar:Number = 0;
		
		private var __dashinterval2:Number = 0;
		private var __dashvar2:Number = 0;
		
		private var mMovie:MovieClip;
		
		private var __expandscale:Number = 0;
		
		private var __blendmode:String;
        
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
  
			//__transitions = [Transitions.LINEAR, Transitions.EASE_OUT, Transitions.EASE_IN_OUT,
            //                Transitions.EASE_OUT_BACK, Transitions.EASE_OUT_BOUNCE,
            //                Transitions.EASE_OUT_ELASTIC];
							
			__menuManager = WwMenuManager.init(this);
			__menuManager = WwMenuManager.init(this);
			__menuManager.loadXML();
			
			//Movie Test
			var frames:Vector.<Texture> = Assets.getTextureAtlas().getTextures("flight");
            mMovie = new MovieClip(frames, 15);
            
            // add sounds
            //var stepSound:Sound = Assets.getSound("Step");
            //mMovie.setFrameSound(2, stepSound);
            
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
			
			Starling.juggler.add(new SplashManager())
			
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
					{
						__expandscale = 0;
					
					}	
						
						
						
						
                    if (touch.phase == TouchPhase.HOVER || touch.phase == TouchPhase.ENDED)
                        continue;
                    
                    var location:Point = touch.getLocation(__coloringPage);
					if (mBrush != null)
					{
						
						switch(__blendmode)
						{
							case "erase": mBrush.image.blendMode = BlendMode.ERASE;
							break;
							
							case "normal": mBrush.image.blendMode = BlendMode.NORMAL;
							break;
							
							default: mBrush.image.blendMode = BlendMode.NORMAL;
							break;
						}

						mBrush.image.x = location.x;
						mBrush.image.y = location.y;
						
						switch(__brushDynamicColor)
						{
							case "rainbow":
								
							/*** http://krazydad.com/tutorials/makecolors.php ***/
								
								if (mBrush.image.alpha == 1)
								{
								__rainbowvar += (2 * Math.PI) / 30;
								}
								
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
								
								mBrush.image.color = Color.rgb(__red, __green, __blue);
							
							break;
							
							case "random_rainbow":
								
							if (mBrush.image.alpha == 1)
							{
								__colorvar += 1000000;
							}
								mBrush.image.color = __colorvar;
								
							break;
							
							default:
						}
						
						switch (__brushBehavior) 
						{
							case "rotate_random":
								
								mBrush.resetScale();
								
								mBrush.image.rotation = Math.random() * Math.PI * 2.0;
							break;
							
							case "rotate_normal":
							
								mBrush.resetScale();
							
								mBrush.image.rotation +=  1*((2*Math.PI)/360);
							break;
							
							case "rotate_normal20x":
							
								mBrush.resetScale();
							
								mBrush.image.rotation +=  deg2rad(20);
							break;
							
							case "pulse":
							
								mBrush.resetScale();
							
								__scalevar += (Math.PI/20);
							
								mBrush.image.scaleX = (Math.sin(__scalevar)+2)/4;
								mBrush.image.scaleY = (Math.sin(__scalevar)+2)/4;
							break;
							
							case "dash":
							
								mBrush.resetScale();
							
								__debug.msg("rotation" + mBrush.image.rotation)
							
								mBrush.image.rotation = Math.atan2(__prevy-location.y,__prevx-location.x)-(Math.PI/2)
							
								__prevx = location.x;
								__prevy = location.y;
							break;
						
					
							
						case "interval_dash":
							
							mBrush.resetScale();
						
							__dashinterval = 10;
							
							mBrush.image.rotation = Math.atan2(__prevy-location.y,__prevx-location.x)-(Math.PI/2)
						
							if (__dashvar > 0) { __dashvar--; }
							if (__dashvar == 0) 
								{
									__prevx = location.x;
									__prevy = location.y;
									mBrush.image.alpha = 1;
									__dashvar = __dashinterval; 
								}
							else { mBrush.image.alpha = 0; }
						
						break;
						
					case "interval_dash_2step":
							
							mBrush.resetScale();
							__dashinterval2 = 10;
							
							mBrush.image.rotation = Math.atan2(__prevy-location.y,__prevx-location.x)-(Math.PI/2)
						
							if (__dashvar2 > 0) { __dashvar2--; }
							if (__dashvar2 == 0) 
								{
									__prevx = location.x;
									__prevy = location.y;
									mBrush.image.alpha = 1;
									__dashvar2 = __dashinterval2; 
								}
							else { mBrush.image.alpha = 0; }
						
						break;
						
						case "expand":
							
							__expandscale += .02;
							mBrush.image.scaleX = __expandscale;
							mBrush.image.scaleY = __expandscale;
							
							__debug.msg ("expandscale: " + mBrush.image.scaleX); 
					
						default:
						
					}
					
                    
                    mRenderTexture.draw(mBrush.image);
                  }
				}
            });
        }     
        
		
		public function set brushColorFromString(hex_color:String):void
		{
			__activeColor =  uint(hex_color);
			if (mBrush != null)
			{		
				
				switch (hex_color)
				{
					
					case "rainbow":
						__blendmode = "normal";
						__brushDynamicColor = "rainbow";
						
					break;
					
					case "random_rainbow":
						__blendmode = "normal";
						__brushDynamicColor = "random_rainbow";
						
						
					break;
					
					case "erase":
						
						__blendmode = "erase";
						__brushDynamicColor = "";
						
					break;
										
					default: 
						__blendmode = "normal";
						__brushDynamicColor = "";					
						//__activeColor =  uint(hex_color);
						mBrush.image.color = __activeColor;
						__debug.msg("brushColorFromString: " + hex_color + ", " + mBrush.image.color); 
					break;
				}
			}
		}
		
		public function set brush(brush:WwBrush):void
		{
			__debug.msg("set: brush: " + brush);
			mBrush = brush;
			mBrush.image.color = __activeColor;
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