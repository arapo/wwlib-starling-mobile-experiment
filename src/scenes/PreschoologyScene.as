package scenes 
{
	import org.wwlib.starling.WwSceneManager;
	import org.wwlib.starling.WwSprite;
    import starling.events.Event;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author arapo
	 */
	public class PreschoologyScene extends Scene
	{
		
		private var __logo:WwSprite;
		
		public function PreschoologyScene(scene_manager:WwSceneManager)
        {
			super(scene_manager);
			
			__logo = new WwSprite();
			__logo.addEventListener(TouchEvent.TOUCH, onTouch);
			__logo.loadImage("assets/scenes/preschoology_960.png");
			addChild(__logo);
			
		}
		
        private function onTouch(event:TouchEvent):void
        {
			            
			var touches:Vector.<Touch> = event.getTouches(__logo);
			
			for each (var touch:Touch in touches)
			{
				if (touch.phase == TouchPhase.BEGAN)
				{
					__sceneManager.sceneChange("Title_Preschoology", "Next");
				}	
					
				if (touch.phase == TouchPhase.HOVER || touch.phase == TouchPhase.ENDED)
					continue;
				
			}
        }  
		
	}

}