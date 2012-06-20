package org.wwlib.util 
{
	/**
	 * Adapted from ctp2nd on http://forum.starling-framework.org/topic/detect-device-modelperformance
	 * @author arapo
	 */

	import flash.geom.Rectangle;
	import flash.system.Capabilities;

	public class WwDeviceInfo 
	{
		private static var __instance:WwDeviceInfo;

		public static const isDebugger:Boolean = Capabilities.isDebugger;
		public static const isLandscape:Boolean = true;
		public static const debuggerDevice:String = "debugger_1024x768";
 		
		public var os:String;
		public var devString:String;
		public var width:Number;
		public var height:Number;
		public var canvasWidth:Number;
		public var canvasHeight:Number;
		public var centerX:Number;
		public var centerY:Number;
		public var device:String;
		public var scale:Number;
		public var assetScaleFactor:Number;  //relative to base 960x640 screen target
		public var resolutionX:Number;
		public var resolutionY:Number;
		public var isDebugger:Boolean;
		public var screenDPI:Number;
		public var topLeftX:Number;
		public var topLeftY:Number;

		public function WwDeviceInfo(enforcer:SingletonEnforcer)
		{
			if (!(enforcer is SingletonEnforcer))
			{
				throw new ArgumentError("WwDeviceInfo cannot be directly instantiated!");
			}
		}
 
		/**
		*   Initialize the singleton if it has not already been initialized
		*   @return The singleton instance
		*/
		public static function init(): WwDeviceInfo
		{
			if (__instance == null)
			{
				__instance = new WwDeviceInfo(new SingletonEnforcer());
				__instance.getDeviceDetails();
			}

			return __instance;
		}

		/**
		*   Get the singleton instance
		*   @return The singleton instance or null if it has not yet been
		*           initialized
		*/
		public static function get instance(): WwDeviceInfo
		{
			return __instance;
		}

		public function getDeviceDetails():void {

			this.os = Capabilities.os;
			var devStr:String = this.os;
			var devStrArr:Array = devStr.split(" ");
			devStr = devStrArr.pop();
			devStr = (devStr.indexOf(",") > -1)?devStr.split(",").shift():debuggerDevice;
			this.devString = devStr;

			this.resolutionY = Capabilities.screenResolutionX;
			this.resolutionX = Capabilities.screenResolutionY;
			this.isDebugger = Capabilities.isDebugger;
			this.screenDPI = Capabilities.screenDPI;

			if ((devStr == "iPhone1") || (devStr == "iPhone2") || (devStr == "iPhone3") || (devStr == "debugger_480x320")){
				// lowdef iphone, 3, 3g, 3gs, 4
				this.width = 480;
				this.height = 320;
				this.canvasWidth = 480;
				this.canvasHeight = 320;
				this.centerX = 240;
				this.centerY = 160;
				this.device = "iphone";
				this.scale = 0.5;
				this.assetScaleFactor = 0.5;
				this.topLeftX = 0;
				this.topLeftY = 0;
			} else if ((devStr == "iPhone4") || (devStr == "iPhone5")){
				// highdef iphone 4s, 5?
				this.width = 960;
				this.height = 640;
				this.canvasWidth = 960;
				this.canvasHeight = 640;
				this.centerX = 480;
				this.centerY = 320;
				this.device = "iphoneRetina";
				this.scale = 2;
				this.assetScaleFactor = 1.0;
				this.topLeftX = 0;
				this.topLeftY = 0;
			} else if ((devStr == "iPad1") || (devStr == "iPad2") || (devStr == "debugger_1024x768")){
				// ipad 1,2
				this.width = 1024;
				this.height = 768;
				this.canvasWidth = 960;
				this.canvasHeight = 640;
				this.centerX = 512;
				this.centerY = 384;
				this.device = "ipad";
				this.scale = 1;
				this.assetScaleFactor = 1.0;
				this.topLeftX = 32;
				this.topLeftY = 64;
			} else if ((devStr == "iPad3")){
				this.width = 2048;
				this.height = 1536;
				this.canvasWidth = 960;
				this.canvasHeight = 640;
				this.centerX = 1024;
				this.centerY = 768;
				this.device = "ipadRetina";
				this.scale = 2;
				this.assetScaleFactor = 1.0;
				this.topLeftX = 32;
				this.topLeftY = 64;
			} else {
				this.width = 1024;
				this.height = 760;
				this.canvasWidth = 960;
				this.canvasHeight = 640;
				this.centerX = 512;
				this.centerY = 384;
				this.device = WwDeviceInfo.debuggerDevice;
				this.scale = 1;
				this.assetScaleFactor = 1.0;
				this.topLeftX = 0;
				this.topLeftY = 0;
			}
		}

	}

}

/** A class that is here specifically to stop public instantiation of the
*   WwDebug singleton. It is inaccessible by classes outside this file. */
class SingletonEnforcer{}