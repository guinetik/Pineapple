package com.pineapple.business.events
{
	import flash.events.Event;
	
	public class HeaderMenuEvent extends Event
	{
		
		public static const MENU_SELECTED:String = "menu_selected";
		private var _intentAction:String;
		
		public function HeaderMenuEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}

		public function get intentAction():String
		{
			return _intentAction;
		}

		public function set intentAction(value:String):void
		{
			_intentAction = value;
		}

	}
}