package com.conceptualideas.airirc.commands.server
{
	import com.conceptualideas.airirc.commands.BaseIRCCommand;
	import com.conceptualideas.airirc.commands.context.CommandContext;
	
	public class DisconnectCommand extends BaseIRCCommand
	{
		public function DisconnectCommand()
		{
			super();
		}
		override public function get tokens():Array{return ["disconnect"]};
		
		override public function execute(context:CommandContext):void{
			
			var reason:String = context.args.getArgumentsAsString();
			context.server.disconnect(reason);
			
			
		}
	}
}