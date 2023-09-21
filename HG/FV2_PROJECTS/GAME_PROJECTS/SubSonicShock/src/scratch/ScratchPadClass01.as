package scratch 
{
	import com.google.analytics.AnalyticsTracker;
	import com.google.analytics.GATracker;
	/**
	 * ...
	 * @author JMIM
	 */
	public class ScratchPadClass01 
	{
		//1 var tracker:AnalyticsTracker = new GATracker( this, "UA-XXXXXX", "AS3", true );
		private var _tracker:GATracker;
		
		public function ScratchPadClass01() 
		{
			var visualDebug:Boolean = true;
			_tracker = new GATracker(this, "UA-54178011-1", "AS3", visualDebug);
		}
		
	}//class
}//package