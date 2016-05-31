var map;

function show_on_map() {
  var lat = parseFloat(document.getElementById("coordinate_lat").value);
  var lng = parseFloat(document.getElementById("coordinate_lng").value);
  var review_content = document.getElementById("review_content").value;
  var store_phone_number = document.getElementById("store_phone_number").value;
  var store_name = document.getElementById("store_name").value;
  var infoContent = "<div id='review-show-info'>" +
                    "<a href='#'>" +
                    "<b>" + store_name + "</b></a><br>" +
                    review_content + "<br><br>" +
                    "<i class='fa fa-phone-square fa-1x'>&nbsp;" +
                    store_phone_number + "</i>" +
                    "</div>";

  var myLatLng = new google.maps.LatLng(lat, lng);
  var markerLatLng = {lat: lat, lng: lng};

  var options= {
    zoom: 14,
    center: myLatLng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };

  map = new google.maps.Map(document.getElementById("show-map-canvas"), options);

  var infowindow = new google.maps.InfoWindow({
    content: infoContent,
    maxWidth: 400
  });
  var marker = new google.maps.Marker({
    position: markerLatLng,
    map: map,
    title: store_name
  });

  marker.addListener("click", function() {
    infowindow.open(map, marker);
  });
}
