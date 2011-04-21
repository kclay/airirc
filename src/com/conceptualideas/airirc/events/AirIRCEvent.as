package com.conceptualideas.airirc.events
{
	import flash.events.Event;

	/**
	 * ...
	 * @author Conceptual Ideas
	 */
	public class AirIRCEvent extends Event
	{

		public static const CONNECTED_TO_SERVER:String = "connectedToServer"
		public static const CONNECTED_TO_SOCKET:String = "connectedToSocket"

		public function AirIRCEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);

		}

		public override function clone():Event
		{
			return new AirIRCEvent(type, bubbles, cancelable);
		}

		public override function toString():String
		{
			return formatToString("AirIRCEvent", "type", "bubbles", "cancelable", "eventPhase");
		}

	}

}