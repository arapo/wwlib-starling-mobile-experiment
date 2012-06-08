package scenes
{
    import flash.geom.Point;
    import flash.utils.Dictionary;
    
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
        private var mRedButton:Button;
        private var mBlueButton:Button;
        private var mColors:Dictionary;
		
		private var __MENU_START_Y:int = -283;
		private var __menuColor:Image;
		private var __menuBrush:Image;
		private var __menuScene:Image;
		private var __menuShare:Image;
		
		private var __transitions:Array;
        
        public function RenderTextureScene()
        {
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
            
            var infoText:TextField = new TextField(256, 128, "Touch the screen\nto draw!");
            infoText.fontSize = 24;
            infoText.x = Constants.CenterX - infoText.width / 2;
            infoText.y = Constants.CenterY - infoText.height / 2;
            mRenderTexture.draw(infoText);
            
            mButton = new Button(Assets.getTexture("ButtonNormal"), "Mode: Draw");
            mButton.x = int(Constants.CenterX - mButton.width / 2);
            mButton.y = 15;
            mButton.addEventListener(Event.TRIGGERED, onButtonTriggered);
            addChild(mButton);
            
            mRedButton = new Button(Assets.getTexture("ButtonSquare"), "Red");
            mRedButton.x = 5;
            mRedButton.y = int(Constants.CenterY - mRedButton.width / 2)-30;
            mRedButton.addEventListener(Event.TRIGGERED, onRedButtonTriggered);
            addChild(mRedButton);
            
            mBlueButton = new Button(Assets.getTexture("ButtonSquare"), "Blue");
            mBlueButton.x = 5;
            mBlueButton.y = int(Constants.CenterY - mBlueButton.width / 2)+30;
            mBlueButton.addEventListener(Event.TRIGGERED, onBlueButtonTriggered);
            addChild(mBlueButton);
			
			__transitions = [Transitions.LINEAR, Transitions.EASE_OUT, Transitions.EASE_IN_OUT,
                            Transitions.EASE_OUT_BACK, Transitions.EASE_OUT_BOUNCE,
                            Transitions.EASE_OUT_ELASTIC];
							
			setupMenus();
        }
		
		private function setupMenus():void
		{
			
			__menuColor = new Image(Assets.getTexture("MenuColor"));
			__menuBrush = new Image(Assets.getTexture("MenuBrush"));
			//__menuScene = new Image(Assets.getTexture("menu_scene.png"));
			//__menuShare = new Image(Assets.getTexture("menu_share.png"));
			
			__menuColor.addEventListener(TouchEvent.TOUCH, onTouchMenuColor);
			__menuBrush.addEventListener(TouchEvent.TOUCH, onTouchMenuBrush);
			
			__menuColor.y = __MENU_START_Y;
			__menuBrush.y = __MENU_START_Y;
			
			addChild(__menuBrush);
			addChild(__menuColor);
			
		}
		
        private function onTouchMenuColor(event:TouchEvent):void
        {
			var touches:Vector.<Touch> = event.getTouches(__menuColor);
			var tween:Tween;
			var transition:String;
            
                for each (var touch:Touch in touches)
                {
                    if (touch.phase == TouchPhase.BEGAN)
					{
						if (__menuColor.y == 0)
						{
							// get next transition style from array and enqueue it at the end
							transition = __transitions.shift();
							__transitions.push(transition);
							
							tween = new Tween(__menuColor, 0.5, transition);

							tween.moveTo(0, __MENU_START_Y);
							//tween.onComplete = function():void { };

							Starling.juggler.add(tween);
							//__menuColor.y = __MENU_START_Y;
						}
						else
						{
							// get next transition style from array and enqueue it at the end
							transition = __transitions.shift();
							__transitions.push(transition);
							
							tween = new Tween(__menuColor, 0.5, transition);

							tween.moveTo(0, 0);
							//tween.onComplete = function():void { };

							Starling.juggler.add(tween);
							//__menuColor.y = 0;
						}
					}
						
                    if (touch.phase == TouchPhase.HOVER || touch.phase == TouchPhase.ENDED)
                        continue;
                }
		}
		
        private function onTouchMenuBrush(event:TouchEvent):void
        {
			var touches:Vector.<Touch> = event.getTouches(__menuBrush);
            
                for each (var touch:Touch in touches)
                {
                    if (touch.phase == TouchPhase.BEGAN)
					{
						if (__menuBrush.y == 0)
						{
							__menuBrush.y = __MENU_START_Y;
						}
						else
						{
							__menuBrush.y = 0;
						}
					}
						
                    if (touch.phase == TouchPhase.HOVER || touch.phase == TouchPhase.ENDED)
                        continue;
                }
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
                    mBrush.rotation = Math.random() * Math.PI * 2.0;
                    
                    mRenderTexture.draw(mBrush);
                }
            });
        }
        
        private function onBlueButtonTriggered(event:Event):void
        {
        mBrush.color = (0x112FFF);
        mBlueButton.text = "BLUE";
        mRedButton.text = "Red";
        }
                
        private function onRedButtonTriggered(event:Event):void
        {
        mBrush.color = (0xFF1111);
        mRedButton.text = "RED";
        mBlueButton.text = "Blue";
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
        
        public override function dispose():void
        {
            mRenderTexture.dispose();
            super.dispose();
        }
    }
}