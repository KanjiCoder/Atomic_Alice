package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import JM_LIB.utils.math.chemistry.ElectronDiagFilingResults;
	import JM_LIB.utils.math.chemistry.ElectronFilingMathUtil;
	import JM_LIB.utils.math.chemistry.EnergyIndexAndRemainder;
	import JM_LIB.utils.math.chemistry.EnergyIndexAndSpareElectrons;
	import JM_LIB.utils.math.chemistry.OrbitalDiagFilingResults;
	import JM_LIB.utils.math.chemistry.SubShellFillingData;
	import JM_LIB.utils.math.chemistry.SSConfig;
	
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
			
			/*
			var f:Function = thickDiagonalIndexToElectronCount;
			for (var k:int = 0; k < 10; k++)
			{
				trace( k.toString() + " ---> " +f(k).toString() );
			}
			*/
			/*
			var MAX_DIAG_CHECK:int = 20;
			var o:int; //o stands for number of orbitals.
			var d:int; //d stands for the unique diagonal index.
			var maxOrbitalsInBiggestShellInThisDiagonal:int = ( -1);
			var maxOrbitalsTotalInThisDiagonal:int = 0;
			var twoOrbitals:int = 2;
			var results:OrbitalDiagFilingResults;
			for (d = 1; d < MAX_DIAG_CHECK; d++)
			{
				maxOrbitalsInBiggestShellInThisDiagonal += twoOrbitals; //1,3,5,7 etc.
				maxOrbitalsTotalInThisDiagonal += maxOrbitalsInBiggestShellInThisDiagonal; //summation 1,3,5,7 pattern above.
				
				for (o = 1; o <= maxOrbitalsTotalInThisDiagonal; o++)
				{
					results = fileOrbitalsIntoSubShellDiag(o, d);
					trace("hi"); //manually look through all the output and see if it is working correctly.
				}
			}
			*/
			
			var result:Object;
			for (var i:int = 2; i < 119; i++)
			{
				//NOTE: Fix electronIndexToEnergyIndex so it only returns FULL energy indicies.
				//That way the leftover electrons are really left-over / valence.
				result = electronIndexToEnergyIndex(i);
				trace("debug");
			}
			
			
			trace("DONE!");
			
			//callFNUsingInputs( electronCountToThickDiagonalIndex, [0, 4, 5, 16, 17, 36, 37, 64]);
			//callFNUsingInputs( subShellDiagComboIndex_to_numOrbitalsInDiag, [0, 1, 2, 3, 4, 5]);
			//callFNUsingInputs( numberOfOrbitalsToSubShellDiagCombo, [1, 4, 9, 16, 27]);
			//callFNUsingInputs( numberOfOrbitalsToSubShellDiagCombo, [1, 4, 9, 16, 27]);
			
			//callFNUsingInputs( numberOfOrbitalsToSubShellDiagCombo, [1,   2,3,   4,   5,8,   9,   10,15,   16,   17,26,  27]);
			
			/*
			for (var i:int = 0; i < 141; i++)
			{
				var res:int = numberOfOrbitalsToSubShellDiagCombo(i);
				trace(i.toString() + "-#->" + res.toString() );
			}
			*/
			
			//callFNUsingInputs( numberOfOrbitalsToSubShellDiagCombo, [7,9,10,12,13,16,17,20,21,25]);
			
			//callFNUsingInputs(thickDiagonalIndexToElectronCount, [1, 2, 3, 4, 5, 6]);
			
			//callFNUsingInputs(getElectronSummationOfFilingDiagonals, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
			
			//callFNUsingInputs(subShellDiagComboIndex_to_numOrbitalsInDiag, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
			
			//callFNUsingInputs( electronIndexToEnergyIndex, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 14, 12, 32, 443, 1232, 23123]);
			
			
		}
		
		private function callFNUsingInputs(fn:Function, inputs:Array):void
		{
			var i:int;
			var v:Number;
			for (var a:int = 0; a < inputs.length; a++)
			{
				i = inputs[a]; //i == input.
				v = fn( i );
				trace(i.toString() + " ----> " + v.toString() );
			}//next a
		}//callFNUsingInputs
		
		public function electronIndexToEnergyIndexAndRemainderElectrons(inElectronCount:int):EnergyIndexAndRemainder
		{
			
		}
		
		
		/** this is NOT:
			 * NOT: the THIN diagonal.
			 * NOT: the THICK diagonal.
			 * It is an index corrosponding to sorted unique THIN diagonals in the filing chart.
			 * Because, when filing, the thin diagonals come in pairs. **/
		private function fileElectronsIntoSubShellDiag(inElectrons:int, inUniqueSubShellDiagComboIndex:int):ElectronDiagFilingResults
		{
			//var numOrbitalsAvailable:int = numberOfOrbitalsToSubShellDiagCombo(inUniqueSubShellDiagComboIndex);
			var numPairs:int = Math.floor(inElectrons / 2);
			var theLonelyOddElectron:int = (inElectrons & 1); //use bitwise operator to decide if there is something left over.
			
			//shell filing order examples:
			//comboIndex==1: [1]
			//comboIndex==2: [1][2][3]  [4]
			//comboIndex==3: [1][2][3][4][5]  [6][7][8]  [9]
			//need a function that does:
			//input:  numOrbitals & diagComboIndex
			//output: numShellsFilled & valence electrons.
			
			//out.numSubShellsCompletelyFilled
			
			//This value is only non-zero if there is a shell that is NOT completely filled.
			//out.subValenceElectrons
			
			var out:ElectronDiagFilingResults = new ElectronDiagFilingResults();
			//var preOut:ElectronDiagFilingResults = new ElectronDiagFilingResults();
			
			if (numPairs <= 0)
			{////////////////////////////////////////////////////////////////
				out.leftOverElectrons = theLonelyOddElectron;
				out.numSubShellsFilled = 0;
				return out;
			}////////////////////////////////////////////////////////////////
			
			//grouping pairs of elections:
			//[ * * ] [ * * ]
			//[ * * ] [ * * ] [ * * ]
			//   p1      p2     lonely pair.
			
			
			var orbitalPairs:int;
			var theLonelyPairOfElectrons:int = (numPairs & 1) * 2;
			if (theLonelyPairOfElectrons > 0)
			{
				orbitalPairs = (numPairs - 1) * 0.5;
			}
			else
			{
				orbitalPairs = numPairs * 0.5;
			}
			
			//Was doing it this way, but realized we needed to group up ONE MORE TIME.
			//r = fileOrbitalsIntoSubShellDiag(numPairs, inUniqueSubShellDiagComboIndex);
			
			//We are using orbitalPairs instead of orbitals because whatever happens to r will
			//have to be MULTIPLIED BY 2 in the end.
			var rp:OrbitalDiagFilingResults;
			rp = fileOrbitalsIntoSubShellDiag(orbitalPairs, inUniqueSubShellDiagComboIndex);
			
			//Double your results:
			//Multiply all of your results by two, and also sum up the odd electrons that may have been left out:
			out.numSubShellsFilled = rp.numFullSubShells * 2;
			out.leftOverElectrons = 0;
			if (false == rp.isLastSubShellFull)
			{
				out.leftOverElectrons += (rp.numElectronsInLastSubShell * 2);
			}
			out.leftOverElectrons += theLonelyOddElectron;
			out.leftOverElectrons += theLonelyPairOfElectrons;
			
			return out;
		
			
			/*
			if (true)
			{   //we don't have to worry about what to do with that last electron!
				out.numSubShellsFilled = r.numFullSubShells;
				
				var sType:int = r.subShellTypeIndexOfLastSubShell;
				out.finalSubShell.subShellTypeIndex = sType;
				out.finalSubShell.totalNumOrbitalsAvailableInSubShell = ElectronFilingMathUtil.getTotalNumberOfOrbitalsBySubShellType( sType );
				if (r.isLastSubShellFull)
				{
					out.finalSubShell.numCompletelyFilledOrbitals = r.numFullSubShells;
					out.finalSubShell.numPartiallyFilledOrbitals  = 0;
				}
				else
				{
					out.finalSubShell.numElectrons = r.numElectronsInLastSubShell;
					SSConfig.reDistributeElectrons( out.finalSubShell );
				}
				
				//out.finalSubShell.numElectrons = r.numElectronsInLastSubShell;
				//out.finalSubShell.numOrbitals  =
				
			}//if true.
			
			//If we have an odd electron, we need to see if we can use it to fill one more sub shell.
			//If we can't because the last sub shell we calculated was full, we will just make note of it
			//in the returned data.
			if (1 == theLonelyOddElectron)
			{
				
				if (r.isLastSubShellFull)
				{//this will be a bit difficult, we have to scootch over to new data for out now.
					out.hasSpareElectron = true;
				}
				else
				{
					out.finalSubShell.numElectrons = out.finalSubShell.numElectrons + 1;
					SSConfig.reDistributeElectrons(out.finalSubShell);
					
					if (out.finalSubShell.numCompletelyFilledOrbitals == 
					    out.finalSubShell.totalNumOrbitalsAvailableInSubShell)
					{
						r.isLastSubShellFull = true;
						r.numFullSubShells = r.numFullSubShells + 1;
						out.numSubShellsFilled = r.numFullSubShells;
					}
				}
			}//lonely odd electron.
			
			CONFIG::debug
			{/////////////////////////////////////////////////////////////////
				if (theLonelyOddElectron != 0 && theLonelyOddElectron != 1)
				{
					throw new Error("should be equal to 1 or 0");
				}
			}//////////////////////////////////////////////////////////////////
			
			return out;
			*/
			
		}//fileElectronsIntoSubShellDiag //fnfnfnfnfnfnfnfnfnfnfnfnfnfnfnfnfnfnfnfnfnfnfnfnfnfnfnfnfnfnfnfnfnfnfnfnfnfnfnfnfnfn
		
		/*
		private function doubleOrbitalDiagFilingResults(r:OrbitalDiagFilingResults):OrbitalDiagFilingResults
		{
			var o:OrbitalDiagFilingResults = new OrbitalDiagFilingResults();
			o.numFullSubShells = r.numFullSubShells * 2;
			o.numElectronsInLastSubShell = r.numElectronsInLastSubShell * 2;
			o.
		}
		*/
		
		/**
		 * TESTED VIGARIOUSLY! CONFIRMED TO WORK!
		 * takes #inNumFullOrbitals and files them into the correct diagonal on the electron filing sheet.
		 * outputs the stats you need to know from this result.
		 * @param	inNumFullOrbitals :The number of full orbitals.
		 *                             Used to calculate how many sub-shells are being filled.
		 * @param	inUniqueSubShellDiagComboIndex :The unique diagonal-combo-type on the filing chart.
		 *                                          This index is 1-base. And determines the order of the sub-shells used
		 *                                          in filing the electrons.
		 */
		private function fileOrbitalsIntoSubShellDiag(inNumFullOrbitals:int, inUniqueSubShellDiagComboIndex:int):OrbitalDiagFilingResults
		{
			if (inNumFullOrbitals <= 0)
			{
				//rather than error, return data that makes sense:
				var zeroOut:OrbitalDiagFilingResults = new OrbitalDiagFilingResults();
				zeroOut.isFilingDiagFull = false;
				zeroOut.isLastSubShellFull = false;
				zeroOut.numElectronsInLastSubShell = 0;
				zeroOut.numFullSubShells = 0;
				zeroOut.subShellTypeIndexOfLastSubShell = 0; //invalid index because we have no electrons.
				return zeroOut;
			}
			
			if (inUniqueSubShellDiagComboIndex <= 0)
			{
				throw new Error("this value should be 1-based. Value too low.");
				return null;
			}
			
			//step1: Figure out how many sub-shells are at this unique diagonal:
			var numSubShells:int = inUniqueSubShellDiagComboIndex;
			
			// inUniqueSubShellDiagComboIndex ----->>
			// [ ] == a SHELL
			//  #  == number of orbitals in that shell.
			// [#] == a SHELL and the number of orbitals in that shell.
			// example reading:
			// diag index #3 ---> [5]+[3]+[1] shells filled in this order, for a total sum of 9 filled orbitals. Multiply 9*2 to get number of electrons.
			// 1   1   2   2   3 -----> inUniqueSubShellDiagComboIndex ------>
			//[1]/   /   /   /   /
			//  /   /   /   /   / 
			// /   /   /   /   /
			///   /   /   /   /
			//[1]/[3]/   /   /   /
			//  /   /   /   /   / 
			// /   /   /   /   /
			///   /   /   /   /
			//[1]/[3]/[5]/   /   /
			//  /   /   /   /   / 
			// /   /   /   /   /
			///   /   /   /   /
			//[1]/[3]/[ ]/[ ]/   /
			//  /   /   /   /   / 
			// /   /   /   /   /
			///   /   /   /   /
			//[1]/[ ]/[ ]/[ ]/[ ]/
			//  /   /   /   /   / 
			// /   /   /   /   /
			///   /   /   /   /
			
			//the summation changes based on what subshell we start on:
			//numSubShells:      summationStartValue:
			//1  --------------------> 1 orbital_
			//2  --------------------> 3 orbitals
			//3  --------------------> 5 orbitals
			//4  --------------------> 7 orbitals
			//summation start value can also be seen as the number of orbitals in the FIRST sub shell of our filing diagonal.
			
			/** The unique diagonal index we are filing to. Re-mapped to var "f" to make code readable. 
			 *  MINUS ONE to 0-base the nuber. **/
			var f:int = inUniqueSubShellDiagComboIndex - 1;
			
			/** b == MAX element value in the summation. while m == MAXIMUM POSSIBLE SUMMATION TOTAL VALUE.
			 *  Converts 0-based unique diagonal index to the number of orbitals
			 *  making up the FIRST sub-shell within that diagonal.
			 *  inputs for  f: 0, 1, 2, 3, 4,  5,  6
			 *  outputs for b: 1, 3, 5, 7, 9, 11, 12
			 **/
			var b:int = (f * 2) + 1;
			
			/** 
			 * m == maximum possible value of summation.
			 * solving the current summation formula for it's max possible value.
			 *  Example summations for values of "f":
			 * f==0:  1 ---------------------> 1
			 * f==1:  3 + 1 -----------------> 4
			 * f==2:  5 + 3 + 1 -------------> 9
			 * f==3:  7 + 5 + 3 + 1 ---------> 16
			 * f==4:  9 + 7 + 5 + 3 + 1 -----> 25 **/
			var m:int = -(f - b) * (f + 1); //<<m == maximum output value for the summation formula.
			var r:Function = Math.sqrt; //<<R mapped to square root for ease of reading formulas.
			
			
			
			//error check:
			if (inNumFullOrbitals > m)
			{
				var er:String = "";
				er += "The INPUT summation value for how many full orbitals there are is OVER the maximum(m) output calculated";
				er += "This might happen if you are trying to file MORE orbitals than there are shells available in the selected diagonal.";
				er += "You can't do this. You'll get NaN and... it just doens't make sense.";
				throw new Error(er);
				return null;
			}
			
			//summation formula describing how to sum the oribitals:
			//SUMMATION:               //IN TERMS OF N:
			//s = -(n-b)*(n+1)         n = f - r(b-s) ;
			//REAL EXAMPLES:
			//----------------------------------------------------------
			//n range:   |   Summation:                    |  In terms of n:
			//n=0 to 0   |  ∑(1-(i*2)) <--> s=-(n-1)(n+1)  |  n = 0-r( 1 -s);
			//n=0 to 1   |  ∑(3-(i*2)) <--> s=-(n-3)(n+1)  |  n = 1-r( 4 -s);
			//n=0 to 2   |  ∑(5-(i*2)) <--> s=-(n-5)(n+1)  |  n = 2-r( 9 -s);
			//n=0 to 3   |  ∑(7-(i*2)) <--> s=-(n-7)(n+1)  |  n = 3-r( 16-s);
			//----------------------------------------------------------------
			//                                                    ^    ^  //correction: It is "m"!!!
			//                                                    f    m  //b, not m. Because it is the highest number involved in the summation set. NOT the summation max value.
			
		    //what is "s": It is the number of orbitals used:
			//example:
			//filling the first 3 sub-shells of a diagonal on the filing chart:
			//  5+3+1 ---> 9 orbitals.
			//because we started at "5", we must be using THIS formula:
			//n=0 to 2   |   s=-(n-5)(n+1)  |  n = 2-r(9-s);
			//Because this one has a range 0-2 (3 filing slots 0,1,2 within the diagonal)
			//And the expansion of the summation is: 5+3+1 because you start at highest value and work your way down to 1.
			
			/** the value of n is base ZERO **/
			var n1:int = numSubShells - 1;
			
			//what is "n" ?
			//n is the iteration number in the summation.
			//if n == 0, it means "1" full sub-shell.
			//if n == 1, it means "2" full sub-shells.
			//(this is because the summation is 0-based with i=0 being that start of the sigma sum)
			//if s==16, it means, "this number of full ORBITALS are used by this summation."
			
			var out:OrbitalDiagFilingResults = new OrbitalDiagFilingResults();
			
			//we HAVE: 
			// 1: The number of FULL ORBITALS,
			//we WANT: 
			// 1: The number of FULL sub-shells
			// 2: The sub-shell type of the un-filled sub-shell
			// 3: The number of valence electrons left over from NOT filling a sub-shell to it's entirity.
			var s1:int = inNumFullOrbitals; //
		
			/**Which iteration of the summation formula tallying up the number of orbitals used by the sub shells we are on. **/
			var nthIteration:Number = f - r(m - s1);
			var n2:int = Math.floor(nthIteration); //<<Iteration floored to  get only full sub-shells when putting n2 back into summation.
			var n3:int = Math.ceil(nthIteration); //<<iteration cield so we know the last sub shell used. Last shell may or may not be full.
			var numSubShellsCompletelyFilled:int = n2 + 1; //plus-1 because "n" is a 0-based value in our formula.
			var numOrbitalsUsedByFilledSubShells:int = -(n2 - b) * (n2 + 1);
			var numElectronsUsedByFilledSubShells:int = numOrbitalsUsedByFilledSubShells * 2;
			
			/*
			//check to make sure we have not exceeded max output:
			var maxShellCountCheck:int = -(n3 - b) * (n2 + 1);
			if (maxShellCountCheck > m)
			{
				trace("uh oh");
				trace("Plugging ing max nth iteration, I am getting a value OVER the limit.
			}
			*/
			
			////////////////////////////// SUB SHELL TYPE-INDEX of the LAST sub-shell that has any electrons in it//////////////////////
			if (n3 >= inUniqueSubShellDiagComboIndex)
			{
				var e2:String = "";
				e2 += "n3 is a 0-based index for summation formula. It should NEVER be >= inUniqueSubShellDiagComboIndex";
				e2 += "because that means the iteration n3 is FlOWING OFF the filing chart and going into NEGATIVE shell-types";
				throw new Error(e2);
				return null;
			}
			out.subShellTypeIndexOfLastSubShell = inUniqueSubShellDiagComboIndex - n3;
			//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			
			
			if (n2 != n3)
			{  //we have valence electrons:
				out.isLastSubShellFull = false;  //-----higher num----//    //----------lower num-----------//
				out.numElectronsInLastSubShell = (inNumFullOrbitals * 2) - numElectronsUsedByFilledSubShells;
			}
			else
			{   //subShellTypeIndex:  1    2    3    4    5   6
				//num orbitals     :  1    3    5    7    9   11
				//num electrons    :  1    6    10   14   18  22
				out.isLastSubShellFull = true;
				var numOrbitalsInLastShell:int = (out.subShellTypeIndexOfLastSubShell * 2) - 1; //<<subShellTypeIndex is 1-based.
				out.numElectronsInLastSubShell = numOrbitalsInLastShell * 2;
			}
			
			out.numFullSubShells = numSubShellsCompletelyFilled;
			
			//---Determine if this filing diagonal has been completely filled or not: --//
			//////////////////////////////////////////////////////////////////////////////////////////////
			if (out.numFullSubShells == inUniqueSubShellDiagComboIndex)
			{
				out.isFilingDiagFull = true;
			}else
			if (out.numFullSubShells < inUniqueSubShellDiagComboIndex)
			{
				out.isFilingDiagFull = false;
			}
			else
			if (out.numFullSubShells > inUniqueSubShellDiagComboIndex)
			{
				throw new Error("you cannot have more full sub-shells than the unique diag index!!");
			}
			//////////////////////////////////////////////////////////////////////////////////////////////
			
			trace(inUniqueSubShellDiagComboIndex); //debug lines.
		    trace(inNumFullOrbitals); //debug lines.
			return out;
			
			//output helper chart:
			// DIAG#:
			// 1     [1]
			// 2     [1][2][3]  [4]
			// 3     [1][2][3][4][5]  [6][7][8]  [9]
			// 4     [1][2][3][4][5][6][7]  [8][9][10][11][12]  [13][14][15]  [16]
			//       |<-------- f ------>|  |<----  s ------>|  |<-- p --->|    d   //the sub-shells.
			//  ----Index Of Full Orbital---->>>
			
			
		}//fileOrbitalsIntoSubShellDiag
		
		/** CONFIRMED TO WORK AS SAID IN DOCUMENTED EXAMPLE NUMBERS:
		 *  gets the total number of electrons up to and including the inFilingDiagonalNumber specified.
		 *  This is NOT just the number of electrons in a SINGLE diagonal.
		 *  It is the number of electrons in all of the diagonals up to inFilingDiagonal number.
		 *  INCLUDING diagonal inFillingDiagonalNumber **/
		private function getElectronSummationOfFilingDiagonals(inFilingDiagonalNumber:int):int
		{
			
			//example input outputs to expect:
			//[2] == an orbital.
			//[2]                  == sub shell s
			//[2][2][2]            == sub shell p
			//[2][2][2][2][2]      == sub shell d
			//[2][2][2][2][2][2][2]== sub shell d
			//                   S      P              D
			//1 ----> 2         [2]
			//2 ----> 4         [2]
			//3 ----> 12        [2]  [2][2][2]
			//4 ----> 20        [2]  [2][2][2]
			//5 ----> 38        [2]  [2][2][2]   [2][2][2][2][2]   [2][2][2][2][2][2][2]
			//6 ----> 56        [2]  [2][2][2]   [2][2][2][2][2]   [2][2][2][2][2][2][2]
			//7 ----> 88        [2]  [2][2][2]   [2][2][2][2][2]   [2][2][2][2][2][2][2]
			//8 ----> 120       [2]  [2][2][2]   [2][2][2][2][2]   [2][2][2][2][2][2][2]
			//9 ----> 170
			//10 ----> 220
			//INPUT    OUTPUT
			//last line is an input of 10 for an output of 220 electrons total.
			
			
			
			//how many thick columns can you get?
			//remember than each filling diagonal is paired with an identical filing diagonal.
			var thickColumns:int = Math.floor(inFilingDiagonalNumber / 2);
			
			//Find the base electrons from the thick columns:
			var baseElectrons:int = 0;
			if (thickColumns > 0)
			{
				baseElectrons = thickDiagonalIndexToElectronCount(thickColumns);
			}
			else
			{
				baseElectrons = 0;
			}
			
			//do we have anything left over?
			var remainderElectrons:int = 0;
			if ((inFilingDiagonalNumber & 1) == 1)
			{//if we have a 1, this means we had an ODD inFilingDiagonalNumber and it is NOT paired with anything.
				//and we need to see how many electrons is in this FINAL column.
				var finalThickColumnIndex:int;
				var remainderOrbitals:int; //2 electrons per orbital.
				finalThickColumnIndex = thickColumns + 1; //if no thick columns, this value is 1. That is okay.
				remainderOrbitals = subShellDiagComboIndex_to_numOrbitalsInDiag(finalThickColumnIndex);
				remainderElectrons = remainderOrbitals * 2;
			}//odd
			
			var electronSum:int;
			electronSum = baseElectrons + remainderElectrons;
			
			return electronSum;
		}//getElectronSummationOfFilingDiagonals
		
		/** sudo-orbitals because we are assuming that each sub shell is filled one at a time, when that is not the case.
			 * AKA: on the "P" sub shell: 3 electrons and 6 electrons both equate to 3 orbitals.
			 * [*,*] == An orbital.
			 * "*" == an electron.
			 *  subshell: s = [*,*]
			 *  subshell: p = [*,*] [*,*] [*,*]
			 * subshell:  d = [*,*] [*,*] [*,*] [*,*] [*,*]
			 **/
		private function atomicNumberToNumberOfSudoOrbitalsUsed(a:int):int
		{
			return Math.ceil( a / 2);
		}
		
		private function atomicNumberToNumberOfSubShellsUsed(a:int):int
		{
			return 0;
		}
		
		private function numberOfOrbitalPairsToSubShellDiagCombo(inOrbitalPairCount:int):int
		{
			var out:int;
			
			//solving for D, I plugged it into wolfram and got super complex stuff:
			var t:int = inOrbitalPairCount;
			var r:Function = Math.sqrt;
			var R3:Number = r(3);
			var T8:Number = r( (3888 * (t * t)) - 1 );
			var P:Number = ( (R3 * T8) + (108 * t) );
			var P13:Number = Math.pow(P, (1 / 3)); //root 3.
			var r3r:Number = Math.pow(3, (1 / 3) ); //3 root 3. AKA: 3 to the power of 1/3.
			var H1:Number = P13 / ( Math.pow(3, 2 / 3) );
			var H2:Number =  1 /  (r3r * P13);
			var HH:Number = H1 + H2;
			var d:Number = (0.5 * HH) - (3 / 2);
			
			var whole:int = Math.floor(d);
			var rem:Number = d - whole;
			var based0Output:int;
			if (rem < 0.00001)
			{   //rare case, floor it.
				based0Output = whole; 
			}
			else
			{
				based0Output = whole + 1;
			}
			
			out = based0Output + 1;
			
			//trace(t.toString() + "-->" + d.toString() );
			//trace(t.toString() + "-->" + based0Output.toString() );
			//trace(t.toString() + "-->" + out.toString() );
	
			return out;
		}//numberOfOrbitalPairsToSubShellDiagCombo
		
		/** SUB-SHELL-DIAG-COMBO: The number of sub-shells in a given diagonal. 
		 *  will return the HIGHEST subShellDiagCombo occupied.
		 *  subShellDiagCombo == thick-column index.
		 * 
		 *  return 1-based diagCombo value.
		 *  if returns 0, means NONE are being used.
		 * **/
		private function numberOfOrbitalsToSubShellDiagCombo(inOrbitalCount:int):int
		{
			//WE HAVE TESTED THIS FUNCTION A LOT! And we now know that it works correctly.
			/** expected inputs and outputs:
				    0-#->0
					1-#->1
					2-#->1
					3-#->2
					4-#->2
					5-#->2
					6-#->2
					7-#->2
					8-#->2
					9-#->2
					10-#->2
					11-#->3
					12-#->3
					13-#->3
					14-#->3
					15-#->3
					16-#->3
					17-#->3
					18-#->3
					19-#->3
					20-#->3
					21-#->3
					22-#->3
					23-#->3
					24-#->3
					25-#->3
					26-#->3
					27-#->3
					28-#->3
					29-#->4
					30-#->4
					31-#->4
					32-#->4
					33-#->4
					34-#->4
					35-#->4
					36-#->4
					37-#->4
					38-#->4
					39-#->4
					40-#->4
					41-#->4
					42-#->4
					43-#->4
					44-#->4
					45-#->4
					46-#->4
					47-#->4
					48-#->4
					49-#->4
					50-#->4
					51-#->4
					52-#->4
					53-#->4
					54-#->4
					55-#->4
					56-#->4
					57-#->4
					58-#->4
					59-#->4
					60-#->4
					61-#->5
					62-#->5
					63-#->5
					64-#->5
					65-#->5
					66-#->5
					67-#->5
					68-#->5
					69-#->5
					70-#->5
					71-#->5
					72-#->5
					73-#->5
					74-#->5
					75-#->5
					76-#->5
					77-#->5
					78-#->5
					79-#->5
					80-#->5
					81-#->5
					82-#->5
					83-#->5
					84-#->5
					85-#->5
					86-#->5
					87-#->5
					88-#->5
					89-#->5
					90-#->5
					91-#->5
					92-#->5
					93-#->5
					94-#->5
					95-#->5
					96-#->5
					97-#->5
					98-#->5
					99-#->5
					100-#->5
					101-#->5
					102-#->5
					103-#->5
					104-#->5
					105-#->5
					106-#->5
					107-#->5
					108-#->5
					109-#->5
					110-#->5
					111-#->6
					112-#->6
					113-#->6
					114-#->6
					115-#->6
					116-#->6
					117-#->6
					118-#->6
					119-#->6
					120-#->6
					121-#->6
					122-#->6
					123-#->6
					124-#->6
					125-#->6
					126-#->6
					127-#->6
					128-#->6
					129-#->6
					130-#->6
					131-#->6
					132-#->6
					133-#->6
					134-#->6
					135-#->6
					136-#->6
					137-#->6
					138-#->6
					139-#->6
					140-#->6
					**/
			
			if (inOrbitalCount <  0) { throw new Error("orbital count should never be negative.");}
			if (inOrbitalCount == 0) { return 0; } //only case to return 0.
		
			//d = 0-based diagonal-combo index.
			
			//                                             "C"     "T"
			//  d   |   current summation to compound:  |  cur  | total |
			//-----------------------------------------------------------
			//  0   |   1                               |   1   |   1   |
			//  1   |   1,3                             |   4   |   5   |
			//  2   |   1,3,5                           |   9   |   14  |
			//  3   |   1,3,5,7                         |   16  |   30  |
			//  4   |   1,3,5,7,9                       |   25  |   55  |
			//  5   |   1,3,5,7,9,11                    |   36  |   91  |
			//  6   |   1,3,5,7,9,11,13                 |   49  |   140 |
			//------------------------------------------------------------
			
			//    d
			//C = ∑((i*2)+1)  ==  (d+1)^2
			//   i=0
			
			//    d'
			//T = ∑((d+1)^2)  == (1/6)(n+1)(n+2)(2n+3)
			//   d=0
			
			//formula for total number of orbitals for 0-based diag-combo-index supplied:
			//T = (1/6)(d+1)(d+2)(2d+3)
			
			var p:Number;
			
			var hasLonelyOddElectron:Boolean;
			if ((inOrbitalCount & 1) > 0)
			{//odd number
				hasLonelyOddElectron = true;
				p = (inOrbitalCount - 1) * 0.5; //minus 1 before divide.
				p = p + 1; //round up after divide.
			}
			else
			{//even number
				hasLonelyOddElectron = false;
				p = (inOrbitalCount * 0.5);
			}
			
			var out:int = numberOfOrbitalPairsToSubShellDiagCombo( p );
			
			return out;
		
		}//numberOfOrbitalsToSubShellDiagCombo
		
		
		/** Number of SHELLS in a unique diagonal. NOT electrons. **/
		private function getNumSubShellsInAGivenUniqueFilingDiagonal(inFDCombo:int):int
		{
			//pattern:
			//1,2,3,4,5,6,7... Yes.. that simple... But keep it as a function for code readability.
			
			//Yep. That simple. 1:1 Each unique filing diagonal has the same number of sub-shells as it's index.
			return inFDCombo;
		}//rawer
		
		/** 
		 *  an index 0 - INF that represents the diagonals in our filing chart.
		 *  Lets call this index "i".
		 *  Example chart:
		 * input:    output:
		 *   0         0
		 *   1         1
		 *   2         4
		 *   3         16
		 * 
		 * DIAGRAM: of input/output above:
			 * /#/ == Diag-Combo #
			 * It represents the progression of sub-shell combinations.
			 * /1/ == [1] == 1
			 * /2/ == [1]+[3] == 4
			 * /3/ == [1]+[3]+[5] == 16
			 *  /1/ /2/  /3/    /4/
			 *  [1] [1]  [1]    [1]  << s-type subshells hold 1 orbital.
			 *      [3]  [3]    [3]  << p-type subshells hold 3 orbitals.
			 *           [5]    [5]  << d-type subshells hold 5 orbitals.
			                    [7]  << f-type subshells hold 7 oribtals.
								
		 * 
		 * The unique combination of sub-shell types (in filing chart order)
		 *  converted to the number of total orbital to be found. **/
		private function subShellDiagComboIndex_to_numOrbitalsInDiag(inComboIndex:int):int
		{
			//Actual inputs/outputs:
			//in:   //out:
			//1 ----> 1       //1 orbital in the FIRST unique diagonal.
			//2 ----> 4       //4 orbitals in the 2nd unique diagonal. Composed of   [s][p] aka s[2]  p[2][2][2]
			//3 ----> 9       //9 orbitals in the 3rd unique diagonal. Composed of   [s][p][d]  aka s[2]  p[2][2][2] d[2][2][2][2][2]
			//4 ----> 16      ETC.
			//5 ----> 25
			//6 ----> 36
			//7 ----> 49
			//8 ----> 64
			//9 ----> 81
			//10 ----> 100
			
			
			// SIGMA 1+(i*2);
			// i + SIGMA(i*2);
			// i + SIGMA(i) + SIGMA(i);
			// i + 2( SIGMA(i) );
			// i + 2 (   i*(i+1)/2 );
			// i + i*(i+1);
			var i:int;
			var out:int;
			i = inComboIndex -1; //1-base this formula by subtracting 1.
			out = i + (i * (i + 1)) + 1;
			return out;
		}
		
		/** reverse of thickDiagonalIndexToElectronCount
		 * **/
		private function electronCountToThickDiagonalIndex(n:int):int
		{
			var baseThingy:Number;
			var bf:Number;
			var p:Function = Math.pow;
			var r:Function = Math.sqrt;
			 baseThingy=  1.7321 * r(243 * (n*n) - 1 ) + (27*n);
			 bf =  p(baseThingy, 1/3);

			var out:Number;
			out = (0.5 * ((0.48075 * bf) + (0.69336/bf))) - 0.5;
			
			return out;
		}
		
		/**
		 *  This is the number of electrons in the CURRENT thick diagonal
		 *  AND all previous diagonals added together.
		 * @param	n
		 * @return
		 */
		private function thickDiagonalIndexToElectronCount(n:int):int
		{
			//pattern:
			//2+2 = 4 //4 electrons first thick diagonal.
			//8+8 = 16 // 16 electrons in 2nd thick diagona.
			//18+18 = 36
			//32+32=64
			//pattern:
			//   SIGMA (i*2)^2  ===   SIGMA 4(i^2);
			
			//SOLUTION:
			//   2/3n(n+1)(2n+1)
			
			//inputs:    Outputs:
			//   1          4       4 electrons in first thick diagonal.
			//   2          20      16 electrons in 2nd thick diagonal + previous.
			//   3          56      36 electrons in 3rd thick diagonal + previous
			//   4          120     etc
			//   5          220     etc
			//   6          364     etc
			
			var sum:int = 0;
			var flt:Number;
			flt = (2 / 3) * n * (n + 1) * ((2 * n) + 1);
			sum = Math.ceil(flt);
			return sum;
		}
		
		private function f1(k:int):int
		{
			var sum:int;
			sum = 0;
			sum = sum +   k * (k + 1);
			sum = sum * ((2 * k) + 1);
			sum = sum / 6;
			return sum;
		}
		
	}
	
}