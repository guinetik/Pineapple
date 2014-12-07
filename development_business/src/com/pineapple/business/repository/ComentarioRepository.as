package com.pineapple.business.repository
{
	import com.guinetik.kinetic.external.ServerSide;
	import com.guinetik.kinetic.utils.output.traceObject;
	import com.pineapple.business.events.DataReturnEvent;
	import com.pineapple.business.model.ComentarioVO;
	import com.pineapple.business.model.ObjectTranslator;
	import com.pineapple.business.model.ProjetoVO;
	import com.pineapple.business.model.UserVO;
	
	import flash.events.EventDispatcher;
	import flash.net.ObjectEncoding;
	
	import mx.collections.ArrayCollection;

	
	[Event(name="data_return", type="com.pineapple.business.events.DataReturnEvent")]
	public class ComentarioRepository extends EventDispatcher
	{
		
		private var comentarios:ArrayCollection;
		
		public function ComentarioRepository()
		{

		}
		
		public function getComentariosByProjeto(p:ProjetoVO):void
		{
			
			trace("ComentarioRepository.getComentariosByProjeto(", p.id, ")");
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.getComentariosByProjeto", onResultComentarios, onStatus, {id_projeto:p.id});
			
		}
		
		private function onResultComentarios(result:Object):void
		{
			
			var r:Array 							= result as Array;
			trace("ComentarioRepository.onResultComentarios(", r.length, ")");			
			comentarios 							= new ArrayCollection();
			
			for (var i:int = 0; i < r.length; i++) 
			{
				
				var vo:ComentarioVO 				= ObjectTranslator.objectToInstance(r[i], ComentarioVO) as ComentarioVO;
				comentarios.addItem(vo);
				
			}
			
			var e:DataReturnEvent					= new DataReturnEvent(DataReturnEvent.DATA_RETURN, true);
			e.data									= comentarios;
			
			this.dispatchEvent(e);
			
			
		}
		
		private function onStatus(result:Object):void
		{
			
			trace("ComentarioRepository.onStatus()");
			for each (var i:String in result) 
			{
				trace(i, result[i]);
			}
			
		}

		
		public function salvarComentario(c:ComentarioVO):void
		{
			
			trace("ComentarioRepository.salvarComentario(c)");
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.salvarComentario", onResultSalvarComentario, onStatus, {autor:c.autor, datacadastro:c.datacadastro, descricao:c.descricao, idprojeto:c.idprojeto});
			
		}
		
		private function onResultSalvarComentario(result:Object):void
		{
			
			trace("ComentarioRepository.onResultSalvarComentario(result)");
			trace(result);
			
			var e:DataReturnEvent = new DataReturnEvent(DataReturnEvent.DATA_RETURN);
			e.result = result;
			dispatchEvent(e);
			
		}
		
		public function getUltimosComentariosByUsuario(a:UserVO):void
		{
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.getUltimosComentarios", onResultComentarios, onStatus, {usuario:a.nome});
			
		}
		
		public function getUltimosComentariosByProfessor(a:UserVO):void
		{
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.getUltimosComentariosByProfessor", onResultComentarios, onStatus, a);
			
		}
	}
}