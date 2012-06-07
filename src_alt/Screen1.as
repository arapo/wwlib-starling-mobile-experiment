package  
{
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.VAlign;
	import starling.utils.HAlign;
	
	/**
	 * ...
	 * @author Abiyasa
	 * http://abiyasa.com/blog/2011/11/02/setting-up-starling-framework-with-flashdevelop/
	 */
	public class Screen1 extends Sprite 
	{
		protected var _box:Sprite;		
		
		public function Screen1() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, init);			
		}		
		
		protected function init(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
		
			createBox();			
		}		
		
		protected function createBox():void
		{
			// create box sprite
			_box = new Sprite();
			
			// create quad (box shape)
			var q:Quad = new Quad(128, 128, 0x009ee1);
			_box.addChild(q);
			
			// add text
			var text:TextField = new TextField(100, 100, "Hello World", "Verdana", 16, 0xFFFFFF);
			text.vAlign = VAlign.TOP;
			text.hAlign = HAlign.LEFT;						
			text.x = 10;
			text.y = 10;			
			_box.addChild(text);
			
			this.addChild(_box);
			
			_box.x = 100;
			_box.y = 100;
		}
	}

}