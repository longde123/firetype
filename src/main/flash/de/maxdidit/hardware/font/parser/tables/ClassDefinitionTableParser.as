package de.maxdidit.hardware.font.parser.tables 
{
	import de.maxdidit.hardware.font.data.tables.classes.ClassDefinitionTableData1;
	import de.maxdidit.hardware.font.data.tables.classes.ClassDefinitionTableData2;
	import de.maxdidit.hardware.font.data.tables.classes.ClassRangeRecord;
	import de.maxdidit.hardware.font.parser.DataTypeParser;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class ClassDefinitionTableParser implements ITableParser
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _dataTypeParser:DataTypeParser;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function ClassDefinitionTableParser(dataTypeParser:DataTypeParser) 
		{
			_dataTypeParser = dataTypeParser;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.parser.tables.ITableParser */
		
		public function parseTable(data:ByteArray, offset:uint):* 
		{
			data.position = offset;
			var format:uint = _dataTypeParser.parseUnsignedShort(data);
			var result:Object;
			
			if (format == 1)
			{
				result = parseClassDefinitionTable1(data);
				(result as ClassDefinitionTableData1).classFormat = format;
			}
			else if (format == 2)
			{
				result = parseClassDefinitionTable2(data);
				(result as ClassDefinitionTableData2).classFormat = format;
			}
			else
			{
				// class definition table format not supported
				// TODO: feedback to the user
				return null;
			}
			
			return result;
		}
		
		private function parseClassDefinitionTable1(data:ByteArray):ClassDefinitionTableData1 
		{
			var result:ClassDefinitionTableData1 = new ClassDefinitionTableData1();
			
			result.startGlyphID = _dataTypeParser.parseUnsignedShort(data);
			result.glyphCount = _dataTypeParser.parseUnsignedShort(data);
			
			var classValues:Vector.<uint> = new Vector.<uint>();
			for (var i:uint = 0; i < result.glyphCount; i++)
			{
				var value:uint = _dataTypeParser.parseUnsignedShort(data);
				classValues.push(value);
			}
			
			result.classValues = classValues;
			
			return result;
		}
		
		private function parseClassDefinitionTable2(data:ByteArray):ClassDefinitionTableData2
		{
			var result:ClassDefinitionTableData2 = new ClassDefinitionTableData2();
			
			result.classRangeCount = _dataTypeParser.parseUnsignedShort(data);
			result.classRangeRecords = parseClassRangeRecords(data, result.classRangeCount);
			
			return result;
		}
		
		private function parseClassRangeRecords(data:ByteArray, classRangeCount:uint):Vector.<ClassRangeRecord> 
		{
			var records:Vector.<ClassRangeRecord> = new Vector.<ClassRangeRecord>();
			
			for (var i:uint = 0; i < classRangeCount; i++)
			{
				var record:ClassRangeRecord = new ClassRangeRecord();
				record.start = _dataTypeParser.parseUnsignedShort(data);
				record.end = _dataTypeParser.parseUnsignedShort(data);
				record.classValue = _dataTypeParser.parseUnsignedShort(data);
				
				records.push(record);
			}
			
			return records;
		}
		
	}

}