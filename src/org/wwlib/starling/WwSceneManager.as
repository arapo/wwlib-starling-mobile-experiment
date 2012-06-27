package org.wwlib.starling 
{
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	//import org.wwlib.starling.menu.WwMenuManager;
	import org.wwlib.starling.WwBrush;
	import org.wwlib.starling.WwSprite;
	import org.wwlib.util.WwDebug;
	import scenes.RenderTextureScene;
	import scenes.AnimationScene;
	import scenes.Scene;
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	
    import flash.utils.getDefinitionByName;
    import flash.utils.getQualifiedClassName;
	import starling.display.Button;
	import starling.textures.Texture;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author arapo
	 */
	public class WwSceneManager extends starling.display.Sprite
	{
		/** Singleton instance */
		private static var __instance:WwSceneManager;
		private var __debug:WwDebug;
		
		private var __sceneXmlURL:String = "assets/Config.xml";
		private var __xml:XML;
		private var __sceneXMLList:XMLList;
		private var __appSprite:starling.display.Sprite;
		//private var __menuManager:WwMenuManager;
		private var __MainMenu:Sprite;
        private var __CurrentScene:Scene;
		private var __sceneDictionary:Dictionary = new Dictionary();
		
		/**
		*   Construct the WwSceneManager. This class is a Singleton, so it should not
		*   be directly instantiated. Instead, call the static "instance" getter
		*   to get an instance of it.
		*   @param enforcer A SingletonEnforcer specifically designed to be
		*                   impossible to pass by outside classes.
		*/
		public function WwSceneManager(enforcer:SingletonEnforcer)
		{
			if (!(enforcer is SingletonEnforcer))
			{
				throw new ArgumentError("WwSceneManager cannot be directly instantiated!");
			}
			
			__debug = WwDebug.instance;
		}
		
		/**
		*   Initialize the singleton if it has not already been initialized
		*   @return The singleton instance
		*/
		public static function init(app:starling.display.Sprite): WwSceneManager
		{
			if (__instance == null)
			{
				__instance = new WwSceneManager(new SingletonEnforcer());
			}
			
			__instance.__appSprite = app;
			return __instance;
		}
		
		private function setup():void
		{
			addEventListener(Scene.CLOSING, onSceneClosing);
            
            var logo:Image = new Image(Assets.getTexture("Logo"));
            addChild(logo);
            
            var scenesToCreate:Array = [
                ["Coloring Demo", RenderTextureScene],
				["Dependency", AnimationScene]
				
			];
		}
		
		/**
		*   Get the singleton instance
		*   @return The singleton instance or null if it has not yet been
		*           initialized
		*/
		public static function get instance(): WwSceneManager
		{
			return __instance;
		}
		
		public function loadXML():void
		{
			
			// load the xml file using the URLLoader class
			var loader:URLLoader = new URLLoader(new URLRequest(__sceneXmlURL))
			// call xmlLoaded function once the xml has loaded
			loader.addEventListener(flash.events.Event.COMPLETE, xmlLoaded);
		}
		
		private function xmlLoaded(e:flash.events.Event):void {
			// assign loaded xml structure to our xml object
			__xml = new XML(e.target.data);
			__xml.ignoreWhitespace = true;
			
			initscenesWithXML(__xml);
		}
		
		private function initscenesWithXML(xml:XML):void
		{	
			__sceneXMLList = xml.scene;
			var scene_xml:XML;
			var tab_xml:XML;
			var options_xmlList:XMLList;
			var buttonTexture:Texture = Assets.getTexture("ButtonBig");
            var count:int = 0;
			for each (scene_xml in __sceneXMLList)
			{
				tab_xml = scene_xml.tab[0];
				options_xmlList = scene_xml.option;
				var scene_id:String = scene_xml.@id;
				__debug.msg("Scene: " + scene_id);
				
				__sceneDictionary[scene_id] = scene_xml;

				var button:Button = new Button(buttonTexture, scene_id);
				button.x = count % 2 == 0 ? 28 : 167;
				button.y = 180 + int(count / 2) * 52;
				button.name = scene_id;
				button.addEventListener(starling.events.Event.TRIGGERED, onButtonTriggered);
				addChild(button);
				++count;
			}
		}
		
        private function onButtonTriggered(event:starling.events.Event):void
        {
            var button:Button = event.target as Button;
            showScene(button.name);
        }
        
        private function onSceneClosing(event:starling.events.Event):void
        {
            __CurrentScene.removeFromParent(true);
            __CurrentScene = null;
        }
        
        private function showScene(name:String):void
        {
            if (__CurrentScene) return;
            
			var sceneXML:XML = __sceneDictionary[name];
            var sceneClass:Class = getDefinitionByName(sceneXML.@class_name) as Class;
            __CurrentScene = new sceneClass() as Scene;
			__CurrentScene.initMenusWithXML(__sceneDictionary[name]);
            addChild(__CurrentScene);
        }
	}
}

/** A class that is here specifically to stop public instantiation of the
*   WwSceneManager singleton. It is inaccessible by classes outside this file. */
class SingletonEnforcer{}
