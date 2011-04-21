package com.conceptualideas.airirc.responses
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
	import com.conceptualideas.airirc.commands.Commands;
	import com.conceptualideas.airirc.utils.IRCTools;

	/**
	 * ...
	 * @author Conceptual Ideas
	 */
	public class ServerResponse
	{
		public static const MESSAGE:String = "message";
		public static const PREFIX:String = "prefix";
		public static const COMMAND:String = "command";
		public static const PARAMS:String = "params";
		public static const CHANNEL:String = "channel";
		public static const TARGET:String = "target";
		public static const RAW:String="raw";
		


		private static const cachedServerResponse:ServerResponse= new ServerResponse();
		private var components:Object = { };
		
		public static function createMessageResponse(nick:String,target:String,message:String):ServerResponse{
			var line:String=":"+nick+" PRIVMSG "+target+" :"+message;
			cachedServerResponse.parse(line);
			return cachedServerResponse;
			
		}
		public function ServerResponse()
		{

		}

		private var _matches:Object
		private var _line:String
		
		public function parse(line:String):void{
			var regex:RegExp = IRCTools.RESPONSE_REGEX;
			_line = line;
			
			_matches = IRCTools.RESPONSE_REGEX.exec(line);
			
		}
		/*public function parse(line:String):void
		{
			components = {raw:line};
			
			var index:int
			var cut:Function = function():String
			{

				var end:Number = space();
				var tmp:String = end == -1 ? line.substr(index) : line.substr(index, end - index);
				index += tmp.length;
				return tmp;
			}
			var isParams:Function = function():Boolean
			{
				return line.charAt(index) == ":";
			}
			var space:Function = function():int
			{
				return line.indexOf(" ", index);
			}
			var params:Function = function():void
			{
				var test:Number = line.indexOf(":", index);
				if (test != -1){
					index = test + 1;
				}


			}
			var skip:Function = function():void
			{
				while (line.charAt(index).match(/ |\*|=/)){
					index++;
				}
			}
			var isChannel:Function = function():Boolean
			{
				return IRCTools.isChannelName(line.charAt(index));
			}
			var channel:Function = function():String
			{
				return cut().replace(IRCTools.CHANNEL_REGEX, "");
			}

			if (line.charAt(0) == ":"){
				index++;
				components[PREFIX] = cut();

			}
			skip();
			components[COMMAND] = cut();



			skip();

			// check for <target>
			if (!isParams()){
				if (!isChannel()){
					components[TARGET] = cut();
				}
				skip();
				if (isChannel()){ // channel

					components[CHANNEL] = channel()

				}
			}

			params();
			if (isChannel()){
				components[CHANNEL] = channel();
			}

			components[PARAMS] = line.substr(index);
		}*/
		public function get command():String{
			return fetch("command");
		}
		public function get nick():String{
			return fetch("nick");
		}
		public function get user():String{
			return fetch("user");
		}
		public function get host():String{
			return fetch("host");
		}
		public function get to():String{
			return fetch("to");
		}
		public function get target_host():String{
			return fetch("target_host");
		}
		public function get target():String
		{
			return fetch("target");
		}
		public function get params():String
		{
			return fetch("params");
		}
		public function get channel():String
		{
			const isChannel:Function = IRCTools.isChannelName;
			if(isChannel(fetch("channel"))){
				return fetch("channel");
			}else if(isChannel(to)){
				return to;
			}else if(isChannel(target)){
				return target;
			}else if(isChannel(params)){
				return params;
			}
				return "";
		}
		public function get line():String{
			return _line;
		}
		private function fetch(...keys):String{
			var key:String
			for each(key in keys){
				if(_matches.hasOwnProperty(key))
					return _matches[key];
			}
			return null;
		}
		
		public function get hostmask():String{
			return nick+"!"+user+"@"+host;
			
		}
		
		public function toString():String{
			var fields:Array =["nick","user","host","channel","command","to","target","params"];
			var field:String 
			var info:Array=["[ServerResponse"];
			for each(field in fields){
				info.push(field+"="+this[field]);
			}
			
			return info.join(" , ")+" ]";
				
		}

	}

}