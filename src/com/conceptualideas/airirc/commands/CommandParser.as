package com.conceptualideas.airirc.commands
{
	import com.conceptualideas.airirc.AirIRC;
	import com.conceptualideas.airirc.commands.context.CommandContext;
	import com.conceptualideas.airirc.commands.server.PongCommand;
	import com.conceptualideas.airirc.commands.server.RawServerCommand;
	import com.conceptualideas.airirc.events.AirIRCEvent;
	import com.conceptualideas.airirc.events.ChannelEvent;
	import com.conceptualideas.airirc.IRCChannel;
	import com.conceptualideas.airirc.responses.ServerResponse;



	/**
	 * ...
	 * @author Conceptual Ideas
	 */
	public class CommandParser
	{


		private static const commandManager:CommandManager = CommandManager.getInstance();
		private var server:AirIRC



		public function CommandParser(server:AirIRC)
		{
			this.server = server;

		}



		public function handle(response:ServerResponse):Object
		{
			var parsedData:Object


			trace("Command ",":"+response.line+":");
			switch (response.command){
				case Commands.ERROR:
					parsedData = response.params;
					break;
				case Commands.CONNECTED:
					parsedData = new AirIRCEvent(AirIRCEvent.CONNECTED_TO_SERVER);
					break;
				case Commands.PING:
					parsedData = new PongCommand();
					break;
				case Commands.PART:
				case Commands.JOIN:
				case Commands.KICK:
					parsedData = new ChannelEvent("CHANNEL_" + response.command, response);
					break;

				case Commands.CHANNEL_TOPIC:
				case Commands.CHANNEL_USERS_START:
				case Commands.PRIVMSG:

					var channel:IRCChannel = server.getChannelByName(response.channel);

					if (channel){

						channel.process(response);
					}
					break;
			}
			return parsedData;

		}
		public function executeCommand(context:CommandContext):void
		{
			var args:CommandArguments = context.args;
			var isAction:Boolean = args.size && args.retrive(0).charAt(0) == "/" ? true : false;
			var command:BaseIRCCommand;

			if (isAction){


				command = commandManager.getCommandByToken(args.retrive(0));
				if (!command)return;
			}
			if (!command){
				command = new RawServerCommand();
			}
			//	context = commandManager.finalizeCommandContext(command, context)

			command.execute(context);
		}

	}

}