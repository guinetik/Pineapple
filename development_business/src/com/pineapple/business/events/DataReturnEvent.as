package com.pineapple.business.events
{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	public class DataReturnEvent extends Event
	{
		
		public static const 			DATA_RETURN			:String 			= "data_return";
		
		protected var _data:ArrayCollection;
		protected var _result:Object;
		
		public function DataReturnEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}

		public function get data():ArrayCollection
		{
			return _data;
		}

		public function set data(value:ArrayCollection):void
		{
			_data = value;
		}
		
		override public function clone():Event
		{
			
			var e:DataReturnEvent = new DataReturnEvent(this.type, this.bubbles, this.cancelable);
			e.data = this.data;
			e.result = this.result;
			return e;
			
		}

		public function get result():Object
		{
			return _result;
		}

		public function set result(value:Object):void
		{
			_result = value;
		}


	}
}