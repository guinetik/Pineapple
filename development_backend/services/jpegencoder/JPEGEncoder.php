<?php

class JPEGEncoder 

{

	function JPEGEncoder ( )
	
	{
	
	}
	
	/**
	@desc save the JPEG on server
	*/
	function saveToServer ( $pInfos )
	
	{
		
		$bytearray = $pInfos["jpegstream"];
		// bytearray is in the ->data property
		$imageData = $bytearray->data;
		$idimage = $pInfos["filename"];
		$success = file_put_contents("../../uploads/".$idimage, $imageData);
		return $success != false ? true : false;
	 
	}

}

?>