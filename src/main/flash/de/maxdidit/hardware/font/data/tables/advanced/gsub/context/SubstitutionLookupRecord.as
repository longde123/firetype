/* 
'firetype' is an ActionScript 3 library which loads font files and renders characters via the GPU. 
Copyright �2013 Max Knoblich 
www.maxdid.it 
me@maxdid.it 
 
This file is part of 'firetype' by Max Did It. 
  
'firetype' is free software: you can redistribute it and/or modify 
it under the terms of the GNU Lesser General Public License as published by 
the Free Software Foundation, either version 3 of the License, or 
(at your option) any later version. 
  
'firetype' is distributed in the hope that it will be useful, 
but WITHOUT ANY WARRANTY; without even the implied warranty of 
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
GNU Lesser General Public License for more details. 
 
You should have received a copy of the GNU Lesser General Public License 
along with 'firetype'.  If not, see <http://www.gnu.org/licenses/>. 
*/ 
 
package de.maxdidit.hardware.font.data.tables.advanced.gsub.context  
{ 
	import de.maxdidit.hardware.font.data.tables.common.lookup.LookupTable; 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class SubstitutionLookupRecord  
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		private var _sequenceIndex:uint; 
		private var _lookupListIndex:uint; 
		private var _lookupTable:LookupTable; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function SubstitutionLookupRecord()  
		{ 
			 
		} 
		 
		/////////////////////// 
		// Member Properties 
		/////////////////////// 
		 
		public function get sequenceIndex():uint  
		{ 
			return _sequenceIndex; 
		} 
		 
		public function set sequenceIndex(value:uint):void  
		{ 
			_sequenceIndex = value; 
		} 
		 
		public function get lookupListIndex():uint  
		{ 
			return _lookupListIndex; 
		} 
		 
		public function set lookupListIndex(value:uint):void  
		{ 
			_lookupListIndex = value; 
		} 
		 
		public function get lookupTable():LookupTable  
		{ 
			return _lookupTable; 
		} 
		 
		public function set lookupTable(value:LookupTable):void  
		{ 
			_lookupTable = value; 
		} 
		 
	} 
} 
