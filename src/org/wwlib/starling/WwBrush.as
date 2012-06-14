package org.wwlib.starling 
{
	import flash.events.Event;
    import starling.display.BlendMode;
	
	/**
	 * ...
	 * @author arapo
	 */
	public class WwBrush extends WwSprite
	{
		
		public function WwBrush() 
		{
			
		}
		
		protected override function onImageLoaded(event:Event):void
		{
			super.onImageLoaded(event);
			
			__img.pivotX = __img.width / (2 * __scaleFactor);
            __img.pivotY = __img.height / (2 * __scaleFactor);
            __img.blendMode = BlendMode.NORMAL;
			
			__debug.msg("pivot: " + __img.pivotX + ", " + __img.pivotY);
		}
		
	}
}