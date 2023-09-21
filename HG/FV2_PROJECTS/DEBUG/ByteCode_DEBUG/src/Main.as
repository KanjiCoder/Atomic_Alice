package 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import org.as3commons.bytecode.emit.impl.AbcBuilder;
	import org.as3commons.bytecode.emit.IAbcBuilder;
	import org.as3commons.bytecode.emit.IClassBuilder;
	import org.as3commons.bytecode.emit.IPackageBuilder;
	import org.as3commons.bytecode.emit.IAccessorBuilder;
	import org.as3commons.bytecode.emit.IPropertyBuilder;
	import org.as3commons.reflect.AccessorAccess;
	import org.as3commons.bytecode.emit.IMethodBuilder;
	import org.as3commons.bytecode.emit.impl.MethodArgument;
	import org.as3commons.bytecode.abc.enum.Opcode;
	import org.as3commons.bytecode.emit.event.AccessorBuilderEvent;
	import org.as3commons.bytecode.emit.impl.PropertyBuilder;
	import org.as3commons.bytecode.emit.impl.MethodBuilder;
	
	import flash.errors.IOError;
	import flash.events.IOErrorEvent;
	
	import flash.system.ApplicationDomain;
	
	import flash.display.BitmapData;
	
	import mx.core.BitmapAsset;
	
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
			
			var abcBuilder:IAbcBuilder = new AbcBuilder();
			var packageBuilder:IPackageBuilder = abcBuilder.definePackage("com.classes.generated");

			//Once the package has been defined, a class can be defined:

			var classBuilder:IClassBuilder = packageBuilder.defineClass("RuntimeClass");

		
			
			
			//Defining Getters and Setters:
	
			//This is the standard getter/setter making, with no fancy stuff:
			//var accessorBuilder:IAccessorBuilder;
			//accessorBuilder = classBuilder.defineAccessor("count","int",100);
			//accessorBuilder.access = AccessorAccess.READ_ONLY;
			
			//Making a property "count" with special getter/setter:
			var accessorBuilder:IAccessorBuilder;
			accessorBuilder = classBuilder.defineAccessor("count", "int", 1000); //redundant?
			accessorBuilder.access = AccessorAccess.READ_ONLY;
			//accessorBuilder.property = new PropertyBuilder();
			
			
			//x//accessorBuilder.property = new PropertyBuilder("count","int",1000); //Example does it like this, but PropertyBuilder takes NO arguments.
			
			//accessorBuilder.property = new PropertyBuilder();
		
			//accessorBuilder.addEventLister(AccessorBuilderEvent.BUILD_GETTER, buildGetterHandler);


			
			var bm:BitmapData = new BitmapData(20, 20, true, 0xFF00FF00);
			classBuilder.defineAccessor("bitmapData", "flash.display.BitmapData");
			
			
			//Generating Methods:
			var methodBuilder:IMethodBuilder = classBuilder.defineMethod("multiplyByHundred");
			var argument:MethodArgument = methodBuilder.defineArgument("int");
			methodBuilder.returnType = "int";
			
			methodBuilder   .addOpcode(Opcode.getlocal_0)
							.addOpcode(Opcode.pushscope)
							.addOpcode(Opcode.getlocal_1)
							.addOpcode(Opcode.pushint, [100])
							.addOpcode(Opcode.multiply)
							.addOpcode(Opcode.setlocal_1)
							.addOpcode(Opcode.getlocal_1)
							.addOpcode(Opcode.returnvalue);
			
			
			
			//Loading generated classes into the AVM:
			abcBuilder.addEventListener(Event.COMPLETE, loadedHandler);
			abcBuilder.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			abcBuilder.addEventListener(IOErrorEvent.VERIFY_ERROR, errorHandler);
			
			//build and load:
			abcBuilder.buildAndLoad();
			
		}
		
		public function loadedHandler(event:Event):void {
		  var clazz:Class = ApplicationDomain.currentDomain.getDefinition("com.classes.generated.RuntimeClass") as Class;
		  var instance:Object = new clazz();
		  
		  //instance.bitmapData = new BitmapData(20, 20, true, 0xFF00FF00);
		  //instance.count = 4;
		  var i:int = instance.multiplyByHundred(10);
		  trace("i==" + i);
		  // i == 1000
		 // trace("count==" + instance.count);
		  trace("built!");
		}
		
		public function buildGetterHandler(event:AccessorBuilderEvent):void {
			var methodBuilder:IMethodBuilder = new MethodBuilder();
			//logic ommitted...
			event.builder = methodBuilder;
		}
		
		public function errorHandler(e:Event):void
		{
			trace("ERROR");
		}
		
	}//class
}//package