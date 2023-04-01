// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import jquery from "jquery"
window.$ = jquery

$(document).on("turbo:load", function() {
  // ローディング
  var loader = $('.loader-wrap');
  $(window).on('load',function(){
    loader.fadeOut();
  });
  setTimeout(function(){
    loader.fadeOut();
  },2000);

  //flashメッセージを閉じる
  var $jsFlashClose = $('.js-flash-close')
  $jsFlashClose.on('click', function() {
    $(this).parent().parent().slideToggle(200);
  })

  // profileの表示・非表示
  var $userMenuButton = $("#js-user-menu-button");
  $userMenuButton.on('click', function() {
    $(this).next().slideToggle(200);
  })

  // profileの表示・非表示
  var $searchClose = $(".js-search-close");
  $searchClose.on('click', function() {
    $(this).prev().slideToggle(200);
  })

  //釣果一覧画面の投稿する時のボタン
  var $AddPost = $(".js-add-post");
  var $toFormPost = $(".js-to-form-post");
  var $cancelPost = $(".js-cancel-post");
  var $centerPoint = $(".js-center-point");
  $AddPost.on('click', function() {
    $(this).slideToggle(400);
    $toFormPost.slideToggle(400);
    $cancelPost.slideToggle(400);
    $centerPoint.slideToggle(400);
  })
  $cancelPost.on('click', function() {
    $(this).slideToggle(400);
    $AddPost.slideToggle(400);
    $toFormPost.slideToggle(400);
    $centerPoint.slideToggle(400);
  })

  //もっと詳しくボタン
  var $addInfo = $(".js-add-info");
  $addInfo.on('click', function() {
    $(this).next().slideToggle(400);
    $(this).children().toggleClass('rotate-90');
  })

  // 釣果投稿画面のデフォルトのinputの設定
  var $fishFishingDate = $('#fish_fishing_date');
  var $fishLatitude = $('#fish_latitude');
  var $fishLongitude = $('#fish_longitude');
  var $fishSpecies = $('#fish_species');
  var $fishWeather = $('#fish_weather');
  var $fishWindDirection = $('#fish_wind_direction');
  var $fishWindSpeed = $('#fish_wind_speed');
  var $fishTemperature = $('#fish_temperature');
  var $fishTideName = $('#fish_tide_name');
  var $defaultFlag = $('#default_flag');
  if ($fishFishingDate.val() && $fishFishingDate.val().indexOf("+") >= 0) { // fishing_dateのタイムゾーンの表示を消去
    console.log($fishFishingDate)
    $fishFishingDate.val($fishFishingDate.val().substring(0, $fishFishingDate.val().indexOf("+")));
  }
  if ($defaultFlag.text() == 'default' && $fishLatitude.val() == "" && $fishLongitude.val() == "") {
    $.ajax({
      type: "GET",
      url: "/fishes/ajax_current_weather",
      dataType : "json"
    })
    .done(function(data){
      console.log('default current input true');
      console.log(data)
      inputDefault(data)
    })
    .fail(function(XMLHttpRequest, textStatus, errorThrown){
      alert('気象情報を取得できませんでした。');
    });
  }

  // カタカナバリデーション
  $fishSpecies.on('change', function () {
    console.log($(this).val())
    if(!$(this).val().match(/^[ァ-ヶー　]+$/)){    //"ー"の後ろの文字は全角スペースです。
      console.log('katakana validation true');
      $(this).val('')
    }
  })

  // 日付が変更された時のデフォルトinput処理
  $fishFishingDate.on('change', function () {
    $.ajax({
        url: '/fishes/ajax_history_weather',
        type: 'POST',
        cache: false,
        dataType: 'json',
        data: { date: $fishFishingDate.val(), latitude: $fishLatitude.val(), longitude: $fishLongitude.val() },
        })
        .done(function(data) {
          console.log('default history input true');
          console.log(data);
          inputDefault(data)
        })
        .fail(function(xhr) {
          alert('気象情報を取得できませんでした。');
        })
  });

  function inputDefault(data) {
    $fishFishingDate.val(data.fishing_date);
    $fishLatitude.val(data.latitude);
    $fishLongitude.val(data.longitude);
    $fishWeather.val(data.weather);
    $fishWindDirection.val(data.wind_direction);
    $fishWindSpeed.val(data.wind_speed);
    $fishTemperature.val(data.temperature);
    $fishTideName.val(data.tide_name);
  }
})
