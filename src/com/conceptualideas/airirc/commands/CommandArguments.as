package com.conceptualideas.airirc.commands
{
/**
	 * Copyright (c) <2011> Keyston Clay <http://ihaveinternet.com>
	 *
	 *  Permission is hereby granted, free of charge, to any person obtaining a copy
	 *	of this software and associated documentation files (the "Software"), to deal
	 *	in the Software without restriction, including without limitation the rights
	 *	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	 *	copies of the Software, and to permit persons to whom the Software is
	 *	furnished to do so, subject to the following conditions:
	 *
	 *	The above copyright notice and this permission notice shall be included in
	 *	all copies or substantial portions of the Software.
	 *
	 *	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	 *	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	 *	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	 *	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	 *	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	 *	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
	 *	THE SOFTWARE.
	 */
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