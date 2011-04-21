package com.conceptualideas.airirc.commands.server
{
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