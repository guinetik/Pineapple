package com.pineapple.frontend.views.ui
{
	import flash.events.Event;
	
	public class UIEvent extends Event
	{
		
		public static const REFRESH_UI:String = "refresh_ui";
		
		public function UIEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}