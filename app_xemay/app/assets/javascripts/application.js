// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require index_maps
//= require jquery.raty
//= require new_form_maps
//= require ratyrate
//= require show_on_map
//= require jquery.lazyload
//= require turbolinks
//= require jquery.lazyload
//= require_tree .

function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".products_fields").hide();
  $(link).closest(".images_fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $(link).parent().before(content.replace(regexp, new_id));
}

$(document).ready(function() {
  $("#comment_content").keypress(function(event) {
    if(event.which == 13 && !event.shiftKey) {
      $(this).closest('form').submit();
      return false;
    }
  });

  $("img").lazyload({
    event: "lazyload",
    effect: "fadeIn",
    effectspeed: 2000
  }).trigger("lazyload");

  $(".review-content").lazyload({
    threshold : 200
  }).trigger("lazyload");
});

$(document).on("page:change page:load", function(){
  if($("#map-index-container").length > 0) {
    index_maps();
  }
  else if($("#show-map-container").length > 0) {
    show_on_map();
  }
  else if($("#new-map-container").length > 0) {
    initialize();
  }
  else {
    return;
  }
});
