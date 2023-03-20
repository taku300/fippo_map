// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import jquery from "jquery"
window.$ = jquery

$(document).on("turbo:load", function() {
  //flashメッセージを閉じる
  var $jsFlashClose = $('.js-flash-close')
  $jsFlashClose.on('click', function() {
    console.log($(this).parent().parent())
    $(this).parent().parent().slideToggle(200)
  })

  // profileの表示・非表示
  var $userMenuButton = $("#js-user-menu-button");
  $userMenuButton.on('click', function() {
    $(this).next().slideToggle(200)
  })
})
