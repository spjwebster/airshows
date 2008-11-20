package com.dynamicflash.airshows.data {
	import flash.utils.Dictionary;
	
	[Bindable]
	public class Show {
		public var id:String;
		public var title:String;
		public var subscribed:Boolean;
		public var lastSeason:uint;
		public var lastEpisode:uint;
		public var extras:Dictionary;
		
		public function Show() {
			this.extras = new Dictionary();
		}
		
		
	}
}