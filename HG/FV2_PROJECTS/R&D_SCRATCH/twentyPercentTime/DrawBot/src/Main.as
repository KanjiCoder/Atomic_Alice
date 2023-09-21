package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.Graphics;
	import flash.text.TextField;
	
	//UI interface for the draw bot.
	import DrawBotUI;
	
	/**
	 * ...
	 * @author JMIM
	 */
	public class Main extends Sprite 
	{
		
		private var _bot:DrawBot;
		private var _paper:Sprite;
		
	
		
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//Create our paper, and link our new draw-bot to that paper:
			_paper = renderPaper(8.5,11); //8.5 * 11 piece of paper.
			_bot = new DrawBot(10, _paper);
			
			//add the paper and draw-bot to the stage:
			this.addChild(_paper);
			this.addChild(_bot);
			
			_bot.giveDrawBotDrawingOrders(7, 40);
			
			//create simple ui to give bot instructions:
			var ui:DrawBotUI = new DrawBotUI(_paper.width, 32, _bot.giveDrawBotDrawingOrders);
			this.addChild(ui);
			
			/** Update every frame. **/
			this.addEventListener(Event.ENTER_FRAME, mainLoop);
		}
		

		
		/** Create our paper. **/
		private function renderPaper(inWid:Number, inHig:Number):Sprite
		{
			//scale the paper units into internal units:
			var h:Number = inWid * 50;
			var w:Number = inHig * 50;
			
			var out:Sprite = new Sprite();
			var g:Graphics = out.graphics;
			g.beginFill(0x00, 0.5);
			g.drawRect(0, 0, w, h);
			g.endFill();
			
			var txt:TextField = new TextField();
			out.addChild(txt);
			txt.text = "NORTH >>";
			txt.x = w - txt.textWidth;
			txt.width = txt.textWidth + 10;
			txt.y = (h / 2) + (txt.height / 2);
			
			return out;
		}
		
		private function mainLoop(evt:Event):void
		{
			_bot.update();
		}
	
		
	}//class
}//package

import flash.display.Graphics;
import flash.display.SpreadMethod;
import flash.geom.Point;
import flash.display.Sprite;
import flash.globalization.NumberFormatter;
import flash.printing.PrintJobOrientation;

internal class DrawBot extends Sprite
{
	/** our draw bot has a pen it draws with! **/
	private var _pen:Pen;
	
	/** Targeting object that draw bot puts on paper so we know what draw-bot is looking at **/
	private var _targDisp:Sprite;
	
	/** how close to target do we have to be to be touching it? **/
	private var _rangeTolerance:Number = 5;
	
	/** Also for tolerance error accounting. **/
	private var _prevDist:Number = Number.MAX_VALUE;
	
	/** Draw bot needs to remember where it did it's original point plots
	 *  so it can connect the dots later. **/
	private var _dotMemory:Vector.<Point>;
	private var _maxDotMemoryIndex:int;
	
	/** Number of sides of the current NGON you are working on. **/
	private var _numSides:int;
	
	/** Current target point we want to hit. May be in either phase. **/
	private var _curTarg:Point;
	
	/** A speed vector for how much the robot moves each frame. **/
	private var _roboSpeed:Number = 5;
	
	/** The radius of what you are currently trying to plot. **/
	private var _plotRad:Number;
	
	/** The radius of your robot. **/
	private var _myRobotsRadius:Number;
	
	private var _paperCenter:Point = new Point();
	
	/** The paper we are drawing on. **/
	private var _paper:Sprite;
	
	/** The current dot in _dotMemory the robot is going after. **/
	private var _dotTargetPTR:int;
	
	/** current phase of process we are in. **/
	private var _roboPhase:int;
	
	/** Sub-phases that only apply when _roboPhase == PHASE_SURVEY_PLOT **/
	private var _surveySubPhase:int;
	
	/** Sub_phases that only apply when _roboPhase == PHASE_CONNECT **/
	private var _connectSubPhase:int;
	
	/** sub phase for going back to registration point. **/
	private var _regGotoSubPhase:int;
	
	/** ints intialize at zero. So never use ZERO as an ENUM. **/
	private var _PHASE_ERROR:int = 0;
	
	/** Plotting dots to connect phase. **/
	private var _PHASE_SURVEY_PLOT:int = 1;
	
	/** Connecting those dots phase. **/
	private var _PHASE_CONNECT:int = 2;
	
	/** Going back to registration after drawing phase. **/
	private var _PHASE_GOTO_REGISTRATION:int = 3;
	
	/** Idle phase waiting for orders. **/
	private var _PHASE_IDLE:int = 4;
	
	/** Robot is in center, orientating itself to the next target point. **/
	private var _SURVEY_SUB_PHASE_ORIENT_TOWARDS_TARGET:int = 8;
	/** Moving out to create a plot point. **/
	private var _SURVEY_SUB_PHASE_OUT:int = 9;
	/** Moving in to get back to registration point before plotting another. **/
	private var _SURVEY_SUB_PHASE_IN :int = 10;
	
	/** robot is moving towards the next dot to connect. **/
	private var _CONNECT_SUB_PHASE_MOVING_TO_TARGET:int = 13;
	
	/** robot is re-adjusting to face the next target. **/
	private var _CONNECT_SUB_PHASE_ORIENT_TOWARDS_TARGET:int = 14;
	
	/** Going back to registration point: subphase: Orient. **/
	private var _REG_SUB_PHASE_ORIENT:int = 15;
	
	/** Going back to registration point: subphase: Moving. **/
	private var _REG_SUB_PHASE_MOVETOCENTER:int = 16;
	
	
	/** Vector telling us direction we want to go in. Must be translated into degrees **/
	//private var _dirVec:Point = new Point();
	
	
	/**
	 * @param	inRad: Radius of our draw bot. Draw bot always sets the
	 *                 pen down at it's centerpoint.
	 */
	public function DrawBot(inRad:Number, inPaper:Sprite)
	{
		renderDrawBot(inRad);
		recordCenterPointOfPaper(inPaper);
		this.x = _paperCenter.x;
		this.y = _paperCenter.y;
		face_north();
		_roboPhase = _PHASE_IDLE;
		_myRobotsRadius = inRad;
		_paper = inPaper;
		_pen = new Pen(_paper.graphics);
	}
	
	private function recordCenterPointOfPaper(inPaper:Sprite):void
	{
		_paperCenter.x = inPaper.width / 2;
		_paperCenter.y = inPaper.height  / 2;
	}
	
	/** Render what draw-bot looks like. **/
	private function renderDrawBot(inRad:Number):void
	{
		//render bot as just a colored circle.
		//This is after all, a skematic demonstration.
		var g:Graphics = this.graphics;
		g.beginFill(0xFF0000, 0.5);
		g.drawCircle(0, 0, inRad); //draw robot at centerpoint of sprite to make calcs easy.
		
		//Marks what way draw-bot is facing:
		g.drawCircle(inRad, 0, inRad / 5); //0degrees is to RIGHT in this program.
		                                   //So NORTH. will be to the LEFT.
		
		g.endFill();
	}//renderDrawBot
	
	/** change the way draw-bot is facing by # of degrees. **/
	private function turn_left(inDegrees:Number):void
	{
		var newAMT:Number = this.rotation - inDegrees;
		if (newAMT < -180)
		{
			throw new Error("outside of robot range of motion!");
		}
		
		this.rotation = newAMT;
	}
	
	/** change the way draw-bot is facing by # of degrees. **/
	private function turn_right(inDegrees:Number):void
	{
		var newAMT:Number =  this.rotation + inDegrees;
		if (newAMT > 180)
		{
			throw new Error("outside of robot range of motion!");
		}
		
		
		this.rotation = newAMT;
	}
	
	/** Move the robot forward. **/
	private function move_forward():void
	{
		var osVec:Point = new Point();
		var rads:Number = MathSense2000.degToRad( this.rotation);

		osVec.x = Math.cos(rads) * _roboSpeed;
		osVec.y = Math.sin(rads) * _roboSpeed;
		
		this.x = this.x + osVec.x;
		this.y = this.y + osVec.y;
	}
	
	/** Function so that draw-bot can get into it's default-position after it is done drawing**/
	private function face_north():void
	{
		//0 rotation == default pose of facing north
		this.rotation = 0;
	}
	
	/** Returns the degrees in which the robot is orientated. So that we know how orientation
	 *  should be altered. **/
	private function get_orientation():Number
	{
		return this.rotation;
	}
	
	/** Order draw bot to go back to center of paper. Used when draw-bot is done drawing.
	 *  Once draw-bot reaches the center, draw bot will call a callback function.
	 *  Usually that callback function is face_north, so that drawbot can be completely
	 *  in the default orientation. **/
	private function headTowardsCenterOfPaper(inCallback:Function):void
	{
		
	}
	
	/** Return draw-bot to the registration point that is center of paper. **/
	private function doReturnToRegistrationPointRoutine():void
	{
		headTowardsCenterOfPaper( face_north );
	}
	
	/** Returns true if draw bot has moved far enough out **/
	public function checkIfDrawBotHasGoneFarEnoughOut():Boolean
	{
		//calculate distance between center of paper and draw bot:
		var cen:Point = new Point();
		cen.x = this.x;
		cen.y = this.y ;
		
		//Get distance from paper center to our robot:
		var dist:Number = getDist(_paperCenter, cen);
		
		/** Return true if we have gone far enough out, or too far out. From the plot radius. **/
		if (dist >= _plotRad)
		{
			return true;
		}
		
		return false;
		
	}//checkIfDrawBotHasGoneFarEnoughOut
	
	/** Dist of vector pt1 --> pt2 **/
	private function getDist(pt1:Point, pt2:Point):Number
	{
		var deltas:Point = new Point();
		deltas.x = pt2.x - pt1.x;
		deltas.y = pt2.y - pt1.y;
		
		//calculate distance:
		var nonSquaredDist:Number = (deltas.x * deltas.x) + (deltas.y * deltas.y);
		var dist:Number = Math.sqrt( nonSquaredDist );
		
		return dist;
	}
	
	private function updateTargetDisplay(inTarg:Point):void
	{
		if (null == _targDisp) 
		{ 
			_targDisp = new Sprite();
			_paper.addChild(_targDisp);
		}
		_targDisp.x = inTarg.x;
		_targDisp.y = inTarg.y;
		
		var g:Graphics = _targDisp.graphics;
		g.clear();
		g.lineStyle(1, 0xFF0000, 0.5);
		g.drawCircle(0, 0, _rangeTolerance);
	}
	
	/** Returns true if draw bot is close enough to it's target. **/
	private function checkIfDrawBotHasHitTarget(inTarg:Point):Boolean
	{
		//For Debugging, see what the current target is that we are checking against:
		updateTargetDisplay(inTarg);
		
		var cen:Point = new Point();
		cen.x = this.x;
		cen.y = this.y;
		
		//TODO: some type of DOT-Product analysis of vector to see if we
		//have gone too far. For now, just use hackish tolerance of dist < 2
		
		var dist:Number = getDist(cen, inTarg);
		
		/** Error correcting. We got close to target, but not close enough,
		 *  and now we are wandering away. **/
		if (dist > _prevDist)
		{
			_prevDist = Number.MAX_VALUE;
			return true;
		}
		
		//tolerance of < 2 so that we don't go over our target and fly out.
		if (dist < _rangeTolerance) 
		{ 
			_prevDist = Number.MAX_VALUE;
			return true; 
		}
		
		_prevDist = dist;
		return false;
	}
	
	public function update():void
	{
		_pen.updatePosition(this.x, this.y);
		
		switch(_roboPhase)
		{
			case _PHASE_IDLE:
				break; //nothing
			case _PHASE_SURVEY_PLOT:
				updateSurveyPhase();
				break;
			case _PHASE_CONNECT:
				updateConnectPhase();
				break;
			case _PHASE_GOTO_REGISTRATION:
				updateGotoRegistrationPhase();
				break;
			default:
				throw new Error("unknown phase!");
		}//switch.
	}//upate
	
	private function updateGotoRegistrationPhase():void
	{
		switch(_regGotoSubPhase)
		{
			case _REG_SUB_PHASE_ORIENT:
				updateRegSubOrientPhase();
				break;
			case _REG_SUB_PHASE_MOVETOCENTER:
				updateRegSubMoveToCenterPhase();
				break;
			default:
				throw new Error("unknown reg-move subphase.");
		}
	}//updateGotoRegistrationPhase
	
	private function updateRegSubOrientPhase():void
	{
		faceTargetPoint(_paperCenter);
		_regGotoSubPhase = _REG_SUB_PHASE_MOVETOCENTER;
	}
	
	private function updateRegSubMoveToCenterPhase():void
	{
		var results:Boolean = checkIfDrawBotHasHitTarget(_paperCenter);
		if (results)
		{
			_roboPhase = _PHASE_IDLE;
		}
		else
		{
			move_forward();
		}
	}//updateRegSubMoveToCenterPhase
	
	private function updateConnectPhase():void
	{
		switch(_connectSubPhase)
		{
			case _CONNECT_SUB_PHASE_ORIENT_TOWARDS_TARGET:
				updateConnectOrientPhase();
				break;
			case _CONNECT_SUB_PHASE_MOVING_TO_TARGET:
				updateConnectMoveToTarget();
				break;
			default:
				throw new Error("unknown connect sub phase.");
		}
	}//updateConnectPhase
	
	private function liftPenAndGotoRegistration():void
	{
		_roboPhase = _PHASE_GOTO_REGISTRATION;
		_regGotoSubPhase = _REG_SUB_PHASE_ORIENT;
		_pen.lift();
	}
	
	private function updateConnectMoveToTarget():void
	{
		move_forward();
		
		var targ:Point = _dotMemory[ _dotTargetPTR ];
		if ( checkIfDrawBotHasHitTarget(targ) )
		{
			_pen.drop();
			
			_dotTargetPTR++;
			if (_dotTargetPTR > _maxDotMemoryIndex)
			{
				liftPenAndGotoRegistration();
			}
			else
			{
				_connectSubPhase = _CONNECT_SUB_PHASE_ORIENT_TOWARDS_TARGET;
			}
		}
		else
		{
			
		}
	}
	
	private function updateConnectOrientPhase():void
	{
		var targ:Point = _dotMemory[ _dotTargetPTR ];
		updateOrientTowardsTarget( targ );
		_connectSubPhase = _CONNECT_SUB_PHASE_MOVING_TO_TARGET;
		
		//This will help correct error if robot overshoots target!
		_prevDist = Number.MAX_VALUE;
	}
	
	private function updateOrientTowardsTarget(inTarg:Point):void
	{
		faceTargetPoint(inTarg);
	}
	
	private function updateSurveyPhase():void
	{
		switch(_surveySubPhase)
		{
			case _SURVEY_SUB_PHASE_ORIENT_TOWARDS_TARGET:
				fromCenterOfPaperRotateToFaceTarget();
				_surveySubPhase = _SURVEY_SUB_PHASE_OUT;
				break;
			case _SURVEY_SUB_PHASE_OUT:
				updateSurveyOutPhase();
				break;
			case _SURVEY_SUB_PHASE_IN:
				updateSurveyInPhase();
				break;
			default:
				throw new Error("unknown survey sub phase.");
		}//switch.
	}//update survey phase
	
	private function moveRightOrLeftToHitNewOrientation(newDeg:Number):void
	{
		//Robot only understands -180 to 180 in terms of orientation.
		//account for that:
		if (newDeg > 180)
		{
			//calculate spill-off amount that is OVER 180.
			//Step down from NEGATIVE 180 by that amount.
			newDeg = (-180) + (newDeg - 180)
		}
		
		//get current rotation of robot so we know how much to turn right or left:
		var curFacing:Number = get_orientation();
		
		//convert your orientations to 0-360 so we can create angle vectors that don't need
		//a huge conditional hell to adjust:
		var targDeg360:Number;
		var faceDeg360:Number;
		faceDeg360 = curFacing + 180;
		targDeg360    = newDeg + 180;
		
		var angVec:Number = (targDeg360 - faceDeg360);
		if (angVec > 0)
		{
			turn_right(angVec);
		}else
		if (angVec < 0)
		{
			turn_left(0 - angVec);
		}
	}//move right or left to hit the new orientation you want to hit.
	
	private function fromCenterOfPaperRotateToFaceTarget():void
	{
		//calculate which point we want to survey next, and rotate to face it:
		var newDeg:Number = (_dotTargetPTR / _numSides) * 360;
		
		moveRightOrLeftToHitNewOrientation(newDeg);
		
	}//fromCenterOfPaperRotateToFaceTarget
	
	private function updateSurveyOutPhase():void
	{
		var results:Boolean = checkIfDrawBotHasGoneFarEnoughOut();
		if (results)
		{
			plotSurveyPointAndRecord();
			faceTargetPoint(_paperCenter);
			_surveySubPhase = _SURVEY_SUB_PHASE_IN;
		}
		else
		{
			move_forward();
		}
	}
	
	private function initConnectPhase():void
	{
		/** target pointer re-set to ZERO so that we can go from target to target
		 *  and draw lines between them. **/
		_dotTargetPTR = 0;
		_roboPhase = _PHASE_CONNECT;
		_connectSubPhase = _CONNECT_SUB_PHASE_ORIENT_TOWARDS_TARGET;
		
		//HACK: Duplicate the FIRST point onto the end of point vector so that
		//we will get a complete shape:
		_dotMemory.push( _dotMemory[0] );
		_maxDotMemoryIndex = _dotMemory.length - 1;
		
		//_pen.drop();
	}
	
	private function updateSurveyInPhase():void
	{
		var results:Boolean = checkIfDrawBotHasHitTarget(_paperCenter);
		if (results)
		{
			//if we have done our LAST target plot, we will exit the survey phase:
			//Else, we will orient towards the next target:
			if ( _dotTargetPTR > _maxDotMemoryIndex)
			{
				initConnectPhase();
			}
			else
			{
				_surveySubPhase = _SURVEY_SUB_PHASE_ORIENT_TOWARDS_TARGET;
			}
		}
		else
		{
			move_forward();
		}
	}//updateSurveyInPhase
	
	/** orientate the robot by a given amount of degrees so that it is facing the target point. **/
	private function faceTargetPoint(inPT:Point):void
	{
		var vec:Point = new Point();
		vec.x = inPT.x - (this.x);
		vec.y = inPT.y - (this.y);
		
		//convert vector to angle:
		var radians:Number = Math.atan2(vec.y, vec.x);
		
		//convert to degrees:
		var degs:Number = radians * (180 / Math.PI);
		
		//set rotation of robot to face center of target:
		//this.rotation = degs; //<< this is cheating.
		
		moveRightOrLeftToHitNewOrientation(degs);
		
	}//faceTargetPoint
	
	private function plotSurveyPointAndRecord():void
	{
		//store the position in memory:
		_dotMemory[ _dotTargetPTR ] = new Point(this.x, this.y);
		
		//draw the point:
		var g:Graphics = _paper.graphics;
		g.beginFill(0x00FF00, 0.5);
		g.drawCircle( _dotMemory[_dotTargetPTR].x,
		              _dotMemory[_dotTargetPTR].y, 3);
		g.endFill();	  
		
		//incrimetn pointer for next storage:
		_dotTargetPTR++;
		
	}//plotSurveyPointAndRecord
	
	/**
	 *  Give the draw bot orders. If the draw bot was in the middle of drawing something,
	 *  draw bot will leave the last order un-finished in order to do what ever new order
	 *  you gave draw bot. 
	 * @param	inNumSides :Number of sides on our NGON
	 * @param	inRad      :Radius of our NGON.
	 */
	public function giveDrawBotDrawingOrders(inNumSides:int, inRad:Number):void
	{
		_dotTargetPTR = 0;
		_dotMemory = new Vector.<Point>();
		_maxDotMemoryIndex = inNumSides - 1;
		_numSides = inNumSides;
		_plotRad = inRad;
		_surveySubPhase = _SURVEY_SUB_PHASE_ORIENT_TOWARDS_TARGET;
		_roboPhase = _PHASE_SURVEY_PLOT;
	}
	
	
}//class

import flash.display.Graphics;
internal class Pen
{
	private var _prevX:Number;
	private var _prevY:Number;
	private var _g:Graphics;
	
	private var _isDown:Boolean;
	
	/**
	 * 
	 * @param	inG: The graphics object that the pen draws to. **/
	public function Pen(inG:Graphics):void
	{
		_g = inG;
	}
	
	/** update positon of pen. **/
	public function updatePosition(inX:int, inY:int):void
	{
		if (_isDown)
		{
			_g.lineStyle(2, 0x0000FF, 0.5);
			_g.moveTo(_prevX, _prevY);
			_g.lineTo(inX, inY);
		}
		
		_prevX = inX;
		_prevY = inY;
	}
	
	public function drop():void
	{
		_isDown = true;
	}
	
	public function lift():void
	{
		_isDown = false;
	}
}//Pen

internal class MathSense2000
{
	public static function degToRad(deg:Number):Number
	{
		var rads:Number = deg * (Math.PI / 180); //convert to radians.
		return rads;
	}
	
	public static function radToDeg(rad:Number):Number
	{
		var degs:Number = rad * (180 / Math.PI);
		return degs;
	}
}