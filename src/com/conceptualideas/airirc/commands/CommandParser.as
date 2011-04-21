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
	import com.conceptualideas.airirc.AirIRC;
	import com.conceptualideas.airirc.commands.context.CommandContext;
	import com.conceptualideas.airirc.commands.server.PongCommand;
	import com.conceptualideas.airirc.commands.server.QuoteCommand;
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

			trace(response.command)
			//trace("Command ", ":" + response.line + ":");
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
			if (!parsedData){
				parsedData = resolveWildCardResponses(response);
			}
			return parsedData;

		}

		private function resolveWildCardResponses(response:ServerResponse):Object
		{
			if (response.params.indexOf("/QUOTE PASS") !=-1){
				return new QuoteCommand(response);
			}
			return null;

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