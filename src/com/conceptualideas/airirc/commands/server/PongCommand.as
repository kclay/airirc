package com.conceptualideas.airirc.commands.server
{
	import com.conceptualideas.airirc.commands.BaseIRCCommand;
	
	import com.conceptualideas.airirc.commands.context.CommandContext;



	/**
	 * ...
	 * @author Conceptual Ideas
	 */
	public class PongCommand extends BaseIRCCommand
	{

		public function PongCommand()
		{

		}

		override public function execute(context:CommandContext):void
		{
			context.write("PONG " + context.args.line);
			context.dispose();

		}

	}

}