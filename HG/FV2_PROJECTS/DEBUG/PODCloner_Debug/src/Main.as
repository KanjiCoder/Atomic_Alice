package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_EXT.org.flixel.plainOldData.TileTypePOD;
	import JM_LIB.utils.PODClonerUtil;
	import mx.utils.ObjectUtil;
	
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
			
			var d1:TileTypePOD = new TileTypePOD();
			d1.geomType    = 77
			d1.geomSubType = 78
			d1.isType      = 79;
			d1.lightType   = 88;
			d1.subType     = 99;
			d1.subTypeIndex = 1001;
			d1.killMe  = true;
			d1.isLight     = true;
			d1.isSolid     = true;
			
			
			var d2:TileTypePOD;
			//d2 = ObjectUtil.copy(d1) as TileTypePOD;
			d2 = PODClonerUtil.clone( d1 );
			
			
			trace("TileTypePOD.ANGLE == " + TileTypePOD.ANGLE);
			trace("d1.geomType==" + d1.geomType);
			trace("d2.geomType==" + d2.geomType);
			
		}
		
	}
	
}