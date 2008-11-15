package com.dynamicflash.airshows.events {
	import flash.events.Event;

	public class SubscriptionEvent extends Event {
		public static const SUBSCRIBE:String = "subscribe";
		
		public var show:Object;
		
		public function SubscriptionEvent( type:String, show:Object ) {
			super( type, true );
			this.show = show;
		}
	}
}