package com.conceptualideas.airirc.commands.server
{
	/**
	 * Copyright (c) <2011> <Conceptual Ideas>
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
	import com.conceptualideas.airirc.commands.BaseIRCCommand;
	
	import com.conceptualideas.airirc.commands.context.CommandContext;

	/**
	 * ...
	 * @author Conceptual Ideas
	 */
	public class RegisterCommand extends BaseIRCCommand
	{

		public function RegisterCommand()
		{

		}

		override public function get tokens():Array
		{
			return ["register","r"]
		}

		override public function execute(context:CommandContext):void
		{
			var nick:String = context.args.getArgumentsAsString(1, 1);
			var user:String = context.args.getArgumentsAsString(1);
			context.write("NICK " + nick);
			context.write("USER " + user);
			context.dispose();

		}

	}

}