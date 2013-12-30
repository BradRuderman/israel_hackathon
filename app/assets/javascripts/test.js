function getFileContents(fileUploaderId, callbackFunction){
	var file = document.getElementById(fileUploaderId).files[0];
	var reader = new FileReader();
    reader.onload = onLoadCallback;
	reader.readAsBinaryString(file);
}


/*getFileContents("fileToUpload", function(reader){
	console.log(reader.result.toString("base64"));
}); */
