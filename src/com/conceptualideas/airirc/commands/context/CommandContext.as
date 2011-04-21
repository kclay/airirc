package com.conceptualideas.airirc.commands.context
{
	import com.conceptualideas.airirc.AirIRC;
	import com.conceptualideas.airirc.commands.CommandArguments;
	import flash.net.Socket;

	/**
	 * ...
	 * @author Conceptual Ideas
	 */
	public class CommandContext
	{
		private static const CLR:String = "\r\n";

		protected var socket:Socket
		protected var _args:CommandArguments
		private var _server:AirIRC

		public function CommandContext(server:AirIRC, socket:Socket, line:String)
		{
			this.socket = socket;
			_server = server;

			_args = new CommandArguments(line);
		}

		/**
		 * Returns command arguments
		 */
		public function get args():CommandArguments
		{
			return _args;
		}

		public function get server():AirIRC
		{
			return _server;}



		/**
		 * Writes a given command line to the socket, this line will be appended
		 * with CLR
		 * @param	line
		 */
		public function write(line:String):void
		{
			socket.writeUTFBytes(line + CLR);
		}
		/**
		 * This method will call <code>socket.flush()</code> sending the buffer
		 * to the server
		 */
		public function dispose():void
		{
			socket.flush();
		}
		


	}

}