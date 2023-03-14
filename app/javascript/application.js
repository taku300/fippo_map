// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import jquery from "jquery"
window.$ = jquery

$(function(){
  // profileの表示・非表示
  var $userMenuButton = $("#js-user-menu-button");
  $userMenuButton.on('click', function() {
    console.log(111);
    $(this).next().slideToggle(200)
  })
})
