package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import starling.core.Starling;
	
	/**
	 * ...
	 * @author Abiyasa
	 * http://abiyasa.com/blog/2011/11/02/setting-up-starling-framework-with-flashdevelop/
	 */
	public class Main extends Sprite 
	{
		private var _starling:Starling;
		
		public function Main():void 
		{
			super();			
			
			this.addEventListener(Event.ADDED_TO_STAGE, init, false, 0, true);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_starling = new Starling(Screen1, this.stage);
			_starling.start();
		}
		
	}
	
}