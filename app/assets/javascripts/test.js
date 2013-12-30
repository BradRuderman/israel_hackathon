function getFileContents(fileUploaderId, callbackFunction){
	var file = document.getElementById(fileUploaderId).files[0];
	var reader = new FileReader();
    reader.onload = onLoadCallback;
	reader.readAsBinaryString(file);
	callbackfunction(reader.result.toString('base64'));
}
/*getFileContents("fileToUpload");*/


function readFile(file, onLoadCallback){
    var reader = new FileReader();
    reader.onload = onLoadCallback;
    reader.readAsText(file);
}