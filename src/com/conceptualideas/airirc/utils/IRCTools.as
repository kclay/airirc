package com.conceptualideas.airirc.utils
{
	import com.conceptualideas.airirc.IRCChannel;
	import com.conceptualideas.airirc.commands.context.ChannelCommandContext;
	import com.conceptualideas.airirc.commands.context.CommandContext;

	/**
	 * ...
	 * @author Conceptual Ideas
	 */
	public class IRCTools
	{
		public static const CHANNEL_REGEX:RegExp = /^[#&\S]+$/
		

		public static const RESPONSE_REGEX:RegExp = new RegExp(
			":?((?P<nick>[\\S]+)!(?P<user>[\\S]+)@(?P<host>[\\S]+) )?"+
			"((?P<channel>[#$]{1}[\\S]+) )?"+
			"((?P<command>[\\S]+) )"+
			"((?<to>[\\S]+) )?"+
			"((?<target>[\\S]+) )?"+
			"(?<target_host>[^:]+)?"+
			":?(?<params>.*)"
			
				);
		public function IRCTools()
		{

		}

		public static function getChannelFromContext(context:CommandContext, index:int=-1):IRCChannel
		{
			return context is ChannelCommandContext ? ChannelCommandContext(context).channel :
				context.server.getChannelByName(context.args.getArgumentsAsString(index));
		}
		public static function isChannelName(name:String):Boolean
		{
			return CHANNEL_REGEX.test(name);
		}
		public static function isValidTarget(target:String):Boolean{
			return true ;
		}

	}

}