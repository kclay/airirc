package com.conceptualideas.airirc
{

	/**
	 * ...
	 * @author Conceptual Ideas
	 */
	public class IRCNick
	{

		public static const MODE_OP:int = 1;
		public static const MODE_VOICE:int  = 2;
		public static const MODE_NORMAL:int = 3;

		private var _raw:String
		private var _mode:int
		private var _name:String
		public function IRCNick(raw:String)
		{
			_raw = raw;
			parse();
		}

		private function parse():void
		{

		}



		public function get raw():String
		{
			return _raw;}

		public function get name():String
		{
			return _name;}

		public function get mode():int
		{
			return _mode;}

	}

}