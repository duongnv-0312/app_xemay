//= require search_box

var map;
var currentPosition;
var service;
var circles;
var markersArray = [];
var infowindows = [];

function index_maps() {
  var options = {
    center: new google.maps.LatLng(21.006645, 105.842414),
    zoom:13,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  var coordinates = $.parseJSON($("#map-index-reviews").attr("data-coordinates"));
  var stores = $.parseJSON($("#map-index-reviews").attr("data-stores"));
  var reviews = $.parseJSON($("#map-index-reviews").attr("data-reviews"));
  // toJsonData(coordinates, stores, reviews);

  map = new google.maps.Map(document.getElementById("map-index-reviews"), options);
  infoGeolocation = new google.maps.InfoWindow({maxWidth: 200});
  searchBox();
  geoMylocation(map, infoGeolocation);
  searchByRadius();
}

function searchByRadius() {
  var coordinates = $.parseJSON($("#map-index-reviews").attr("data-coordinates"));
  var stores = $.parseJSON($("#map-index-reviews").attr("data-stores"));
  var reviews = $.parseJSON($("#map-index-reviews").attr("data-reviews"));
  var radiusControlDiv = document.createElement("div");
  radiusControl = new RadiusControl(radiusControlDiv);

  radiusControlDiv.index = 1;
  map.controls[google.maps.ControlPosition.BOTTOM_RIGHT].push(radiusControlDiv);

  google.maps.event.addListener(map, "click", function(e) {
    if(markersArray.length > 0) {
      clearMarkers();
    }

    if(circles !== undefined) {
      circles.setMap(null);
    }

    var lat = e.latLng.lat();
    var lng = e.latLng.lng();
    var orgLocation = new google.maps.LatLng(lat, lng);
    var rad = 5000;
    drawCircle(orgLocation, rad);

    if(coordinates.length < 1) {
      console.log("No stores");
    }
    else {
      for(var i = 0; i < coordinates.length; i++) {
        var desLocation = new google.maps.LatLng(coordinates[i].lat, coordinates[i].lng);

        if (google.maps.geometry.spherical.computeDistanceBetween(orgLocation, desLocation) < rad) {
          markersArray[i] = new google.maps.Marker({
            position: desLocation,
            map: map
          });
          markerContent = "Lat: " + coordinates[i].lat +
                          "<br>Lng: " + coordinates[i].lng +"";

          markersArray[i].setMap(map);
          infowindows [i] = new google.maps.InfoWindow({
            maxWidth: 300,
          });

          bindInfoWindow(markersArray[i], map, infowindows[i], markerContent);
        }
      }
    }
  });
}

function clearMarkers() {
  for (var i = 0; i < markersArray.length; i++) {
    if(markersArray[i] !== undefined) {
      markersArray[i].setMap(null);
    }
  }

  markersArray.length = 0;
}

function drawCircle(orgLocation, rad) {
  circles = new google.maps.Circle({
    strokeColor: "#2680FA",
    strokeOpacity: 0.8,
    strokeWeight: 2,
    fillColor: "#2680FA",
    fillOpacity: 0.35,
    map: map,
    center: orgLocation,
    radius: rad,
  });
}

function bindInfoWindow(marker, map, infowindows, markerContent) {
  marker.addListener("click", function() {
    infowindows.setContent(markerContent);
    infowindows.open(map, this);
  });
}

function RadiusControl(radiusControlDiv) {
  var radiusControlButton = document.createElement("button");
  radiusControlButton.className = "radiusControlButton";
  radiusControlButton.style.backgroundColor = "rgba(222, 208, 208, 0.7)";
  radiusControlButton.style.border = "1px solid rgba(113, 91, 91, 0.3)";
  radiusControlButton.style.outline = "none";
  radiusControlButton.style.width = "40px";
  radiusControlButton.style.height = "28px";
  radiusControlButton.style.borderRadius = "2px";
  radiusControlButton.style.boxShadow = "0 1px 4px rgba(0,0,0,0.3)";
  radiusControlButton.style.cursor = "pointer";
  radiusControlButton.style.marginRight = "10px";
  radiusControlButton.style.padding = "0";
  radiusControlButton.title = "Clear Overlay";

  radiusControlDiv.appendChild(radiusControlButton);

  var radiusControlChild = document.createElement("div");
  radiusControlChild.style.margin = "5px 10px";
  radiusControlChild.style.width = "23px";
  radiusControlChild.style.height = "23px";
  radiusControlChild.style.backgroundImage = "url('/assets/turn_off_on_power.png')";
  radiusControlChild.style.backgroundSize = "18px 18px";
  radiusControlChild.style.backgroundPosition = "0 0";
  radiusControlChild.style.backgroundRepeat = "no-repeat";

  radiusControlButton.appendChild(radiusControlChild);

  radiusControlButton.addEventListener("click", function() {
    if(markersArray.length > 0) {
      clearMarkers();
    }

    if(circles !== undefined) {
      circles.setMap(null);
    }
  });
}

function geoMylocation(map, infoGeolocation) {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var pos = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };
      var image = {
        url: "/assets/geolocation-icon.png",
        size: new google.maps.Size(40, 40),
        origin: new google.maps.Point(0, 0),
        anchor: new google.maps.Point(0, 25),
        scaledSize: new google.maps.Size(40, 40)
      };
      var posGeolocation = {
        position: pos,
        icon: image,
        map: map
      };

      var centerControlDiv = document.createElement("div");
      var centerControl = new CenterControl(centerControlDiv, map, pos, posGeolocation);

      centerControlDiv.index = 1;
      map.controls[google.maps.ControlPosition.RIGHT_BOTTOM].push(centerControlDiv);


    }, function() {
      handleLocationError(true, infoGeolocation, map.getCenter());
    });
  }
  else {
    handleLocationError(false, infoGeolocation, map.getCenter());
  }
}

function handleLocationError(browserHasGeolocation, infoGeolocation, pos) {
  infoGeolocation.setPosition(pos);
  infoGeolocation.setContent(browserHasGeolocation ?
    "Error: The Geolocation service failed." :
    "Error: Your browser does not support geolocation.");
}

function CenterControl(controlDiv, map, pos, posGeolocation) {
  var controlUI = document.createElement("button");
  controlUI.style.backgroundColor = "#fff";
  controlUI.style.border = "none";
  controlUI.style.outline = "none";
  controlUI.style.width = "28px";
  controlUI.style.height = "28px";
  controlUI.style.borderRadius = "2px";
  controlUI.style.boxShadow = "0 1px 4px rgba(0,0,0,0.3)";
  controlUI.style.cursor = "pointer";
  controlUI.style.marginRight = "10px";
  controlUI.style.padding = "0";
  controlUI.title = "Your Location";

  controlDiv.appendChild(controlUI);

  var secondChild = document.createElement("div");
  secondChild.style.margin = "5px";
  secondChild.style.width = "18px";
  secondChild.style.height = "18px";
  secondChild.style.backgroundImage = "url('https://maps.gstatic.com/tactile/mylocation/mylocation-sprite-2x.png')";
  secondChild.style.backgroundSize = "180px 18px";
  secondChild.style.backgroundPosition = "0 0";
  secondChild.style.backgroundRepeat = "no-repeat";
  controlUI.appendChild(secondChild);

  controlUI.addEventListener("click", function() {
    if(markersArray.length > 0) {
      clearMarkers();
    }

    if(circles !== undefined) {
      circles.setMap(null);
    }

    map.setCenter(pos);
    var markerGeolocation = new google.maps.Marker(posGeolocation);
    markerGeolocation.setMap(map);
    drawCircle(map, pos);
    markerGeolocation.addListener("click", function() {
      infoGeolocation.setContent("Location found!");
      infoGeolocation.open(map, this);
    });
  });
}
