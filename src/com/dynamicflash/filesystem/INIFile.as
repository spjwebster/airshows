package com.dynamicflash.filesystem {
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.Dictionary;
	
	public class INIFile {
		public var sections:Dictionary;
		private var file:File;
		
		public function INIFile() {
		}

		public function load( file:File ):void {
			this.file = file;
			
			var stream:FileStream = new FileStream();
			stream.open( file, FileMode.READ );
			
			this.parse( stream.readUTFBytes( file.size ) );
		}
		
		private function parse( data:String ):void {
			trace( "INIFile::parse" );
			this.sections = new Dictionary();
			
			var commentRegExp:RegExp = new RegExp( "^((\\s*)|(#.*))$" );
			var sectionRegExp:RegExp = new RegExp( "^\\s*\\[(.*)]\\s*(;.*)?$" );
			var variableRegExp:RegExp = new RegExp( "^\\s*(.*?)\\s*=\\s*\"?(.*?)\"?\\s*(;.*)?$" );

			var currentSection:Dictionary;
			var matches:Array = new Array();
			
			var lines:Array = data.split( "\n" );
			for each ( var line:String in lines ) {
				
				if ( commentRegExp.test( line ) ) {
					continue;
				}
				
				if ( sectionRegExp.test( line ) ) {
					matches = line.match( sectionRegExp );
					currentSection = new Dictionary();
					this.sections[ matches[ 1 ] ] = currentSection;
					trace( "   - section: " + matches[ 1 ] );
				}
				
 				if ( variableRegExp.test( line ) ) {
	 				matches = line.match( variableRegExp )
					trace( "     - variable: " + matches[ 1 ] );
					if ( currentSection ) {
						currentSection[ matches[ 1 ] ] = matches[ 2 ];
					} else {
						trace( "      - skipping variable outside of section" );
					}
				} 
			}
		}
		
		public function save( file:File = null ):void {
			if ( file === null ) {
				file = this.file;
			}
			
			var lines:Array = new Array();
			
			for ( var sectionName:String in this.sections ) {
				lines.push( "[" + sectionName + "]" );

				var section:Dictionary = this.sections[ sectionName ] as Dictionary;
				
				for ( var variableName:String in section ) {
					lines.push( variableName + " = " + section[ variableName ] );
				}
				
				lines.push( "" );
			}
			
			var stream:FileStream = new FileStream();
			stream.open( file, FileMode.WRITE );
			stream.writeUTFBytes( lines.join( "\n" ) );
			stream.close();
		}
	}
}