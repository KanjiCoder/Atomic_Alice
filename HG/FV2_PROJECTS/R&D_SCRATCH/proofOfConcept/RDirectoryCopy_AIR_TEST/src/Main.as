package 
{

	import com.bit101.components.CheckBox;
	import com.bit101.components.Text;
	import com.bit101.components.TextArea;
	import com.bit101.components.PushButton;
	import com.greensock.plugins.EndVectorPlugin;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import JM_LIB.air_utils.AIRBitmapSaverUtil;
	import JM_LIB.air_utils.DirectoryUtil;
	import JM_LIB.air_utils.ManyFilesDoStufferUtil;
	import JM_EXT.com.adobe.utils.BitmapOpenerUtil;
	import JM_LIB.utils.encoding.encrypt.spiral.BitmapSpiralScramblerUtil;
	import JM_LIB.utils.encoding.encrypt.EncryptMasterUtil;
	//import JM_EXT.com.adobe.utils.BitmapSaverUtil;
	
	/**
	 * ...
	 * @author JMIM
	 */
	public class Main extends Sprite 
	{
		
		private var _encodeCB:CheckBox;
		private var _decodeCB:CheckBox;
		
		private var _dirToCopy:File;
		private var _hasDirToCopy:Boolean = false;
		
		private var _dirToPaste:File;
		private var _hasDirToPaste:Boolean = false;
		
		private var _bmSaver:AIRBitmapSaverUtil = new AIRBitmapSaverUtil();
		//private var _bmSaver:BitmapSaverUtil = new BitmapSaverUtil();
		private var _bmOpener:BitmapOpenerUtil = new BitmapOpenerUtil();
		//private var _scram:BitmapSpiralScramblerUtil = new BitmapSpiralScramblerUtil();
		
		private var _ed:EventDispatcher;
		private var _curFilePath:String;
		private var _stringKey:String;
		private var _doEncode:Boolean = true; 
		
		/** UI button to specify directory we want to copy. **/
		private var _btn_dirToCopy:PushButton;
		
		/** UI button to specify directory we want to paste our copy to. **/
		private var _btn_dirToPaste:PushButton;
		
		/** Will execute the copy-paste directory and scramble and all that
		 *  good stuff. **/
		private var _btn_doItNow:PushButton;
		
		private var _txtEncodeToken:Text;
		
		public function Main():void 
		{
			
			
			//var myFile:File = new File();
			//myFile.browseForDirectory("YO! Let's do this!");
			_dirToCopy  = new File();
			_dirToPaste = new File();
			//step1_getDirToCopy();
			
			_txtEncodeToken = new Text(this, 0, 0, "uploads.ungrounded.net");
			_txtEncodeToken.height = 20;
			
			_encodeCB = new CheckBox(this, 0,  0, "DO ENCODE", onDoEncodeSelected);
			_decodeCB = new CheckBox(this, 0 , 0, "DO DECODE", onDoDecodeSelected);
			
			_btn_dirToCopy  = new PushButton(this, 0, 0, "SOURCE DIR", doSpecifyCopyDir);
			_btn_dirToPaste = new PushButton(this, 0, 0, "DEST DIR" , doSpecifyPasteDir);
			_btn_doItNow    = new PushButton(this, 0, 0, "DO IT!!!" , gotoStep3);
			
			
			_encodeCB.y = _txtEncodeToken.height + _txtEncodeToken.y;
			_decodeCB.y = _encodeCB.height + _encodeCB.y;
			_btn_dirToCopy.y = _decodeCB.height + _decodeCB.y;
			_btn_dirToPaste.y = _btn_dirToCopy.height + _btn_dirToCopy.y;
			_btn_doItNow.y = _btn_dirToPaste.y + _btn_dirToPaste.height;
		}
		
		private function onDoEncodeSelected(evt:Event):void
		{
			_encodeCB.selected = true;
			_decodeCB.selected = false;
			_doEncode = true;
		}
		
		private function onDoDecodeSelected(evt:Event):void
		{
			_encodeCB.selected = false;
			_decodeCB.selected = true;
			_doEncode = false; //<<false means we will decode instead of encode.
		}
		
		
		/** Open dialog to specify the directory we are going to copy. **/
		private function doSpecifyCopyDir(evt:Event):void
		{
			step1_getDirToCopy();
		}
		
		/** Open dialog to specify the directory we are going to paste. **/
		private function doSpecifyPasteDir(evt:Event):void
		{
			step2_getDirToCopyInto();
		}
		
		/** Get the directory we want to copy. **/
		private function step1_getDirToCopy():void
		{
			_dirToCopy.addEventListener(Event.SELECT, onCopyDirSelected);
			_dirToCopy.browseForDirectory("COPY THIS DIRECTORY");
		}
		private function onCopyDirSelected(evt:Event):void
		{
			_hasDirToCopy = true;
		}
		
		private function gotoStep2(evt:Event):void
		{//rawer.
			step2_getDirToCopyInto();
		}//rawer.
		
		/** Get the directory we would like to copy into. **/
		private function step2_getDirToCopyInto():void
		{
			_dirToPaste.addEventListener(Event.SELECT, onPasteDirSelected);
			_dirToPaste.browseForDirectory("PASTE INTO HERE");
		}
		private function onPasteDirSelected(evt:Event):void
		{
			_hasDirToPaste = true;
		}
		
		private function gotoStep3(evt:Event):void
		{
			//Call the copy directory function:
			_stringKey = _txtEncodeToken.text;
			EncryptMasterUtil.f.init(_stringKey, false, false);
			copyIntoThenScramble(_dirToCopy, _dirToPaste, _stringKey, _doEncode);
		}
		
		/** Copys a directory, then goes into the directory that was copied and scrambles the assets using the 
		 *  inSeedKey as the seed value to use on the psuedo-random number generator that scrambles the assets. **/
		private function copyIntoThenScramble(directoryToCopy:File, locationCopyingTo:File, inStringKey:String, inDoEncode:Boolean):void
		{
			_doEncode  = inDoEncode;
			_stringKey = inStringKey;
		
			//Create copy of directory:
			copyInto(directoryToCopy, locationCopyingTo);
			
			//Scramble that directory:
			var doStuffer:ManyFilesDoStufferUtil;
			doStuffer = new ManyFilesDoStufferUtil();
			doStuffer.processDirectory(locationCopyingTo, maybeScramFile, weAreDone);
			
		}
		
		private function maybeScramFile(inFile:File, inED:EventDispatcher):void
		{
			if (inFile.isDirectory) { return };
			var type:String = (inFile.type).toUpperCase();
			if (".PNG" != type) 
			{ 
				//Do nothing. But let the event disbatcher object
				//know that you are done processing.
				inED.dispatchEvent( new Event(Event.COMPLETE) );
				return; 
			}
			
			_ed = inED;
			_curFilePath = inFile.nativePath;
			_bmOpener.openUsingFilePath(inFile.nativePath, definitelyScramFile, "definitelyScramFile");
			
			trace(inFile.name);
		}
		
		private function definitelyScramFile(inBitmap:BitmapData):void
		{
			var saveThisBM:BitmapData;
			//saveThisBM = _scram.encodeDecode(inBitmap, _stringKey, _doEncode);
			saveThisBM = EncryptMasterUtil.f.decodeEncode(inBitmap, _doEncode);
			
			_bmSaver.saveUsingFilePath(saveThisBM, _curFilePath, onScrambleFileSaved);
			
		}
		
		private function onScrambleFileSaved():void
		{
			_ed.dispatchEvent( new Event(Event.COMPLETE) );
		}
		
		private function weAreDone():void
		{
			trace("we are done!");
		}
		
		private function copyInto(directoryToCopy:File, locationCopyingTo:File):void
		{
			var directory:Array = directoryToCopy.getDirectoryListing();

			for each (var f:File in directory)
			{
				if (f.isDirectory)
				{
					copyInto(f, locationCopyingTo.resolvePath(f.name));
				}
				else
				{
					f.copyTo(locationCopyingTo.resolvePath(f.name), true);
				}
			}//next file

		}//package
		
		private function encodeDecodeAllPNGInDirectory(inDirectory:File):void
		{
			
		}
		
		
		
	}//class
}//package