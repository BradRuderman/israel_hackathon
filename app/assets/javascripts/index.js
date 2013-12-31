var map;
var markers = {};

function initialize() {
  var mapOptions = {
    zoom: 13,
    center: new google.maps.LatLng(31.7833, 35.2167)
  };
  map = new google.maps.Map(document.getElementById('map-canvas'),
      mapOptions);
  $.get('/tickets', function(tickets){
    _.each(tickets, function(ticket){
      loadDivs(ticket);
      loadPins(ticket);
    })
  });
}

var loadPins = function(ticket){
    var myLatlon = new google.maps.LatLng(ticket.lat,ticket.lon);
    var marker = new google.maps.Marker({
      position: myLatlon,
      map: map
    });

    markers[ticket.id] = marker;
    google.maps.event.addListener(marker, 'click', function() {
      var row = 'row_' + ticket.id
      document.getElementById(row).scrollIntoView()
    });
}

var loadDivs = function(data){
  if (data.status === true) return;
  var add = data.address || ' ';
  $('#rightSide').append('<div tabindex="-1" id="row_'+data.id+' oneStory borderGreen " class="ticket"><img class="image" src="/image/'+data.id+' " width="90px" /><div class="location"> '+add+' <div class="description"> '+data.description+'</div><div class="description"> '+data.category+'</div><div class="description"> '+data.priority+'</div><div class="description"> '+data.status+'</div></div><center><button type="button" class="btn btn-primary btn-lg btn-block boton" style="width:200px" onclick="removeDiv(\''+data.id+'\')">Mark as Resolved</button></center></div>')
}

var removeDiv = function(pin) {
  var row = 'row_' + pin;
  document.getElementById(row).remove()
  markers[pin].setVisible(false)
}

var addEmergency = function(){
  
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

  var address = $('.adr').val();
  var geocoder = new google.maps.Geocoder();
  geocoder.geocode( { 'address': address}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      var lat = results[0].geometry.location.nb
      var lon = results[0].geometry.location.ob
      map.setCenter(results[0].geometry.location);
      var marker = new google.maps.Marker({
          map: map,
          position: results[0].geometry.location
      });

    $('#myModal').modal('hide');

    var file = document.getElementById("fileToUpload").files[0];
    var fr = new FileReader;
    var imageData;

      fr.onload = function() {
        var img = new Image;
        img.onload = function() {
            var c=document.getElementById("cvs");
            var ctx=c.getContext("2d");
            ctx.drawImage(img,0,0,200,180);          
        }

        img.src = fr.result;
        setTimeout(function(){
          imageData = document.getElementById("cvs").toDataURL("image/jpg").replace("data:image/png;base64,","");
          var newInput = {
            "lat": lat,
            "lon": lon,
            "address": address,
            "description": description,
            "priority": priority,
            "status": "broken",
            "category": category,
            "status": false,
            "private": false,
            "image": imageData
          }

          var sendInput = JSON.stringify(newInput)
          $.post('/tickets', sendInput, function(data){
            loadDivs(data);
            loadPins(data);
          })

          document.getElementById('inputForm').reset();
        }, 3000);
      };
      fr.readAsDataURL(file);
    
    } else {
      $('.brokenAddress').show();
    }
  });
}

var hideBroken = function () {
  $('.brokenAddress').hide();
}
