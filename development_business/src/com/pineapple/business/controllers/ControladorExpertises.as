package com.pineapple.business.controllers
{
	import com.pineapple.business.events.DataReturnEvent;
	import com.pineapple.business.model.ExpertiseVO;
	import com.pineapple.business.repository.ExpertiseRepository;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.collections.ArrayCollection;

	[Event(name="data_return", type="com.pineapple.business.events.DataReturnEvent")]
	public class ControladorExpertises extends EventDispatcher
	{

		private var repo:ExpertiseRepository;

		[Bindable]
		public static var cores:ArrayCollection=new ArrayCollection(['0xF7977A', '0xF9AD81', '0xFDC68A', '0xFFF79A', '0xC4DF9B', '0xA2D39C', '0x82CA9D', '0x7BCDC8', '0x6ECFF6', '0x7EA7D8', '0x8493CA', '0x8882BE', '0xA187BE', '0xBC8DBF', '0xF49AC2', '0xF6989D', '0xF26C4F', '0xF68E55', '0xFBAF5C', '0xFFF467', '0xACD372', '0x7CC576', '0x3BB878', '0x1ABBB4', '0x00BFF3', '0x438CCA', '0x5574B9', '0x605CA8', '0x855FA8', '0xA763A8', '0xF06EA9', '0xF26D7D', '0xB52C38', '0xEBD1B0', '0x536682', '0xD9964B', '0xDE6846', '0xF28705', '0x93A605', '0x3E5916']);

		public function ControladorExpertises(target:IEventDispatcher=null)
		{
			super(target);
			target
			repo=new ExpertiseRepository();
			repo.addEventListener(DataReturnEvent.DATA_RETURN, onDataReturn);

		}

		protected function onDataReturn(event:DataReturnEvent):void
		{

			this.dispatchEvent(event);

		}

		public function getExpertises():void
		{

			repo.getExpertises();

		}

		public function getExpertisesUsuario(login:String):void
		{

			repo.getExpertisesUsuario(login);

		}
		
		public function addExpertiseToUsuario(e:ExpertiseVO, login:String):void
		{
			
			repo.addExpertiseToUsuario(e, login);
			
		}
		
		public function saveAndAddExpertiseToUsuario(e:ExpertiseVO, login:String):void
		{
			
			repo.saveAndAddExpertiseToUsuario(e, login);
			
		}
		
		public function removeExpertiseFromUsuario(e:ExpertiseVO, login:String):void
		{
			
			repo.removeExpertiseFromUsuario(e, login);
			
		}

	}
}
