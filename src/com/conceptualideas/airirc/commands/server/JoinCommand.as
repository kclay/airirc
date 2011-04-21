package com.conceptualideas.airirc.commands.server
{
	import com.conceptualideas.airirc.commands.BaseIRCCommand;

	import com.conceptualideas.airirc.commands.context.CommandContext;


	/**
	 * ...
	 * @author Conceptual Ideas
	 */
	public class JoinCommand extends BaseIRCCommand
	{

		public function JoinCommand()
		{

		}

		override public function get tokens():Array
		{
			return ["join", "j"];
		}
		override public function execute(context:CommandContext):void
		{
			var line:String = context.args.getArgumentsAsString(1);
			context.write("JOIN " + line);
			context.dispose();

		}

	}

}