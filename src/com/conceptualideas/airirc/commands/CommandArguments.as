package com.conceptualideas.airirc.commands
{

	/**
	 * ...
	 * @author Conceptual Ideas
	 */
	public class CommandArguments
	{

		private var _line:String
		private var words:Array
		public function CommandArguments(line:String)
		{
			words = line.split(" ");
			_line = line;
		}
		public function retrive(index:int):String
		{
			return words[index];
		}

		public function get size():int
		{
			return words.length;
		}
		public function get hasExtraArguments():Boolean
		{
			return words.length > 0;
		}

		public function getArgumentsAsString(start:int=1, end:int=-1):String
		{
			end = end == -1 ? size - 1 : end;
			var regex:RegExp = new RegExp("(\\S+\\s+){" + start + "}((\\S+\\s+){" + Math.max(0, end - start) + "}\\S+(\\s+$)?).*?");
			var matches:Array = _line.match(regex);
			return (matches) ? matches[2] : "";
		}
		public function get line():String
		{
			return _line;
		}

	}

}