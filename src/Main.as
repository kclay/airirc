package
{
	import com.conceptualideas.airirc.AirIRC;
	import com.conceptualideas.airirc.ConnectionInfo;
	import com.conceptualideas.airirc.events.AirIRCEvent;
	import com.conceptualideas.airirc.responses.ServerResponse;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;

	/**
	 * ...
	 * @author Conceptual Ideas
	 */
	public class Main extends Sprite
	{

		private var irc:AirIRC
		public function Main():void
		{
			irc = new AirIRC();
			irc.addEventListener(AirIRCEvent.CONNECTED_TO_SERVER, onConnectedToServer);
			var info:ConnectionInfo  = new ConnectionInfo();
			info.host = "chat.freenode.net";
			info.port = 6667;
			info.nick = "airirc";

			irc.connect(info);




		}

		private function onConnectedToServer(e:AirIRCEvent):void
		{
			trace("CONNECT");
			irc.invoke("/join #playbook-dev");

		}

	}

}