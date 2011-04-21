package com.conceptualideas.airirc.commands.server
{
	import com.conceptualideas.airirc.commands.BaseIRCCommand;
	import com.conceptualideas.airirc.commands.context.CommandContext;
	
	public class NoticeCommand extends BaseIRCCommand
	{
		public function NoticeCommand()
		{
			super();
		}
		override public function get tokens():Array{return ["notice"]}
		
		override public function execute(context:CommandContext):void{
			var target:String = context.args.getArgumentsAsString(1,1);
			var message:String=context.args.getArgumentsAsString(2);
			if(target && message){
				context.write("NOTICE "+target+" :"+message);
				context.dispose();
			}
		}
	}
}