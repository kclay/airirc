package com.conceptualideas.airirc.commands.server
{
	/**
	 * Copyright (c) <2011> <Conceptual Ideas>
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
	import com.conceptualideas.airirc.commands.BaseIRCCommand;
	import com.conceptualideas.airirc.commands.context.ChannelCommandContext;
	import com.conceptualideas.airirc.commands.context.CommandContext;
	import com.conceptualideas.airirc.responses.ServerResponse;
	import com.conceptualideas.airirc.utils.IRCTools;
	
	public class MessageCommand extends BaseIRCCommand
	{
		public function MessageCommand()
		{
			super();
		}
		override public function get tokens():Array{ return ["msg"]}
		override public function execute(context:CommandContext):void{
			var message:String
			var target:String
			if(context is ChannelCommandContext){
				target = ChannelCommandContext(context).channel.name;					
			}else{
				target = context.args.getArgumentsAsString(1,1);				
			}
			message= context.args.getArgumentsAsString(2);
			if(IRCTools.isValidTarget(target)){
				context.write("PRIVMSG "+target+" :"+message);
				context.dispose();
				if(IRCTools.isChannelName(target)){
					var channel:IRCChannel =IRCTools.getChannelFromContext(context);
					if(channel){
					var response:ServerResponse = ServerResponse.createMessageResponse(
						context.server.info.hostmask,
						target,
						message);
						channel.process(response);
					}
					
				}
			}
		}
	}
}