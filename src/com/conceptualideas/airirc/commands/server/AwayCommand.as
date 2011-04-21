package com.conceptualideas.airirc.commands.server
{
	import com.conceptualideas.airirc.commands.BaseIRCCommand;
	import com.conceptualideas.airirc.commands.context.CommandContext;
	
	public class AwayCommand extends BaseIRCCommand
	{
		public function AwayCommand()
		{
			super();
		}
		override public function get tokens():Array{ return ["a","away"]}
		
		override public function execute(context:CommandContext):void{
			
			var reason:String = context.args.getArgumentsAsString();
			if(reason){
				context.write("AWAY :"+reason);
				
			}else{
				context.write("AWAY");
			}
			context.dispose();
		}
	}
}