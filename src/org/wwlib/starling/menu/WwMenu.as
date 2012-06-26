package org.wwlib.starling.menu 
{
	
	import org.wwlib.starling.WwSprite;
	import starling.display.Sprite;
	import starling.animation.Transitions;
    import starling.animation.Tween;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
	import starling.core.Starling;
	
	/**
	 * ...
	 * @author arapo
	 */
	public class WwMenu extends WwSprite
	{
		private var __id:String;
		private var __xOff:int;
		private var __yOff:int;
		private var __xOn:int
		private var __yOn:int;
		private var __tabXML:XML;
		private var __optionsXMLList:XMLList;
		private var __options:Vector.<WwMenuOption> = new Vector.<WwMenuOption>();
		private var __xmltransition:String;
		private var __transition:String;
		private var __menuTab:WwMenuOption;
		
		protected var __optionFunction:Function;
		
		
		public function WwMenu(xml:XML) 
		{
			__id = xml.@id;
			__xOff = xml.@x_off * __scaleFactor;
			__yOff = xml.@y_off * __scaleFactor;
			__xOn = xml.@x_on * __scaleFactor;
			__yOn = xml.@y_on * __scaleFactor;
			
			__xmltransition = xml.@transition;
			
			switch(__xmltransition)
			{
				case "bounce":  __transition = Transitions.EASE_OUT_BOUNCE;
					break;
				
				case "linear":  __transition = Transitions.LINEAR;
					break;
					
				case "elastic": __transition = Transitions.EASE_OUT_ELASTIC;
					
				default:  __transition = Transitions.EASE_IN_OUT;
					break;
			}
			
			
			
			x = __xOff;
			y = __yOff;
			
			__url = xml.@img_url;
			loadImage(__url);
			
			__tabXML = xml.tab[0];
			__optionsXMLList = xml.option;
			
		}
		
		override public function onReady():void 
		{
			super.onReady();
			
			//MENU TAB
			__menuTab = new WwMenuOption(this, __tabXML);
			addChild(__menuTab);
			__menuTab.addEventListener(TouchEvent.TOUCH, onTouchMenuTab);
			
			//MENU OPTIONS
			var option_xml:XML;
			var index:int = 0;
			for each (option_xml in __optionsXMLList)
			{
				var temp_option:WwMenuOption = new WwMenuOption(this, option_xml);
				addChild(temp_option);
				__options.push(temp_option);
				index++;
			}
		}
		
		public function init():void
		{
			
		}
		
        private function onTouchMenuTab(event:TouchEvent):void
        {
			var touches:Vector.<Touch> = event.getTouches(__menuTab);
			
                for each (var touch:Touch in touches)
                {
                    if (touch.phase == TouchPhase.BEGAN)
					{
						animate();
					}
						
                    if (touch.phase == TouchPhase.HOVER || touch.phase == TouchPhase.ENDED)
                        continue;
                }
		}
		
		public function animate():void
		{
			var tween:Tween;
			if (y == __yOn && x == __xOn)
			{	
				tween = new Tween(this, 0.5, __transition);

				tween.moveTo(__xOff, __yOff);
				//tween.onComplete = function():void { };

				Starling.juggler.add(tween);
			}
			else
			{
				tween = new Tween(this, 0.5, __transition);

				tween.moveTo(__xOn, __yOn);
				//tween.onComplete = function():void { };

				Starling.juggler.add(tween);
			}
		}
		
		
		public function chooseOption(value:String):void
		{
			//__debug.msg("chooseOption: " + value + ", " + __optionFunction);
			if ((value != "") && (__optionFunction != null))
			{
				__optionFunction(value);
			}
		}
		
		public function setOptionFunction(f:Function):void
		{
			__optionFunction = f;
		}
	}

}