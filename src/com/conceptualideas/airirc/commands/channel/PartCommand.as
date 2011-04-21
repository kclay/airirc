package com.conceptualideas.airirc.commands.channel
{
	import com.conceptualideas.airirc.commands.BaseIRCCommand;
	import com.conceptualideas.airirc.commands.CommandContext;
	import com.conceptualideas.airirc.commands.context.ChannelCommandContext;
	import com.conceptualideas.airirc.commands.context.CommandContext;
	import com.conceptualideas.airirc.IRCChannel;

	/**
	 * ...
	 * @author Conceptual Ideas
	 */
	public class PartCommand extends BaseIRCCommand
	{

		public function PartCommand()
		{

		}

		override public function get tokens():Array
		{
			return ["part"]; 
		}
		override public function execute(context:CommandContext):void
		{
			var channelContext:ChannelCommandContext = ChannelCommandContext(context);
			var channelNames:Array = channelContext.args.getArgumentsAsString(1);
			channelContext.write("PART " + channelNames);
			channelContext.dispose();

		}

	}

}