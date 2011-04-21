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
	import com.conceptualideas.airirc.commands.context.CommandContext;
	import flash.net.Socket;

	/**
	 * ...
	 * @author Conceptual Ideas
	 */
	public class BaseIRCCommand
	{
		public static const CLR:String = "\r\n";


		public function BaseIRCCommand()
		{

		}

		/**
		 * Executes a giving command
		 * @param	context
		 */
		public function execute(context:CommandContext):void
		{


		}

		/**
		 * Tokens to register with the <code>CommandManager</code>
		 */
		public function get tokens():Array
		{
			return [];
		}

		public function valid(line:String):Boolean
		{
			return false;
		}

	}

}