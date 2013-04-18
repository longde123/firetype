package de.maxdidit.hardware.font.parser 
{
	import de.maxdidit.hardware.font.data.tables.DigitalSignature;
	import de.maxdidit.hardware.font.data.tables.DigitalSignatureTableData;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class DigitalSignatureTableParser implements ITableParser 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _dataTypeParser:DataTypeParser;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function DigitalSignatureTableParser(dataTypeParser:DataTypeParser) 
		{
			_dataTypeParser = dataTypeParser;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.parser.ITableParser */
		
		public function parseTable(data:ByteArray, offset:uint):* 
		{
			data.position = offset;
			
			var result:DigitalSignatureTableData = new DigitalSignatureTableData();
			
			result.version = _dataTypeParser.parseUnsignedLong(data);
			result.numSignatures = _dataTypeParser.parseUnsignedShort(data);
			result.flags = _dataTypeParser.parseUnsignedShort(data);
			
			result.signatures = parseSignatureEntries(data, result.numSignatures);
			parseSignatures(data, offset, result.signatures);
			
			return result;
		}
		
		private function parseSignatures(data:ByteArray, offset:uint, signatures:Vector.<DigitalSignature>):void 
		{
			const l:uint = signatures.length;
			
			for (var i:uint = 0; i < l; i++)
			{
				parseSignature(data, offset, signatures[i]);
			}
		}
		
		private function parseSignature(data:ByteArray, offset:uint, signature:DigitalSignature):void 
		{
			data.position = offset + signature.offset;
			
			data.position += 2; // reserved unsigned short
			data.position += 2; // another reserved unsigned short
			
			signature.pkcs7Length = _dataTypeParser.parseUnsignedLong(data);
			
			var pkcs7Packet:ByteArray = new ByteArray();
			data.readBytes(pkcs7Packet, 0, signature.pkcs7Length);
			
			signature.pkcs7Packet = pkcs7Packet;
		}
		
		private function parseSignatureEntries(data:ByteArray, numSignatures:uint):Vector.<DigitalSignature> 
		{
			var signatures:Vector.<DigitalSignature> = new Vector.<DigitalSignature>();
			
			for (var i:uint = 0; i < numSignatures; i++)
			{
				var signature:DigitalSignature = new DigitalSignature();
				parseSignatureEntry(data, signature);
				signatures.push(signature);
			}
			
			return signatures;
		}
		
		private function parseSignatureEntry(data:ByteArray, signature:DigitalSignature):void 
		{
			signature.format = _dataTypeParser.parseUnsignedLong(data);
			signature.length = _dataTypeParser.parseUnsignedLong(data);
			signature.offset = _dataTypeParser.parseUnsignedLong(data);
		}
	}

}