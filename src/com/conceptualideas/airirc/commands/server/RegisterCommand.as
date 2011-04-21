package com.conceptualideas.airirc.commands.server
{
	import com.conceptualideas.airirc.commands.BaseIRCCommand;
	
	import com.conceptualideas.airirc.commands.context.CommandContext;

	/**
	 * ...
	 * @author Conceptual Ideas
	 */
	public class RegisterCommand extends BaseIRCCommand
	{

		public function RegisterCommand()
		{

		}

		override public function get tokens():Array
		{
			return ["register","r"]
		}

		override public function execute(context:CommandContext):void
		{
			var nick:String = context.args.getArgumentsAsString(1, 1);
			var user:String = context.args.getArgumentsAsString(1);
			context.write("NICK " + nick);
			context.write("USER " + user);
			context.dispose();

		}

	}

}