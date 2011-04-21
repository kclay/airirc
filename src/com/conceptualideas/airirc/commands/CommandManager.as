package com.conceptualideas.airirc.commands
{
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