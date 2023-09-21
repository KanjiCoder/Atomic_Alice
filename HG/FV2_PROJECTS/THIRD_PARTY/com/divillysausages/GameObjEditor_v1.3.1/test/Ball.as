package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	/**
	 * A simple ball class that jumps up and down every few seconds.
	 */
	public class Ball extends Sprite
	{
		
		/*********************************************************************************/
		
		private var m_currTime:Number 	= 0.0;			// the current time before we jump
		private var m_jumpTime:Number 	= 5.0;			// when we'll jump
		private var m_prevTime:int 		= 0;			// the previous time (used to calculate the delta time)
		private var m_floor:Number 		= 400.0;		// the floor level
		private var m_vy:Number 		= 0.0;			// our current y velocity
		private var m_colour:uint 		= 0xff0000;		// the colour of our ball
		private var m_type:String 		= Type.TYPE_1;	// a random type filled from a static
		
		/*********************************************************************************/
		
		// here we're making the "visible" variable editable even though we don't have a
		// getter/setter defined in this class. By default, this will be a checkbox
		[Editable( field = "visible" )]
		
		// here we're making the "x" variable editable through a slider
		[Editable( field = "x", type = "slider", min = "20.0", max = "450.0", step = "1.0" )]
		
		// here we're making the "y" variable watchable
		[Editable( field = "y", type="watch" )]
		
		// making a boolean editable - this will be a checkbox by default
		[Editable]
		public var shouldShow:Boolean = true;
		
		// making a number editable - by default this is a numerical stepper, so we're we're just
		// setting the min and max values - the step is 1 by default
		[Editable( min = 1, max = 5 )]
		public var weight:int = 2;
		
		/*********************************************************************************/
		
		// making the jumpTime editable through a slider. we set the type directly here as otherwise
		// it'll use a stepper by default
		[Editable( type = "slider", min = 1.0, max = 10.0, step = 1.0 )]
		public function get jumpTime():Number { return this.m_jumpTime; }
		public function set jumpTime( n:Number ):void
		{
			this.m_jumpTime = n;
		}
		
		// here we're setting the floor variable editable, but with a bigger range and step
		[Editable( type = "slider", min = 100.0, max = 400.0, step = 10.0 )]
		public function get floor():Number { return this.m_floor; }
		public function set floor( n:Number ):void
		{
			this.m_floor = n;
		}
		
		// here we're setting the name of the ball, with a 16 char max limit
		[Editable( maxChars = 16 )]
		override public function set name( s:String ):void 
		{
			super.name = s;
		}
		
		// here we're editing the colour, and choosing the type "colour" as it's a
		// stepper by default. this will redraw the ball
		[Editable( type = "colour" )]
		public function get colour():uint { return this.m_colour; }
		public function set colour( u:uint ):void
		{
			this.m_colour = u;
			this._draw();
		}
		
		// here we're making the type editable. by default Strings are edited through
		// an input, but we're making this a static_consts and passing in a class to take the
		// static consts out of it to use
		[Editable( type = "static_consts", clazz = "Type" )]
		public function get type():String { return this.m_type; }
		public function set type( s:String ):void
		{
			this.m_type = s;
			trace( "The ball's type is " + s );
		}
		
		/*********************************************************************************/
		
		/**
		 * Creates, draws and positions the ball
		 */
		public function Ball() 
		{
			// draw the ball
			this._draw();
			
			// set our pos
			this.x = 300.0;
			this.y = this.m_floor;
			
			// add a enter frame
			this.addEventListener( Event.ENTER_FRAME, this._onEnterFrame );
			
			// set the prev time
			this.m_prevTime = getTimer();
		}
		
		/*********************************************************************************/
		
		// draws our ball according to our colour
		private function _draw():void
		{
			this.graphics.clear();
			this.graphics.lineStyle( 2.0 );
			this.graphics.beginFill( this.m_colour );
			this.graphics.drawCircle( 0.0, 0.0, 20.0 );
			this.graphics.endFill();
		}
		
		// called everyframe - count down and jump when we reach our time
		private function _onEnterFrame( e:Event ):void
		{
			// get the delta time
			var curr:int 		= getTimer();
			var delta:Number 	= ( curr - this.m_prevTime ) * 0.001;
			this.m_prevTime		= curr;
			
			// add gravity
			this.m_vy += 0.9 * delta * this.weight * 2.0;
			
			// add the vy
			this.y += this.m_vy;
			if ( this.y >= this.m_floor )
			{
				this.y 		= this.m_floor;
				this.m_vy 	*= - 0.6;
			}
			
			// kill the velocity if we're on the floor and not really moving
			var diff:Number = this.m_floor - this.y;
			if ( diff < 0.0 ) diff *= -1.0;
			if ( this.m_vy < 0.15 && this.m_vy > -0.15 && diff < 0.1 )
				this.m_vy = 0.0;
			
			// we only count down when our vel is 0.0
			if ( this.m_vy != 0.0 )
				return;
			
			// add our time
			this.m_currTime += delta;
			if ( this.m_currTime < this.m_jumpTime )
				return;
				
			// jump up
			this.m_currTime -= this.m_jumpTime;
			this.m_vy = -2.0 * this.weight;
		}
		
	}

}