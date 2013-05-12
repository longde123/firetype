package de.maxdidit.hardware.text 
{
	import de.maxdidit.hardware.font.HardwareFont;
	import de.maxdidit.hardware.font.triangulation.EarClippingTriangulator;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class HardwareText extends TransformedInstance
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _cache:HardwareCharacterCache;
		private var _text:String;
		
		private var _fixedWidth:Boolean;
		private var _width:Number;
		private var _height:Number;
		private var _standardFormat:HardwareFontFormat;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HardwareText(cache:HardwareCharacterCache) 
		{
			this._cache = cache;
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get cache():HardwareCharacterCache 
		{
			return _cache;
		}
		
		public function set cache(value:HardwareCharacterCache):void 
		{
			_cache = value;
		}
		
		public function get text():String
		{
			return _text;
		}
		
		public function set text(value:String):void
		{
			_text = value;
			parseText();
		}
		
		public function get width():Number 
		{
			return _width;
		}
		
		public function set width(value:Number):void 
		{
			_width = value;
			_fixedWidth = true;
		}
		
		// standardFormat
		
		public function get standardFormat():HardwareFontFormat 
		{
			return _standardFormat;
		}
		
		public function set standardFormat(value:HardwareFontFormat):void 
		{
			_standardFormat = value;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		public function registerFont(font:HardwareFont):void
		{
			throw new Error("Function not yet implemented.");
		}
		
		private function parseText():void 
		{
			loseAllChildren();
			var currentLine:HardwareLine = new HardwareLine();
			addChild(currentLine);
			
			var words:Array = _text.split(/([\s\-]+)/);
			
			const l:uint = words.length;
			for (var i:uint = 0; i < l; i++)
			{
				var currentWord:HardwareWord = new HardwareWord();
				currentWord.initialize(words[i], _standardFormat, _cache);
				
				if (_fixedWidth && currentLine.boundingBox.right + currentWord.boundingBox.right > _width || (words[i] as String) == "\n")
				{
					// start new line
					var previousLine:HardwareLine = currentLine;
					currentLine = new HardwareLine();
					
					currentLine.y = -previousLine.boundingBox.height + previousLine.y;
					
					addChild(currentLine);
				}
				
				currentLine.addWord(currentWord);
			}
			
			calculateTransformations();
		}
		
	}

}