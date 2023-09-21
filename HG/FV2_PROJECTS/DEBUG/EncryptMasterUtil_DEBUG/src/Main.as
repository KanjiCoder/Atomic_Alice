package 
{
	
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_LIB.utils.encoding.encrypt.EncryptMasterUtil;
	import flash.text.TextField;
	import JM_LIB.siteLock.DomainGetter;
	
	/**
	 * ...
	 * @author JMIM
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			//EncryptMasterUtil.init("RAWER", false, false);
			EncryptMasterUtil.f.initUsingCurrentDomain(true, true);
			
			
			var dom:String = DomainGetter.getDomain();
			var txt:TextField = new TextField();
			txt.text = dom;
			this.addChild(txt);
		}
		
	}//class
}//package