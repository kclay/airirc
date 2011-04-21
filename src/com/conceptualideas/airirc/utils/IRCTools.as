package com.conceptualideas.airirc.utils
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