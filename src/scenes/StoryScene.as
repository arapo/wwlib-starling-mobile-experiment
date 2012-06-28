package scenes
{
	import flash.display.LoaderInfo;
    import flash.geom.Point;
    import flash.utils.Dictionary;
	import org.wwlib.starling.menu.WwMenu;
	import org.wwlib.starling.WwBrush;
	import org.wwlib.starling.WwSceneManager;
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

    public class StoryScene extends Scene
    {
		private var __transitions:Array;
		private var __debug:WwDebug;
		private var __bg:WwSprite;
		
		/*** MENUS ******************************/
		
		private var __menuXMLList:XMLList;
		private var __storyMenu:WwMenu;
		private var __debugMenu:WwMenu;
		
		public function StoryScene(scene_manager:WwSceneManager)
        {
			super(scene_manager);
			__debug = WwDebug.instance;
			__debug.msg("Story: Starling.current.stage.stageWidth: " + Starling.current.stage.stageWidth);
			
            // like any animation, the movie needs to be added to the juggler!
            // this is the recommended way to do that.
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			
			__bg = new WwSprite();
			__bg.addEventListener(TouchEvent.TOUCH, onTouch);
			__bg.loadImage("assets/scenes/curtain_bg_open_1024.jpg");
			addChild(__bg);
        }
		
        private function onAddedToStage(event:Event):void
        {

        }
        
        private function onRemovedFromStage(event:Event):void
        {

        }
		
        private function onTouch(event:TouchEvent):void
        {
			            
			var touches:Vector.<Touch> = event.getTouches(__bg);
			
			for each (var touch:Touch in touches)
			{
				if (touch.phase == TouchPhase.BEGAN)
				{
					__sceneManager.sceneChange("Story", "Next");
				}	
					
				if (touch.phase == TouchPhase.HOVER || touch.phase == TouchPhase.ENDED)
					continue;
				
			}
        } 
        
		/*** MENUS *************************/
		
		public override function initMenusWithXML(xml:XML):void
		{
			//__debug.clear();
			__debug.msg("Main: initMenusWithXML: ");
			
			__menuXMLList = xml.menu;
			var menu_xml:XML;
			var tab_xml:XML;
			var options_xmlList:XMLList;
			var index:int = 0;
			for each (menu_xml in __menuXMLList)
			{
				tab_xml = menu_xml.tab[0];
				options_xmlList = menu_xml.option;
				var menu_id:String = menu_xml.@id;
				__debug.msg(menu_id);
				
				switch (menu_id) 
				{
					case "main":
						__storyMenu = new WwMenu(menu_xml);
						addChild(__storyMenu);
						__storyMenu.setOptionFunction(mainMenuOption);
					break;
					case "debug":
						__debugMenu = new WwMenu(menu_xml);
						addChild(__debugMenu);
						__debugMenu.setOptionFunction(debugMenuOption);
					break;
					default:
				}
				
				index++;
			}
		}
		
		public function mainMenuOption(value:String):void
		{
			__debug.msg("mainMenuOption: " + value);
			
		}
		

		public function debugMenuOption(value:String):void
		{
			__debug.msg("debugMenuOption: " + value);
			switch (value) 
			{
				case "btn1":
					__debug.show = !__debug.show;
				break;
				case "btn2":
					__debug.clear();
				break;
				case "btn3":
					if (__debug.alpha < 1)
					{
						__debug.alpha = 1;
					}
					else
					{
						__debug.alpha = .5;
					}
				break;
				default:
			}
			
			
		}
    }
}