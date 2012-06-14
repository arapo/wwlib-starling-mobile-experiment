package org.wwlib.starling 
{
	
	import org.wwlib.starling.menu.WwMenu;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.ImageDecodingPolicy;
	import flash.system.LoaderContext;
	import org.wwlib.starling.WwSprite;
	import org.wwlib.util.WwDebug;
	import starling.animation.Tween;
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * Adds image loading, crude debugging and other generally useful functionality...
	 * @author arapo
	 */
	public class WwSprite extends Sprite
	{
		protected var __img:Image;
		protected var __x:int;
		protected var __y:int;
		protected var __bmp:Bitmap;
		protected var __debug:WwDebug = WwDebug.instance;
		protected var __scaleFactor:Number = 0.5;
		protected var __url:String;
		
		public function WwSprite() 
		{

		}
		
		public function loadImage(url:String):void
		{
			__url = url;
			//__debug.msg("loadImage: " + __url);
			if (__url != "")
			{
				// create a LoaderContext
				var loaderContext:LoaderContext = new LoaderContext();
				// specify async decoding
				loaderContext.imageDecodingPolicy = ImageDecodingPolicy.ON_LOAD;
				// create a Loader
				var loader:Loader = new Loader();
				// inform the Loader
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onImageLoaded);
				loader.load( new URLRequest(url), loaderContext );
			}
			else
			{
				onReady();
			}
		}
		
		protected function onImageLoaded(event:Event):void
		{
			//__debug.msg("onImageLoaded: "+ __url);
			__bmp = event.target.content as Bitmap;
			__img = Image.fromBitmap(__bmp);
			__img.scaleX = __scaleFactor;
			__img.scaleY = __scaleFactor;
			//__img.alpha = 0.5;
			addChild(__img);
			onReady();
		}
		
		// Override this
		public function onReady():void
		{
			//__debug.msg("onReady: " + __url);
		}

		public function get image():Image
		{
			return __img;
		}
	}

}