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
	import com.conceptualideas.airirc.commands.context.ChannelCommandContext;
	import com.conceptualideas.airirc.commands.context.CommandContext;
	import com.conceptualideas.airirc.commands.server.AwayCommand;
	import com.conceptualideas.airirc.commands.server.JoinCommand;
	import com.conceptualideas.airirc.commands.server.MessageCommand;
	import com.conceptualideas.airirc.commands.server.NickCommand;
	import com.conceptualideas.airirc.commands.server.RegisterCommand;

	/**
	 * ...
	 * @author Conceptual Ideas
	 */
	public class CommandManager
	{

		private var commands:Object = {};
		static private var _instance:CommandManager;
		public function CommandManager()
		{
			init();
		}

		private function init():void
		{
			registerCommand(new JoinCommand());
			registerCommand(new NickCommand());
			registerCommand(new RegisterCommand())
			registerCommand(new MessageCommand());
			registerCommand(new AwayCommand());
			
		}

		public static function getInstance():CommandManager
		{
			if (!_instance)_instance = new CommandManager();
			return _instance;
		}

		public function getCommandByToken(token:String):BaseIRCCommand
		{
			if (token.charAt(0) == "/")
				token = token.substr(1);

			return commands[token];
		}
		public function registerCommand(command:BaseIRCCommand):void
		{

			var tokens:Array = command.tokens;
			var token:String
			for each (token in tokens){
				commands[token] = command;
			}
		}
		public function finalizeCommandContext(command:BaseIRCCommand, context:CommandContext):CommandContext
		{
			/*if (command.type == Commands.TYPE_CHANNEL && !(context is ChannelCommandContext)){
				context = ChannelCommandContext.convert(context);
			}*/

			return context;

		}

	}

}