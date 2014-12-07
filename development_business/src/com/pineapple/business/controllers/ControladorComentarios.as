package com.pineapple.business.controllers
{
	import com.pineapple.business.events.DataReturnEvent;
	import com.pineapple.business.model.ComentarioVO;
	import com.pineapple.business.model.ProjetoVO;
	import com.pineapple.business.model.UserType;
	import com.pineapple.business.model.UserVO;
	import com.pineapple.business.repository.ComentarioRepository;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	[Event(name="data_return", type="com.pineapple.business.events.DataReturnEvent")]
	public class ControladorComentarios extends EventDispatcher
	{
		
		private var repo:ComentarioRepository;
		
		public function ControladorComentarios()
		{
			
			repo = new ComentarioRepository();
			repo.addEventListener(DataReturnEvent.DATA_RETURN, onDataReturn);
			
		}
		
		public function getComentariosByProjeto(p:ProjetoVO):void
		{
			
			trace("ControladorComentarios.getComentariosByProjeto(p)");
			
			repo.getComentariosByProjeto(p);
			
		}
		
		public function salvarComentario(c:ComentarioVO):void
		{
			
			trace("ControladorComentarios.salvarComentario(c)");
			repo.salvarComentario(c);
			
		}
		
		
		public function getUltimosComentariosByUsuario(a:UserVO):void
		{
			
			if(a.entidade == UserType.USER_ALUNO)
			{
				
				repo.getUltimosComentariosByUsuario(a);
				
			} else 
			{
				
				repo.getUltimosComentariosByProfessor(a);
				
			}
			
		}
		
		protected function onDataReturn(event:DataReturnEvent):void
		{
			
			dispatchEvent(event);
			
		}
	}
}