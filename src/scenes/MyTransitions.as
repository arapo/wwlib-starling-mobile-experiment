package scenes 
{
	/**
	 * ...
	 * @author Jeddychan
	 */
	public class MyTransitions 
	{
		public static var EASE_IN_OUT_BACKWARDS:String = "testTransision";
		
		public static function testTransition(ratio:Number):Number
		{
			return .5 * (( -1 * Math.cos(ratio * 2 * Math.PI)) + 1);
		}
	}

}