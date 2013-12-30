/*var file = document.getElementById("fileToUpload").files[0];
var fr = new FileReader;

fr.onload = function() {
    var img = new Image;
    img.onload = function() {
        var c=document.getElementById("cvs");
        var ctx=c.getContext("2d");
        ctx.drawImage(img,0,0,200,180);          
    }
    img.src = fr.result;
    var imageData = document.getElementById("cvs").toDataURL("image/jpg").replace("data:image/png;base64,","");
};

fr.readAsDataURL(file);*/