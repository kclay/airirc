package com.conceptualideas.airirc.commands.server
{
	import com.conceptualideas.airirc.commands.BaseIRCCommand;
	import com.conceptualideas.airirc.commands.context.CommandContext;

	/**
	 * ...
	 * @author Conceptual Ideas
	 */
	public class RawServerCommand extends BaseIRCCommand
	{

		public function RawServerCommand()
		{

		}

		override public function execute(context:CommandContext):void
		{
			context.write(context.args.line);
			context.dispose();
		}

	}

}