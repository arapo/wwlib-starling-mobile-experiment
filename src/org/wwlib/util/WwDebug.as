package org.wwlib.util 
{
	import flash.display.Stage;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	/**
	 * ...
	 * @author arapo
	 */
	public class WwDebug 
	{
		private static var __instance:WwDebug;
		private var __stage:Stage;
		private var __SHOW_DEBUG_MESSAGES:Boolean;
		private var __debugText:TextField;
		
		/**
		*   Construct the WwDebug instance. This class is a Singleton, so it should not
		*   be directly instantiated. Instead, call the static "instance" getter
		*   to get an instance of it.
		*   @param enforcer A SingletonEnforcer specifically designed to be
		*                   impossible to pass by outside classes.
		*/
		public function WwDebug(enforcer:SingletonEnforcer)
		{
			if (!(enforcer is SingletonEnforcer))
			{
				throw new ArgumentError("WwDebug cannot be directly instantiated!");
			}
		}
		
		/**
		*   Initialize the singleton if it has not already been initialized
		*   @return The singleton instance
		*/
		public static function init(_stage:Stage): WwDebug
		{
			if (__instance == null)
			{
				__instance = new WwDebug(new SingletonEnforcer());
			}
			
			__instance.stage = _stage;
			__instance.setupUI();
			return __instance;
		}
		
		/**
		*   Get the singleton instance
		*   @return The singleton instance or null if it has not yet been
		*           initialized
		*/
		public static function get instance(): WwDebug
		{
			return __instance;
		}

		public function set stage(_stage:Stage):void
		{
			__stage = _stage;
		}
		
		public function setupUI():void
		{
			__SHOW_DEBUG_MESSAGES = true;
            __debugText = new TextField();
			__debugText.background = true;
            __debugText.backgroundColor = 0xffffffff;
			__debugText.alpha = 0.50;
            __debugText.autoSize = TextFieldAutoSize.LEFT;
            __stage.addChild(__debugText);
			show = false;
			//msg("debugText");

		}
		
		public function set showDebugMessages(flag:Boolean):void
		{
			__SHOW_DEBUG_MESSAGES = flag;
		}
		
		public function clear():void
		{
			__debugText.text = "CLEARED:\n";
		}
		
		public function set show(flag:Boolean):void
		{
			__debugText.visible = flag;
		}
		
		public function get show():Boolean
		{
			return __debugText.visible;
		}
		
		public function msg(_msg:String, level:String = "GENERAL"):void
		{
			if (__SHOW_DEBUG_MESSAGES)
			{
				__debugText.appendText(level + ": " + _msg + "\n");
			}
		}
		
		public function set alpha(a:Number):void
		{
			__debugText.alpha = a;
		}
		
		public function get alpha():Number
		{
			return __debugText.alpha;
		}
	}

}

/** A class that is here specifically to stop public instantiation of the
*   WwDebug singleton. It is inaccessible by classes outside this file. */
class SingletonEnforcer{}