package
{
    import com.bit101.components.*;
    import com.bit101.utils.MinimalConfigurator;
	import flash.display.DisplayObject;
	import flash.display.Stage;
     
    import flash.display.Sprite;
    import flash.events.Event;
     
    public class Playground extends Sprite
    {
        private var minConFig:MinimalConfigurator;
		
		public var a:int;
		public var r:int;
		public var g:int;
		public var b:int;
         
        public function Playground(inStage:Stage)
        {
            Component.initStage(inStage);
 
            var xml:XML = <comps>
							<HUISlider id ="a" label="A" tick="1" width="500" maximum="255" event="change:onChange" x="10" y="10"/>
							<HUISlider id ="r" label="R" tick="1" width="500" maximum="255" event="change:onChange" x="10" y="20"/>
							<HUISlider id ="g" label="G" tick="1" width="500" maximum="255" event="change:onChange" x="10" y="30"/>
							<HUISlider id ="b" label="B" tick="1" width="500" maximum="255" event="change:onChange" x="10" y="40"/>
                            <PushButton id="foo" label="hello" event="click:onClick" x="10" y="60"/>
                          </comps>;
             
            minConFig = new MinimalConfigurator(this);
            minConFig.parseXML(xml);
        }      
		
		public function onChange(evt:Event):void
		{
			var name:String = evt.target.name;
			var value:int = evt.target.value;
			
			trace("evt==" + evt);
			
			if (name == "a") { a = value; }else
			if (name == "r") { r = value; }else
			if (name == "g") { g = value; }else
			if (name == "b") { b = value; }else
			{ throw new Error("should be one of those");}
			
			
			trace("hi");
		}//onChange
         
        public function onClick(event:Event):void
        {
            var btn:PushButton = minConFig.getCompById("foo") as PushButton;
            btn.label = "[" + a.toString() + "," +
			                  r.toString() + "," +
							  g.toString() + "," +
							  b.toString() + "," +
							  "]";
            trace(btn.name); // foo
        }
    }//class
}//package