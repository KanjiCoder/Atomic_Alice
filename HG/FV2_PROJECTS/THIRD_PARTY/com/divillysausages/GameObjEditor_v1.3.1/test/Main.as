package 
{
	import com.divillysausages.gameobjeditor.Editor;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	
	public class Main extends Sprite 
	{
		
		/*********************************************************************************/
		
		private var m_editor:Editor = null; // our editor object
		private var m_ball:Ball		= null; // the ball that we're going to add and remove
		
		/*********************************************************************************/
		
		public function Main():void 
		{	
			// draw a bg
			this.graphics.beginFill( 0xffffff );
			this.graphics.drawRect( 0.0, 0.0, this.stage.stageWidth, this.stage.stageHeight );
			this.graphics.endFill();
			
			// create the editor
			this.m_editor 			= new Editor( this.stage );
			this.m_editor.visible 	= true;
			this.m_editor.registerClass( Ball ); // register the ball class as something that we want to edit
			this.m_editor.registerClass( NonDisplay ); // register the non-display class as something that we want to edit
			
			this.m_editor.log( "Hello world!" ); // send a log message to the editor
			
			// add the ball and we go!
			this.m_ball = new Ball;
			this.addChild( this.m_ball );
			
			// add the non-display object as well
			var nd:NonDisplay = new NonDisplay;
			this.m_editor.registerObject( nd );
			
			// second ball
			var b:Ball	= new Ball;
			b.name 		= "second";
			b.x 		= 400.0;
			this.addChild( b );
			
			// tests for showing how to remove objects from the editor
			//this.stage.addEventListener( KeyboardEvent.KEY_DOWN, this._onDeleteCurrObject );
			//this.stage.addEventListener( KeyboardEvent.KEY_DOWN, this._onDirectRemove );
			//this.stage.addEventListener( KeyboardEvent.KEY_DOWN, this._onDisplayObjectRemove );
		}
		
		// called when we press a key, this shows you how to delete the current object
		private function _onDeleteCurrObject( e:KeyboardEvent ):void
		{
			// remove the current object from the editor
			if ( this.m_editor.currentObject != null )
				this.m_editor.unregisterObject( this.m_editor.currentObject );
		}
		
		// called when we press a key, this shows you how to directly remove an object
		private function _onDirectRemove( e:KeyboardEvent ):void
		{
			// our ball's already been removed
			if ( this.m_ball == null )
				return;
				
			// this is hardcode unregister the object
			// if it's the current object, then it's removed at the end of the frame,
			// otherwise it's immediate
			this.m_editor.unregisterObject( this.m_ball );
		}
		
		// called when we press a key, this shows you how to remove a display object
		private function _onDisplayObjectRemove( e:KeyboardEvent ):void
		{
			// our ball's already been removed
			if ( this.m_ball == null )
				return;
				
			// just remove the ball from it's parent/stage is enough to remove
			// it from the editor
			this.m_ball.parent.removeChild( this.m_ball );
			this.m_ball = null;
		}
		
	}
	
}