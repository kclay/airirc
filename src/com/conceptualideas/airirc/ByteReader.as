package com.conceptualideas.airirc
{
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;

	/**
	 * ...
	 * @author Conceptual Ideas
	 */
	public class ByteReader extends ByteArray
	{

		private static var CLR:ByteArray = new ByteArray();
		{
			CLR.writeUTFBytes("\r\n");
			CLR.position = 0;
		}


		public function ByteReader(source:IDataInput=null)
		{

			super();
			if (source)
			{
				source.readBytes(this, 0, source.bytesAvailable);
				position = 0
			}
		}
		public function get end():Boolean
		{
			return position == length;
		}
		public function readLine():String
		{
			var index:int = indexOf(CLR, position);
			var line:String

			if (index != -1){

				line = readUTFBytes(index - position);
				position += CLR.length;
			}
			return line;



		}

		public function scan(byte:int, offset:int=0):int
		{
			var index:int = -1;
			for (var i:int = offset; i < bytesAvailable; i++)
			{
				if (peek(i) == byte)
				{
					index = i;
					break;
				}
			}

			return index;
		}
		public function indexOfString(string:String):int
		{
			return indexOf(stringToBytes(string));
		}
		public function peek(offset:int):int
		{
			return this[position + offset];
		}
		public function indexOf(pattern:*, fromIndex:int=0):int
		{
			var arr:Array, end:Boolean, found:Boolean, a:int, i:int, j:int, k:int;

			var toFind:ByteArray = toByteArray(pattern);
			if (toFind == null)
			{
				// ** type of pattern unsupported **
				throw new Error("Unsupported Pattern");
				return;
			}

			a = toFind.length;
			j = this.length - a;

			if (fromIndex < 0)
			{
				i = j + fromIndex;
				if (i < 0)
				{
					return -1;
				}
			}
			else
			{
				i = fromIndex;
			}
			while (!end)
			{
				if (this[i] == toFind[0])
				{
					// ** found a possible candidate **
					found = true;
					k = a;
					while (--k)
					{
						if (this[i + k] != toFind[k])
						{
							// ** doesn't match, false candidate **
							found = false;
							break;
						}
					}
					if (found)
					{
						return i;
					}
				}
				if (fromIndex < 0)
				{
					end = (--i < 0);
				}
				else
				{
					end = (++i > j);
				}
			}
			return -1;
		}
		public static function toByteArray(obj:*):ByteArray
		{
			var toFind:ByteArray;
			if (obj is ByteArray)
			{
				toFind = obj;
			}
			else
			{
				toFind = new ByteArray();
				if (obj is Array)
				{
					// ** looking for a sequence of target **
					var i:int = obj.length;
					while (i--)
					{
						toFind[i] = obj[i];
					}
				}
				else if (obj is String)
				{
					// ** looking for a sequence of string characters **
					toFind.writeUTFBytes(obj);
				}
				else
				{
					return null;
				}
			}
			return toFind;
		}
		public function stringToBytes(string:String):ByteArray
		{
			var bytes:ByteArray = new ByteArray();
			bytes.writeUTFBytes(string);
			return bytes;
		}


	}

}