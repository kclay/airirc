package com.conceptualideas.airirc
{
	/**
	 * Copyright (c) <2011> Keyston Clay <http://ihaveinternet.com>
	 *
	 *  Permission is hereby granted, free of charge, to any person obtaining a copy
	 *	of this software and associated documentation files (the "Software"), to deal
	 *	in the Software without restriction, including without limitation the rights
	 *	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	 *	copies of the Software, and to permit persons to whom the Software is
	 *	furnished to do so, subject to the following conditions:
	 *
	 *	The above copyright notice and this permission notice shall be included in
	 *	all copies or substantial portions of the Software.
	 *
	 *	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	 *	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	 *	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	 *	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	 *	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	 *	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
	 *	THE SOFTWARE.
	 */
	import com.conceptualideas.airirc.channel.ChannelInfo;
	import com.conceptualideas.airirc.commands.Commands;
	import com.conceptualideas.airirc.commands.context.ChannelCommandContext;
	import com.conceptualideas.airirc.commands.context.CommandContext;
	import com.conceptualideas.airirc.events.ChannelEvent;
	import com.conceptualideas.airirc.responses.ServerResponse;
	
	import flash.events.EventDispatcher;

	/**
	 * ...
	 * @author Conceptual Ideas
	 */
	public class IRCChannel extends EventDispatcher
	{

		private var _title:String
		private var _users:Array
		private var _name:String
		private var _info:ChannelInfo
		private var server:AirIRC
		public function IRCChannel(server:AirIRC, name:String)
		{
			this.server = server;
			_info = new ChannelInfo(name);


		}


		public function get info():ChannelInfo
		{
			return _info;
		}
		public function get title():String
		{
			return _title;
		}

		public function set title(value:String):void
		{
			_title = value;
		}


		public function get users():Object
		{
			return _users;
		}



		public function get name():String
		{
			return _info.name;
		}
		public function process(response:ServerResponse):void
		{
			switch (response.command)
			{
				case Commands.CHANNEL_TOPIC:
					_title = response.params;
					// todo dispatch event
					break;
				case Commands.CHANNEL_USERS_START:
					processUsers(response.params, true);
					break;
				case Commands.PRIVMSG:
					dispatchEvent(new ChannelEvent(ChannelEvent.PRIVMSG,response));
					break;

			}
		}
		

		private function processUsers(users:String, replace:Boolean=false):void
		{
			trace("Users", users);
			var names:Array = users.split(" ");
			var name:String
			const collection:Array = replace ? [] : _users;
			for each (name in names){
				collection.push(new IRCNick(name));
			}
			_users = collection;
			trace("User Count", _users.length);


		}

		public function part():void
		{
			invoke("part");
			// TODO: dispatch part event
		}
		public function names():void
		{
			invoke("names");
		}

		public function send(message:String):void{
			if(message.charAt(0) =="/"){
				raw(message);
			}else{
				invoke("msg",message);
				
			}
		}
		
		public function raw(command:String):void{
			server.executeCommand(
				server.createChannelCommandContext(this,command)
				);
		}
		public function kick(user:String, comment:String=""):Boolean
		{
			invoke("kick", user + " " + comment);
			// TODO : do channel checking to see if they are an op or voice
			return true;
		}
		final protected function invoke(command:String, extra:String="",raw:Boolean=false):void
		{
			var line:String = command + " " + name + (extra ? " " + extra : "");
		
			if(!raw){
				line="/"+line;
			}
			var context:CommandContext = server.createChannelCommandContext(this,
				line);

			server.executeCommand(context);
		}

		public function destroy():void
		{

		}

		override public function toString():String
		{
			return "[IRCChannel name=" + name + "]";
		}


	}

}