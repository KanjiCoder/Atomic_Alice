package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.system.ApplicationDomain;
	
	import org.as3commons.bytecode.emit.IPropertyBuilder;
	import org.as3commons.bytecode.emit.impl.AbcBuilder;
	import org.as3commons.bytecode.emit.IAbcBuilder;
	import org.as3commons.bytecode.emit.IClassBuilder;
	import org.as3commons.bytecode.emit.IPackageBuilder;
	import org.as3commons.bytecode.emit.enum.MemberVisibility;
	
	//import org.as3commons.bytecode.
	
	/**
	 * ...
	 * @author 
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
			
			
			var abcBuilder:IAbcBuilder = new AbcBuilder();
			var packageBuilder:IPackageBuilder = abcBuilder.definePackage("com.classes.generated");
			var classBuilder:IClassBuilder = packageBuilder.defineClass("RuntimeClass");
			classBuilder.isDynamic = true;
			
			//Create properties:
			var propertyBuilder:IPropertyBuilder = classBuilder.defineProperty("name", "String", "defaultName");
			propertyBuilder.visibility = MemberVisibility.PUBLIC;
			propertyBuilder.isStatic   = false;
			
			trace("hello");
			
			abcBuilder.addEventListener(Event.COMPLETE, loadedHandler);
			abcBuilder.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			abcBuilder.addEventListener(IOErrorEvent.VERIFY_ERROR, errorHandler);
			
			abcBuilder.buildAndLoad();
		}
		
		private function loadedHandler(event:Event):void {
		  var clazz:Class = ApplicationDomain.currentDomain.getDefinition("com.classes.generated.RuntimeClass") as Class;
		  var instance:Object = new clazz();
		  instance.name = "theName!";
		 trace("hello");
		}
		
		private function errorHandler(evt:Event):void
		{
			throw new Error("failed to load!");
		}
		
	}//package
}//class