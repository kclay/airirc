package com.conceptualideas.airirc.events
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
	import com.conceptualideas.airirc.responses.ServerResponse;
	import com.conceptualideas.airirc.utils.IRCTools;
	
	import flash.events.Event;

	/**
	 * ...
	 * @author Conceptual Ideas
	 */
	public class ChannelEvent extends Event
	{

		public static const STATUS:String = "status";

		public static const JOIN:String = "CHANNEL_JOIN";
		public static const PART:String = "CHANNEL_PART";
		public static const KICK:String = "CHANNEL_KICK";
		public static const PRIVMSG:String="CHANNEL_PRIVMSG";


		private var _info:String
		private var _response:ServerResponse
		public function ChannelEvent(info:String, response:ServerResponse=null)
		{
			super(STATUS, bubbles, cancelable);
			_info = info;
			_response = response;
			

		}

		public override function clone():Event
		{
			return new ChannelEvent(type, response);
		}

		public override function toString():String
		{
			return formatToString("ChannelEvent", "type", "bubbles", "cancelable", "eventPhase");
		}

		public function get channel():String
		{
			if(IRCTools.isChannelName(response.channel)){
				return _response.channel;
			}else if(IRCTools.isChannelName(response.params)){
				return _response.params;
			}
			return null;
		}

		public function get info():String
		{
			return _info;
		}

		public function get response():ServerResponse
		{
			return _response;}

	}

}