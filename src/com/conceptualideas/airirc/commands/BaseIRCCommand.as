package com.conceptualideas.airirc.commands
{
	import com.conceptualideas.airirc.commands.context.CommandContext;
	import flash.net.Socket;

	/**
	 * ...
	 * @author Conceptual Ideas
	 */
	public class BaseIRCCommand
	{
		public static const CLR:String = "\r\n";


		public function BaseIRCCommand()
		{

		}

		/**
		 * Executes a giving command
		 * @param	context
		 */
		public function execute(context:CommandContext):void
		{


		}

		/**
		 * Tokens to register with the <code>CommandManager</code>
		 */
		public function get tokens():Array
		{
			return [];
		}

		public function valid(line:String):Boolean
		{
			return false;
		}

	}

}