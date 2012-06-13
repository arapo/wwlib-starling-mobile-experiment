package org.wwlib.starling.menu 
{
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import org.wwlib.util.WwDebug;
	import scenes.RenderTextureScene;
	import scenes.Scene;
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	/**
	 * ...
	 * @author arapo
	 */
	public class WwMenuManager 
	{
		/** Singleton instance */
		private static var __instance:WwMenuManager;
		private var __debug:WwDebug;
		
		private var __menuXmlURL:String = "assets/menus/QC_menus.xml";
		private var __xml:XML;
		private var __menuXMLList:XMLList;
		private var __scene:RenderTextureScene;
		private var __colorsMenu:WwMenu;
		private var __brushesMenu:WwMenu;
		private var __pagesMenu:WwMenu;
		private var __shareMenu:WwMenu;
		private var __shopMenu:WwMenu;
				
		/**
		*   Construct the WwMenuManager. This class is a Singleton, so it should not
		*   be directly instantiated. Instead, call the static "instance" getter
		*   to get an instance of it.
		*   @param enforcer A SingletonEnforcer specifically designed to be
		*                   impossible to pass by outside classes.
		*/
		public function WwMenuManager(enforcer:SingletonEnforcer)
		{
			if (!(enforcer is SingletonEnforcer))
			{
				throw new ArgumentError("WwMenuManager cannot be directly instantiated!");
			}
			
			__debug = WwDebug.instance;
		}
		
		/**
		*   Initialize the singleton if it has not already been initialized
		*   @return The singleton instance
		*/
		public static function init(_scene:RenderTextureScene): WwMenuManager
		{
			if (__instance == null)
			{
				__instance = new WwMenuManager(new SingletonEnforcer());
				__instance.__scene = _scene;
			}
			
			return __instance;
		}
		
		/**
		*   Get the singleton instance
		*   @return The singleton instance or null if it has not yet been
		*           initialized
		*/
		public static function get instance(): WwMenuManager
		{
			return __instance;
		}
		
		public function loadXML():void
		{
			
			// load the xml file using the URLLoader class
			var loader:URLLoader = new URLLoader(new URLRequest(__menuXmlURL))
			// call xmlLoaded function once the xml has loaded
			loader.addEventListener(Event.COMPLETE, xmlLoaded);
		}
		
		private function xmlLoaded(e:Event):void {
			// assign loaded xml structure to our xml object
			__xml = new XML(e.target.data);
			__xml.ignoreWhitespace = true;
			
			initMenusWithXML(__xml);

		}
		
		private function initMenusWithXML(xml:XML):void
		{
			__debug.clear();
			__debug.msg("initMenusWithXML: ");
			
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
					case "colors":
						__colorsMenu = new WwMenu(menu_xml);
						__scene.addChild(__colorsMenu);
						__colorsMenu.setOptionFunction(colorMenuOption);
					break;
					case "brushes":
						__brushesMenu = new WwMenu(menu_xml);
						__scene.addChild(__brushesMenu);
					break;	
					case "pages":
						__pagesMenu = new WwMenu(menu_xml);
						__scene.addChild(__pagesMenu);
					break;					
					default:
				}
				
				index++;
			}
		}
		
		public function colorMenuOption(value:String):void
		{
			__debug.msg("colorMenuOption: " + value);
			
			__scene.brushColorFromString = value;
		}
	}
}

/** A class that is here specifically to stop public instantiation of the
*   WwMenuManager singleton. It is inaccessible by classes outside this file. */
class SingletonEnforcer{}