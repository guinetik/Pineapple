package com.pineapple.business.events
{
	import flash.events.Event;
	
	public class AccessEvent extends Event
	{
		
		public static const ACCESS_GRANTED			:String 			= "access_granted";
		public static const ACCESS_DENIED			:String 			= "access_denied";
		public static const USER_LOGOUT				:String 			= "user_logout";
		
		public function AccessEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			
			return new AccessEvent(this.type, this.bubbles, this.cancelable);
			
		}
	}
}