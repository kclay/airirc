package com.conceptualideas.airirc.events
{
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