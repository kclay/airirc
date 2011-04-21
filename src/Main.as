package
{
	import com.conceptualideas.airirc.AirIRC;
	import com.conceptualideas.airirc.ConnectionInfo;
	import com.conceptualideas.airirc.events.AirIRCEvent;
	import com.conceptualideas.airirc.events.ChannelEvent;
	import com.conceptualideas.airirc.IRCChannel;
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
			irc.addEventListener(ChannelEvent.STATUS, channelStatusHandler, false, 0, true);
			var info:ConnectionInfo  = new ConnectionInfo();
			info.host = "irc.efnet.net"
			info.port = 6667;
			info.nick = "airirc";

			irc.connect(info);




		}

		private function channelStatusHandler(e:ChannelEvent):void
		{
			if (e.info == ChannelEvent.JOIN){
				var channel:IRCChannel = irc.getChannelByName(e.channel);
				channel.send("Testing from AirIRC an Adobe Air IRC library.");
			}
		}

		private function onConnectedToServer(e:AirIRCEvent):void
		{
			trace("CONNECT");
			irc.invoke("/join #actionscript");


		}

	}

}