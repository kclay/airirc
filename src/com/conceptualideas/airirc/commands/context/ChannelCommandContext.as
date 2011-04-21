package com.conceptualideas.airirc.commands.context
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