<?php

$newName = $_REQUEST["newName"];
$tempFile = $_FILES['Filedata']['tmp_name'];
$fileName = $_FILES['Filedata']['name'];
$fileSize = $_FILES['Filedata']['size'];

if($newName != null)
{
	
	if(move_uploaded_file($tempFile, "./uploads/" . $newName))
	{
		
		echo "true";
		
	} else 
	{
		
		echo "false";
		
	}
	
} else 
{
	
	if(move_uploaded_file($tempFile, "./uploads/" . $fileName))
	{
		
		echo "true";
		
	} else 
	{
		
		echo "false";
		
	}
	
}

?>