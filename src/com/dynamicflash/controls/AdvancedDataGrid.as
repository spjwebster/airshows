package com.dynamicflash.controls {
	import flash.display.Sprite;
	
	import mx.collections.ArrayCollection;
	import mx.controls.DataGrid;

	public class AdvancedDataGrid extends DataGrid {
		public var rowColorFunction:Function;
		
		public function AdvancedDataGrid() {
			super();
		}
		
		override protected function drawRowBackground(s:Sprite, rowIndex:int, y:Number, height:Number, color:uint, dataIndex:int):void {
	    	if ( this.rowColorFunction != null ) {
	    		if ( dataIndex < (this.dataProvider as ArrayCollection).length ) {
		    		var item:Object = (this.dataProvider as ArrayCollection).getItemAt(dataIndex);
		    		color = this.rowColorFunction.call( this, item, color );
	    		}
	    	}
	    	
	    	super.drawRowBackground(s, rowIndex, y, height, color, dataIndex);
	    }
	}
}