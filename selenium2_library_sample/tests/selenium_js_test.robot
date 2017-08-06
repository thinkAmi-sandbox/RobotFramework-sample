*** Settings ***
Library  Selenium2Library

# テストごとにブラウザを閉じてキャッシュをリセットする
# http://robotframework.org/Selenium2Library/Selenium2Library.html#Close%20All%20Browsers
Test Teardown  close all browsers


*** Keywords ***
Chromeを起動してJSページへ移動する
    create webdriver  Chrome
    JSページへ移動する

HeadlessなChromeを起動してJSページへ移動する
    ${options} =  evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys
    call method  ${options}  add_argument  --headless
    create webdriver  Chrome  chrome_options=${options}

    JSページへ移動する


JSページへ移動する
    # フォームページにいないなら移動する
    ${成否} =  run keyword and return status  JSページにいることを確認する
    run keyword unless  ${成否}  go to  http://localhost:8084/js

JSページにいることを確認する
    page should contain element  id=js_page


elementが出てくるまで待つ
    page should not contain element  id=hello
    wait until page contains element  id=hello
    element text should be  id=hello  Hello, world!


JSのalertでOKを押す
    click element  id=show_alert
    dismiss alert


JSのalertでメッセージを取得してOKを押す
    click element  id=show_alert
    ${アラートメッセージ} =  get alert message
    should be equal  ${アラートメッセージ}  OKのみです


JSのalertが表示されていることを確認してOKを押す
    click element  id=show_alert

    # http://robotframework.org/Selenium2Library/Selenium2Library.html#Alert%20Should%20Be%20Present
    alert should be present


JSのalertが表示されておりメッセージも一致しているかを確認してOKを押す
    click element  id=show_alert
    alert should be present  OKのみです


JSのalertの表示に時間がかかってもOKを押す
    click element  id=wait_alert

    # 第1引数はリトライ時間、第2引数はリトライ間隔、第3引数は実行するキーワード
    # http://robotframework.org/robotframework/latest/libraries/BuiltIn.html#Wait%20Until%20Keyword%20Succeeds
    # http://robotframework-ja.readthedocs.io/ja/latest/lib/BuiltIn.html#wait-until-keyword-succeeds
    ${アラートメッセージ} =  wait until keyword succeeds  5 sec  1 sec  get alert message

    should be equal  ${アラートメッセージ}  2秒後のアラート


JSのconfirmでOKを押す
    click element  id=show_confirm

    # 「choose ok on next confirmation」は無くても、デフォルトでOKが押される
    # http://robotframework.org/Selenium2Library/Selenium2Library.html#Confirm%20Action
    ${確認メッセージ} =  confirm action
    should be equal  ${確認メッセージ}  OKとキャンセルです
    ${アラートメッセージ} =  get alert message
    should be equal  ${アラートメッセージ}  OKが押されました


JSのconfirmでキャンセルを押す
    click element  id=show_confirm

    # キャンセルの時は明示的にchoose cancelを記載する
    # http://robotframework.org/Selenium2Library/Selenium2Library.html#Confirm%20Action
    # http://robotframework.org/Selenium2Library/Selenium2Library.html#Choose%20Cancel%20On%20Next%20Confirmation
    choose cancel on next confirmation

    ${確認メッセージ} =  confirm action
    should be equal  ${確認メッセージ}  OKとキャンセルです
    ${アラートメッセージ} =  get alert message
    should be equal  ${アラートメッセージ}  キャンセルされました


JSのpromptに入力する
    click element  id=show_prompt

    # 前のテストでchoose cancel on next confirmationが使われていた場合は正しく動作しなくなるため、
    # choose ok on next confirmationでデフォルト値に戻しておく
    choose ok on next confirmation

    # Input Text Into Promptでプロンプトに入力する
    # http://robotframework.org/Selenium2Library/Selenium2Library.html#Input%20Text%20Into%20Prompt
    input text into prompt  プロンプトに入力しました

    # Input Text Into Promptは入力するだけなので、忘れずにOKボタンを押す
    confirm action
    ${アラートメッセージ} =  get alert message
    should be equal  ${アラートメッセージ}  プロンプトに入力しました


JSのリロードを確認する
    # Assign Id To Elementを使って、リロード前にタグを設定し、リロード後にタグが存在しないことを確認すれば良い
    # http://robotframework.org/Selenium2Library/Selenium2Library.html#Assign%20Id%20To%20Element

    # 第一引数に`id=`を付けるとエラーになる
    # assign id to element  id=reload_dummy  not_reload
    # => 「Keyword 'Selenium2Library.Assign Id To Element' got positional argument after named arguments.」
    # locatorがclassやxpathならば動くっぽい
    # assign id to element  class=reload_element  not_reload

    # locatorを省略する場合は、idかnameで探してくれる
    assign id to element  run_reload  not_reload

    # assign id to elementはidの付け替えをするので、
    # リロードボタンのidがrun_reloadからnot_reloadへと変わってしまうことに注意
    page should contain element  id=not_reload

    # なので、id=run_reloadは存在しない
    # もし付け替わっては困る場合、適当なelementにidを付けてあげると良い
    page should not contain element  id=run_reload

    # 付け替えた後のidを指定してクリックする
    click element  id=not_reload

    # リロードするとidの値は元に戻る
    page should contain element  id=run_reload
    page should not contain element  id=not_reload


JSで見えないボタンを強引にクリックする
    # JavaScriptを使って強引にクリックする
    # https://groups.google.com/forum/#!msg/robotframework-users/pF508-UTBLU/mmJlLQGRNQAJ
    execute javascript  document.getElementById('display_none').click();

    # http://robotframework.org/Selenium2Library/Selenium2Library.html#Location%20Should%20Be
    location should be  http://localhost:8084/

    # 次のテストができるよう、jsのページへと移動しておく
    JSページへ移動する


マウスオーバーすると出てくるelementをクリックする
    # http://robotframework.org/Selenium2Library/Selenium2Library.html#Mouse%20Over
    mouse over  id=on_mouse_area

    click element  id=mouse_target

    # http://robotframework.org/Selenium2Library/Selenium2Library.html#Location%20Should%20Be
    location should be  http://localhost:8084/

    # 次のテストができるよう、jsのページへと移動しておく
    JSページへ移動する


スクロールしてクリックする
    # http://robotframework.org/Selenium2Library/Selenium2Library.html#Get%20Window%20Size
    ${幅}  ${高さ} =  get window size
    # http://robotframework.org/Selenium2Library/Selenium2Library.html#Set%20Window%20Size
    set window size  10  10

    # JavaScriptを使ってスクロールする
    # https://developer.mozilla.org/ja/docs/Web/API/Window/scrollTo
    execute javascript  window.scrollTo(0, 1200)

    click element  id=bottom_button
    alert should be present

    # サイズを戻しておく
    set window size  ${幅}  ${高さ}


「${キーワード}」が失敗するのを確認する
    ${成否} =  Run Keyword And Return Status  ${キーワード}
    should be equal  ${成否}  ${False}


*** TestCases ***
JavaScriptのテスト
    Chromeを起動してJSページへ移動する

    elementが出てくるまで待つ

    マウスオーバーすると出てくるelementをクリックする

    スクロールしてクリックする

    JSで見えないボタンを強引にクリックする

    JSのリロードを確認する

    # JavaScriptで表示する系
    JSのalertでOKを押す
    JSのalertでメッセージを取得してOKを押す
    JSのalertが表示されていることを確認してOKを押す
    JSのalertが表示されておりメッセージも一致しているかを確認してOKを押す
    JSのalertの表示に時間がかかってもOKを押す

    JSのconfirmでOKを押す
    JSのconfirmでキャンセルを押す

    JSのpromptに入力する


HeadlessなChromeのテスト
    HeadlessなChromeを起動してJSページへ移動する
    elementが出てくるまで待つ
    マウスオーバーすると出てくるelementをクリックする

    JSで見えないボタンを強引にクリックする
    JSのリロードを確認する

    # 環境のせいなのか、スクロールしてクリックしようとすると、
    # 「ElementNotVisibleException: Message: element not visible」エラー
    「スクロールしてクリックする」が失敗するのを確認する

    # Chrome v60の場合、alert系は失敗する(There were no alerts)
    # PhantomJSも同様に、alert系は失敗する
    「JSのalertでOKを押す」が失敗するのを確認する
    「JSのalertでメッセージを取得してOKを押す」が失敗するのを確認する
    「JSのalertが表示されていることを確認してOKを押す」が失敗するのを確認する
    「JSのalertが表示されておりメッセージも一致しているかを確認してOKを押す」が失敗するのを確認する
    「JSのalertの表示に時間がかかってもOKを押す」が失敗するのを確認する

    「JSのconfirmでOKを押す」が失敗するのを確認する
    「JSのconfirmでキャンセルを押す」が失敗するのを確認する

    「JSのpromptに入力する」が失敗するのを確認する
