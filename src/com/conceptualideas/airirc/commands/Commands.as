package com.conceptualideas.airirc.commands
{

	/**
	 * ...
	 * @author Conceptual Ideas
	 */
	public class Commands
	{
		public static const TYPE_CHANNEL:int = 1;
		public static const CONNECTED:String = "004";
		public static const CHANNEL_TOPIC:String = "332";
		public static const CHANNEL_USERS_START:String = "353";
		public static const CHANNEL_USERS_END:String = "366";
		public static const PING:String = "PING";
		public static const PRIVMSG:String = "PRIVMSG";
		public static const JOIN:String = "JOIN";
		public static const ERROR:String = "ERROR";
		public static const PART:String = "PART";
		
		public static const KICK:String = "KICK";

		public function Commands()
		{

		}

	}

}