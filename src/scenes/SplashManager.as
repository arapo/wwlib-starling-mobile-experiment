package scenes 
{
	import org.wwlib.util.WwDebug;
	import starling.animation.IAnimatable;
	/**
	 * ...
	 * @author ...
	 */
	public class SplashManager implements IAnimatable
	{
		
		private var __debug:WwDebug = WwDebug.instance;
		private var __cumulativeTime:Number = 0;
		
		public function SplashManager() 
		{
			
		}
		
		public function advanceTime(time:Number):void
		{
			__cumulativeTime += time;
			__debug.msg("CumulativeTime" + __cumulativeTime);
		}
		
	}

}