package scenes 
{
	import org.wwlib.starling.WwSceneManager;
	import org.wwlib.starling.WwSprite;
	import starling.animation.Juggler;
	import starling.core.Starling;
    import starling.events.Event;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
	import scenes.Scene;
	
	import starling.animation.IAnimatable;
	
	/**
	 * ...
	 * @author arapo
	 */
	public class QuahogScene extends Scene implements IAnimatable
	{
		
		private var __logo:WwSprite;
		
		public function QuahogScene(scene_manager:WwSceneManager)
        {
			super(scene_manager);
			
			__logo = new WwSprite();
			__logo.addEventListener(TouchEvent.TOUCH, onTouch);
			__logo.loadImage("assets/scenes/quahog_960.png");
			addChild(__logo)
		}
		
		//////////
		
		private var __cumulativeTime:Number = 0;
		private var duration:Number;
		
		public function advanceTime(time:Number):void
		{
			
			duration= 5;
			
			__cumulativeTime += time;
			//__debug.msg("CumulativeTime" + __cumulativeTime);
			
			if (__cumulativeTime >= duration)
			{
				__sceneManager.sceneChange("Title_Quahog","Next")
			}
		}
		
		//////////
		
        private function onTouch(event:TouchEvent):void
        {
			            
			var touches:Vector.<Touch> = event.getTouches(__logo);
			
			for each (var touch:Touch in touches)
			{
				if (touch.phase == TouchPhase.BEGAN)
				{
					__sceneManager.sceneChange("Title_Quahog", "Next");
				}	
					
				if (touch.phase == TouchPhase.HOVER || touch.phase == TouchPhase.ENDED)
					continue;
				
			}
        }  
		
	}

}