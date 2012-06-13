package org.wwlib.starling.menu 
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.ImageDecodingPolicy;
	import flash.system.LoaderContext;
	import org.wwlib.starling.WwSprite;
	import org.wwlib.util.WwDebug;
	import starling.animation.Tween;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	/**
	 * ...
	 * @author arapo
	 */
	public class WwMenuOption extends WwSprite
	{
		private var __id:String;
		protected var __value:String;
		protected var __parent:WwMenu;
		
		public function WwMenuOption(_parent:WwMenu, xml:XML) 
		{
			__parent = _parent;
			__id = xml.@id;
			__url = xml.@img_url;
			__x = xml.@x;
			__y = xml.@y;
			__value = xml.@value;
			
			loadImage(__url);
			x = __x * __scaleFactor;
			y = __y * __scaleFactor;
			
			addEventListener(TouchEvent.TOUCH, onTouch);
		}
				
        private function onTouch(event:TouchEvent):void
        {
			var touches:Vector.<Touch> = event.getTouches(this);
            
                for each (var touch:Touch in touches)
                {
                    if (touch.phase == TouchPhase.BEGAN)
					{
						chooseOption();
						__parent.animate();
					}
						
                    if (touch.phase == TouchPhase.HOVER || touch.phase == TouchPhase.ENDED)
                        continue;
                }
		}
		
		public function chooseOption():void
		{
			__parent.chooseOption(__value);
		}
	}

}