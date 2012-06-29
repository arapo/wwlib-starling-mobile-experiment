package scenes
{
    import starling.animation.Transitions;
    import starling.animation.Tween;
    import starling.core.Starling;
    import starling.display.Button;
    import starling.display.Image;
    import starling.events.Event;
    import starling.text.TextField;
    import starling.textures.Texture;
    import starling.utils.Color;
    import starling.utils.deg2rad;
	import scenes.MyTransitions;

	
    public class AnimationScene extends Scene
    {
        private var mStartButton:Button;
        private var mDelayButton:Button;
        private var mEgg:Image;
        private var mTransitionLabel:TextField;
        private var mTransitions:Array;
        
        public function AnimationScene()
        {
            /*mTransitions = [Transitions.LINEAR, Transitions.EASE_OUT, Transitions.EASE_IN_OUT,
                            Transitions.EASE_OUT_BACK, Transitions.EASE_OUT_BOUNCE,
                            Transitions.EASE_OUT_ELASTIC];*/
            
            var buttonTexture:Texture = Assets.getTexture("ButtonNormal");
            
            // create a button that starts the tween
            mStartButton = new Button(buttonTexture, "Start animation");
            mStartButton.addEventListener(Event.TRIGGERED, onStartButtonTriggered);
            mStartButton.x = Constants.CenterX - int(mStartButton.width / 2);
            mStartButton.y = 20;
            addChild(mStartButton);
            
            // this button will show you how to call a method with a delay
            mDelayButton = new Button(buttonTexture, "Delayed call");
            mDelayButton.addEventListener(Event.TRIGGERED, onDelayButtonTriggered);
            mDelayButton.x = mStartButton.x;
            mDelayButton.y = mStartButton.y + 40;
            addChild(mDelayButton);
            
            // the Starling will be tweened
            mEgg = new Image(Assets.getTexture("StarlingFront"));
            addChild(mEgg);
            resetEgg();
            
            mTransitionLabel = new TextField(320, 30, "");
            mTransitionLabel.y = mDelayButton.y + 40;
            mTransitionLabel.alpha = 0.0; // invisible, will be shown later
            addChild(mTransitionLabel);
			
		
		
        }
		
				
		private function onStartButtonTriggered(event:Event):String
		{
			
			var toggle:String;
			
			if (toggle != "1") { toggle = "1"; tween(); }
			if (toggle == "1") { toggle = "0"; }
		
			return(toggle);
		
		}
	
        
        private function resetEgg():void
        {
            mEgg.x = 20;
            mEgg.y = 100;
            mEgg.scaleX = mEgg.scaleY = 0.5;
            mEgg.rotation = 0.0;
        }
		
		
		/*private function onStartButtonTriggered(event:Event):void
		{
			
			var toggle;
			
			if (toggle != 1) { toggle = 1; tween(); };
			if (toggle == 1) { toggle = 0; };
		
		
		}*/
	
        
		
		
        private function tween ():void
		{
            mStartButton.enabled = false;
            resetEgg();
			
			Transitions.register(MyTransitions.EASE_IN_OUT_BACKWARDS, MyTransitions.testTransition);
                       
           
            var tween:Tween = new Tween(mEgg, 3, MyTransitions.EASE_IN_OUT_BACKWARDS);
            // you can animate any property as long as it's numeric (int, uint, Number). 
            // it is animated from it's current value to a target value.  
            //tween.animate("rotation", .5); // conventional 'animate' call
            tween.moveTo(300, 100);
            tween.onComplete = function():void { tween2(); mStartButton.enabled = true; };
			
            
            // the tween alone is useless -- for an animation to be carried out, it has to be 
            // advance once in every frame.            
            // This is done by the 'Juggler'. It receives the tween and will carry it out.
            // We use the default juggler here, but you can create your own jugglers, as well.            
            // That way, you can group animations into logical parts.  
            Starling.juggler.add(tween);
            
            var hideTween:Tween = new Tween(mTransitionLabel, 3.0, Transitions.EASE_IN_OUT);
            hideTween.animate("alpha", 0.0);
            Starling.juggler.add(hideTween);
			
        }
		
		
		        private function tween2 ():void
		{
            mStartButton.enabled = false;
            resetEgg();
			
			Transitions.register(MyTransitions.EASE_IN_OUT_BACKWARDS, MyTransitions.testTransition);
                       
           
            var tween2:Tween = new Tween(mEgg, 3, MyTransitions.EASE_IN_OUT_BACKWARDS);
            // you can animate any property as long as it's numeric (int, uint, Number). 
            // it is animated from it's current value to a target value.  
            //tween.animate("rotation", .5); // conventional 'animate' call
            tween2.moveTo(300, 100);
            tween2.onComplete = function():void { tween(); mStartButton.enabled = true; };
			
            
            // the tween alone is useless -- for an animation to be carried out, it has to be 
            // advance once in every frame.            
            // This is done by the 'Juggler'. It receives the tween and will carry it out.
            // We use the default juggler here, but you can create your own jugglers, as well.            
            // That way, you can group animations into logical parts.  
            Starling.juggler.add(tween2);
            
            var hideTween2:Tween = new Tween(mTransitionLabel, 3.0, Transitions.EASE_IN_OUT);
            hideTween2.animate("alpha", 0.0);
            Starling.juggler.add(hideTween2);
			
        }
		
		
        private function onDelayButtonTriggered(event:Event):void
        {
            mDelayButton.enabled = false;
            
            // Using the juggler, you can delay a method call. This is especially useful when
            // you use your own juggler in a component of your game, because it gives you perfect 
            // control over the flow of time and animations. 
            
            Starling.juggler.delayCall(colorizeEgg, 1.0, true);
            Starling.juggler.delayCall(colorizeEgg, 2.0, false);
            Starling.juggler.delayCall(function():void { mDelayButton.enabled = true; }, 2.0);
        }
        
        private function colorizeEgg(colorize:Boolean):void
        {
            mEgg.color = colorize ? Color.RED : Color.WHITE;
        }
        
        public override function dispose():void
        {
            mStartButton.removeEventListener(Event.TRIGGERED, onStartButtonTriggered);
            mDelayButton.removeEventListener(Event.TRIGGERED, onDelayButtonTriggered);
            super.dispose();
        }
    }
}



