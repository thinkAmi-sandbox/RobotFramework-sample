(function () {
    // ロードしてから3秒後に出現するタグ
    // http://codaholic.org/?p=896
    // https://stackoverflow.com/questions/584751/inserting-html-into-a-div
    // イベントが先に登録されている可能性も考慮して潰さないようにする
    // http://so-zou.jp/web-app/tech/programming/javascript/event/handler/onload.htm
    window.addEventListener("load", function () {
        setTimeout(function(){
            document.getElementById('show_delay').innerHTML = '<p id="hello">Hello, world!</p>'
        }, 3000);
    });


    //  ボタンを押したらアラートを表示する
    var show_alert = document.getElementById('show_alert');
    show_alert.onclick = function () {
        alert('OKのみです');
    };


    //  ボタンを押したら2秒後アラートを表示する
    var wait_alert = document.getElementById('wait_alert');
    wait_alert.onclick = function () {
        setTimeout(function(){
            alert('2秒後のアラート');
        }, 2000);
    };


    //  ボタンを押したらOKとキャンセルがある画面を出す
    var show_confirm = document.getElementById('show_confirm');
    show_confirm.onclick = function () {
        var answer = confirm('OKとキャンセルです');
        if (answer){
            alert('OKが押されました');
        }
        else{
            alert('キャンセルされました');
        }
    };


    //  ボタンを押したら入力プロンプトが表示される
    var show_prompt = document.getElementById('show_prompt');
    show_prompt.onclick = function () {
        var input_message = prompt('値を入力します');
        alert(input_message);
    };


    //  ボタンを押したらリロードする
    var reload = document.getElementById('run_reload');
    reload.onclick = function () {
        location.reload();
    };


    //  見えないボタンを押したらトップへ遷移する
    var display_none = document.getElementById('display_none');
    display_none.onclick = function () {
        window.location.href = '/'
    };


    //  マウスオーバーしたらボタンが現れ、そのボタンを押したらトップへ遷移する
    var on_mouse_area = document.getElementById('on_mouse_area');
    on_mouse_area.onmouseover = function () {
        document.getElementById('mouse_target').style.display = 'block';
    };
    on_mouse_area.onmouseout = function () {
        document.getElementById('mouse_target').style.display = 'none';
    };
    var mouse_target = document.getElementById('mouse_target');
    mouse_target.onclick = function () {
        window.location.href = '/'
    };


    // 一番下のボタンをクリックしたらalertが表示される
    var bottom_button = document.getElementById('bottom_button');
    bottom_button.onclick = function () {
        alert('下です');
    };

}());


