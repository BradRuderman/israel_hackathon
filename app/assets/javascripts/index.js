var map;
var markers = {};

function initialize() {
  var mapOptions = {
    zoom: 13,
    center: new google.maps.LatLng(31.7833, 35.2167)
  };
  map = new google.maps.Map(document.getElementById('map-canvas'),
      mapOptions);
  loadDivs();
}

var loadPins = function(){
  _.each(dummyData, function(data){
    if (data.status === true) return;
    var myLatlon = new google.maps.LatLng(data.lat,data.lon);
    var marker = new google.maps.Marker({
      position: myLatlon,
      map: map
    });
    markers[data.id] = marker;
    google.maps.event.addListener(marker, 'click', function() {
      var row = $('#' + data.id);
      console.log(row.selector)
      $(row.selector).focus();
      // document.getElementById(data.id).scrollIntoView()
      // window.location.hash = '#'+data.id;
    });
  })
}

var loadDivs = function(){
  _.each(dummyData, function(data){
    if (data.status === true) return;
    $('#rightSide').append('<div tabindex="-1" id="'+data.id+' oneStory borderGreen"><img class="image" src=" '+data.image+' " width="90px" /><div class="location"> '+data.address+' <div class="description"> '+data.description+'</div><div class="description"> '+data.category+'</div><div class="description"> '+data.priority+'</div><div class="description"> '+data.status+'</div></div><center><button type="button" class="btn btn-primary btn-lg btn-block boton" style="width:90%" onclick="removeDiv(\''+data.id+'\')">Mark as resolved</button></center></div>')
  })
  loadPins();
}

var removeDiv = function(pin) {
  // var jPin = $('#' + pin);
  // console.log(jPin)
  // jPin.remove();
  $('.' + pin).remove();
  // $('#rightSide').remove()
}

var addEmergency = function(){
  var id = "";
  var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
  for( var i=0; i < 5; i++ ) {
    id += possible.charAt(Math.floor(Math.random() * possible.length));
  }

  var priority = $('.prior').val()
  var image = $('.img').val()
  
  var description = $('.desc').val()
  
  var categories = document.getElementsByClassName('categ')
  var category = "";
  for (var i = 0; i < categories.length; i++) {
    if(categories[i].checked === true) {
      category += categories[i].value + " "
    }
  }

  var file = document.getElementsByClassName("img")[0].value;
  var fr = new FileReader;

  if(file != null){
  fr.onload = function() {
    var img = new Image;
    img.onload = function() {
        var c=document.getElementById("cvs");
        var ctx=c.getContext("2d");
        ctx.drawImage(img,0,0,200,180);          
    }
    img.src = fr.result;
    var imageData = document.getElementById("cvs").toDataURL("image/jpg").replace("data:image/png;base64,","");

    fr.readAsDataURL(file);
    $.support.cors = true;
    $.ajax({
          url: "/tickets",
          type: "POST",
          crossDomain: true,
          data: imageData,
          success: function(data){
            console.log(data)
          },
          error:function(err){
            alert("Error", err);
          }
        })
  }
    };

  var address = $('.adr').val();
  var geocoder = new google.maps.Geocoder();
  geocoder.geocode( { 'address': address}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      var lat = results[0].geometry.location.ob
      var lon = results[0].geometry.location.nb
      map.setCenter(results[0].geometry.location);
      var marker = new google.maps.Marker({
          map: map,
          position: results[0].geometry.location
      });

      var newInput = {
        "id": id,
        "lat": lat,
        "lon": lon,
        "address": address,
        "description": description,
        "priority": priority,
        "status": "broken",
        "category": category,
        "status": false,
        "private": false,
        "image": image
      }
      console.log($('#myModal'));
      $('#myModal').modal('hide');
      document.getElementById('inputForm').reset();
      dummyData[id] = newInput;
    
    } else {
      $('.brokenAddress').show();
    }
  });
}

var hideBroken = function () {
  $('.brokenAddress').hide();
}

google.maps.event.addDomListener(window, 'load', initialize);
