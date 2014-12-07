package com.pineapple.business.controllers
{
	import com.guinetik.kinetic.external.ServerSide;
	import com.pineapple.business.util.UploadPostHelper;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.PixelSnapping;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.net.ObjectEncoding;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;
	
	import mx.graphics.codec.JPEGEncoder;

	[Event(name="data_return", type="com.pineapple.business.events.DataReturnEvent")]
	public class PhotoUploadController extends EventDispatcher
	{
		
		private var _resultBitmap:Bitmap;
		private var _filename:String;
		
		public function PhotoUploadController()
		{
			
			
			
		}
		
		public function prepareThumbnail(source:Bitmap):void
		{
			
			this.resultBitmap = cropAndResize(source, 100, 100);
			this.dispatchEvent(new Event(Event.RESIZE));
			
		}
		
		private function cropAndResize( target:DisplayObject, width:Number, height:Number, center:Boolean = true, fillBox:Boolean = true ):Bitmap 
		{
			
			var tempW:Number = target.width;
			var tempH:Number = target.height;
			
			target.width = width;
			target.height = height;
			
			var scale:Number = (fillBox) ? Math.max(target.scaleX, target.scaleY) : Math.min(target.scaleX, target.scaleY);
			
			target.width = tempW;
			target.height = tempH;
			
			var scaleBmpd:BitmapData = new BitmapData(target.width * scale, target.height * scale);
			var scaledBitmap:Bitmap = new Bitmap(scaleBmpd, PixelSnapping.ALWAYS, true);
			var scaleMatrix:Matrix = new Matrix();
			scaleMatrix.scale(scale, scale);
			scaleBmpd.draw( target, scaleMatrix );
			
			if (scaledBitmap.width > width || scaledBitmap.height > height) {
				
				var cropMatrix:Matrix = new Matrix();
				var cropArea:Rectangle = new Rectangle(0, 0, width, height);
				
				var croppedBmpd:BitmapData = new BitmapData(width, height);
				var croppedBitmap:Bitmap = new Bitmap(croppedBmpd, PixelSnapping.ALWAYS, true);
				
				if (center) {
					var offsetX:Number = Math.abs((width -scaleBmpd.width) / 2);
					var offsetY:Number = Math.abs((height - scaleBmpd.height) / 2);
					
					cropMatrix.translate(-offsetX, -offsetY);
				}
				
				croppedBmpd.draw( scaledBitmap, cropMatrix, null, null, cropArea, true );
				return croppedBitmap;
				
			} else {
				return scaledBitmap;
			}
			
		}

		public function get resultBitmap():Bitmap
		{
			return _resultBitmap;
		}

		public function set resultBitmap(value:Bitmap):void
		{
			_resultBitmap = value;
		}

		public function uploadForMobile():void
		{
			
			var jPEGEncoder:JPEGEncoder 						= new JPEGEncoder(90);
			var bytes:ByteArray									= jPEGEncoder.encode(resultBitmap.bitmapData);
			this.filename										= "foto_" + new Date().time + ".jpg";
			var streamObject:Object 							= {filename: this.filename, jpegstream : bytes};
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("jpegencoder.JPEGEncoder.saveToServer", onResultUpload, onStatus, streamObject);
			
		}
		
		private function onResultUpload(result:Object):void
		{
			
			trace("PhotoUploadController.onResultUpload(", result, ")");
			
			if(result == true)
			{
				
				this.dispatchEvent(new Event(Event.COMPLETE));
				
			}
			
		}
		
		private function onStatus(result:Object):void
		{
			
			trace("RepositorioLogin.onStatus()");
			for each (var i:String in result) 
			{
				trace(i, result[i]);
			}
			
		}
		
		protected function uploadCompleteHandler(event:Event):void
		{
			
			trace("PhotoUploadController.uploadCompleteHandler(", event.target.data, ")");
			dispatchEvent(event);
			
		}

		public function get filename():String
		{
			return _filename;
		}

		public function set filename(value:String):void
		{
			_filename = value;
		}

	}
}