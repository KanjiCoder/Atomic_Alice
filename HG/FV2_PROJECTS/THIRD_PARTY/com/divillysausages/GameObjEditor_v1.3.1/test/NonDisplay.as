package  
{
	/**
	 * A generic class to test the non-display object editing ability of the Editor.
	 * @author Damian
	 */
	public class NonDisplay
	{
		private var m_someBool:Boolean = false; // some value to change
		
		// this will take the generic checkbox edit component
		[Editable]
		public function get someBool():Boolean { return this.m_someBool; }
		public function set someBool( b:Boolean ):void
		{
			this.m_someBool = b;
			trace( "My some bool value is " + this.m_someBool );
		}
		
	}

}