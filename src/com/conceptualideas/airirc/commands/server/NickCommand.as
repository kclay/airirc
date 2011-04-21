package com.conceptualideas.airirc.commands.server
{
	import com.conceptualideas.airirc.commands.BaseIRCCommand;
	import com.conceptualideas.airirc.commands.context.CommandContext;

	/**
	 * ...
	 * @author Conceptual Ideas
	 */
	public class NickCommand extends BaseIRCCommand
	{

		public function NickCommand()
		{

		}

		override public function execute(context:CommandContext):void
		{
			var nick:String = context.args.getArgumentsAsString(1,1);
			if(nick){
				context.write("NICK " +nick);
				context.dispose();
			}
		}

	}

}