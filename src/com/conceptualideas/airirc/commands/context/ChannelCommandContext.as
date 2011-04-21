package com.conceptualideas.airirc.commands.context
{
	import com.conceptualideas.airirc.AirIRC;
	import com.conceptualideas.airirc.IRCChannel;
	
	import flash.net.Socket;

	/**
	 * ...
	 * @author Conceptual Ideas
	 */
	public class ChannelCommandContext extends CommandContext
	{

		private var _channel:IRCChannel
		
		public function ChannelCommandContext(channel:IRCChannel,server:AirIRC, socket:Socket, line:String)
		{
			super(server,socket, line);
			_channel = channel;
		}

		public function get channel():IRCChannel
		{
			return _channel;
		}

		public function get channelName():String
		{
			return _channel.name
		}
	/*	public static function convert(channelName:String, context:CommandContext):ChannelCommandContext
	   {
	   return new ChannelCommandContext(channelName, context.server, context.socket, context.args.line);

	 }*/

	}

}