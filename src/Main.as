package
{
	import com.conceptualideas.airirc.AirIRC;
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
			irc.connect("irc.choopa.net", 6667);
		
			


		}

		private function onConnectedToServer(e:AirIRCEvent):void
		{
			irc.invoke("/join #airirc");

		}

	}

}