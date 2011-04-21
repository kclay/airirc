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
	import com.conceptualideas.airirc.ConnectionInfo;
	import com.conceptualideas.airirc.IRCChannel;
	import com.conceptualideas.airirc.commands.BaseIRCCommand;
	import com.conceptualideas.airirc.commands.CommandParser;
	import com.conceptualideas.airirc.commands.context.ChannelCommandContext;
	import com.conceptualideas.airirc.commands.context.CommandContext;
	import com.conceptualideas.airirc.events.AirIRCEvent;
	import com.conceptualideas.airirc.events.ChannelEvent;
	import com.conceptualideas.airirc.responses.ServerResponse;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.Socket;
	import flash.utils.Dictionary;



	/**
	 * ...
	 * @author Conceptual Ideas
	 */
	[Event(name="connectedToServer",type="com.conceptualideas.airirc.events.AirIRCEvent")]
	[Event(name="connectedToSocket",type="com.conceptualideas.airirc.events.AirIRCEvent")]
	[Event(name = "status", type = "com.conceptualideas.airirc.events.ChannelEvent")]
	
	public class AirIRC extends EventDispatcher
	{

		private var _socket:Socket

		private var buffer:ByteReader

		private var acceptableResponses:Object = {};
		private var commands:Object = {};

		private var parser:CommandParser

		private var _host:String
		public function AirIRC()
		{
			init();

		}

		private function init():void
		{
			parser = new CommandParser(this);


		}

		private function handleEvent(e:Event):void
		{
			if (e is ChannelEvent){
				handleChannelEvents(ChannelEvent(e));
			}else {
				dispatchEvent(e);
			}


		}
		private function handleChannelEvents(e:ChannelEvent):void
		{


			var channel:String = e.channel;
			switch (e.info)
			{
				case ChannelEvent.JOIN:
					if (!_channels[channel]){
						_channels[channel] = new IRCChannel(this, channel);
						info.hostmask = response.hostmask;
					}


					break;
				case ChannelEvent.PART:
					_channels[e.channel].destory();
					delete _channels[e.channel];
					break;

			}
			dispatchEvent(e);

		}





		public function connect(info:ConnectionInfo):void
		{
			if (!_socket){
				_socket = new Socket();

				_socket.addEventListener(Event.CONNECT, socketConnectHandler);
				_socket.addEventListener(IOErrorEvent.IO_ERROR, socketIOHandler);
				_socket.addEventListener(ProgressEvent.SOCKET_DATA, socketDataHandler);

			}
			this._info = info;

			_socket.connect(info.host, info.port);

		}

		private function socketDataHandler(e:ProgressEvent):void
		{
			if (!buffer){
				buffer = new ByteReader(_socket);
			} else{
				_socket.readBytes(buffer, buffer.position, _socket.bytesAvailable);
			}

			process();
		}


		private var _channels:Dictionary = new Dictionary();
		private var response:ServerResponse = new ServerResponse();
		private var _info:ConnectionInfo;
		public function get info():ConnectionInfo
		{
			return _info;
		}
		private function process():void
		{
			var line:String



			var parserReturn:Object
			var channel:IRCChannel

			while (!buffer.end && (line = buffer.readLine()) != null){


				trace(line);
				response.parse(line);
				parserReturn = parser.handle(response);

				if (parserReturn == "Reconnecting too fast, throttled."){
					//TODO: reconnect after 30 seconds
				}
				if (parserReturn is Event){
					handleEvent(Event(parserReturn));
				} else if (parserReturn is BaseIRCCommand){

					BaseIRCCommand(parserReturn).execute(
						new CommandContext(this, _socket, response.params)
						);
				}
				onResponse(response);


			}

		}

		public var onResponseCallback:Function
		private function onResponse(response:ServerResponse):void
		{
			if (onResponseCallback != null){
				onResponseCallback(response);
			} else{
			//	trace(response);
			}
		}
		public function getChannelByName(name:String):IRCChannel
		{
			return _channels[name];
		}

		private function socketIOHandler(e:IOErrorEvent):void
		{
			trace(e);

		}

		public function invoke(line:String):void
		{

			executeCommand(createCommandContext(line.replace(/^\s+|\s+$/gs, "")));
		}
		public function executeCommand(context:CommandContext):void
		{
			parser.executeCommand(context);
		}


		private function socketConnectHandler(e:Event):void
		{

			dispatchEvent(new Event(Event.CONNECT));

			invoke("/r " + info.nick + " \"\" \"" + info.host + "\" :" + info.realname);




		}
		public function disconnect(reason:String):void
		{
			executeCommand(createCommandContext("QUIT" + (reason ? " :" + reason : "")));


		}
		internal function createCommandContext(line:String):CommandContext
		{
			return new CommandContext(this, _socket, line);
		}
		internal function createChannelCommandContext(channel:IRCChannel, line:String):ChannelCommandContext
		{
			return new ChannelCommandContext(channel, this, _socket, line);
		}


	}
}