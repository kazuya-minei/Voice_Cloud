$(function (){
  // 処理（ページが読み込まれた時、フォームに残り何文字入力できるかを数えて表示する）

  //フォームに入力されている文字数を数える
  //\nは"改行"に変換して2文字にする。オプションフラグgで文字列の最後まで\nを探し変換する
  var count = $(".user-text").text().replace(/\n/g, "改行").length;
  //残りの入力できる文字数を計算
  var now_count = 150 - count;
  //文字数がオーバーしていたら文字色を赤にする
  if (count > 150) {
    $(".user-text-count").css("color","red");
  }
  //残りの入力できる文字数を表示
  $(".user-text-count").text( "残り" + now_count + "文字");

  $(".user-text").on("keyup", function() {
    // 処理（キーボードを押した時、フォームに残り何文字入力できるかを数えて表示する）
    //フォームのvalueの文字数を数える
    var count = $(this).val().replace(/\n/g, "改行").length;
    var now_count = 150 - count;

    if (count > 150) {
      $(".user-text-count").css("color","red");
    } else {
      $(".user-text-count").css("color","black");
    }
    $(".user-text-count").text( "残り" + now_count + "文字");
  });
});

$(function (){

  var count = $(".work-text").text().replace(/\n/g, "改行").length;

  var now_count = 2000 - count;

  if (count > 2000) {
    $(".work-text-count").css("color","red");
  }
  $(".work-text-count").text( "残り" + now_count + "文字");

  $(".work-text").on("keyup", function() {

    var count = $(this).val().replace(/\n/g, "改行").length;
    var now_count = 2000 - count;

    if (count > 2000) {
      $(".work-text-count").css("color","red");
    } else {
      $(".work-text-count").css("color","black");
    }
    $(".work-text-count").text( "残り" + now_count + "文字");
  });
});