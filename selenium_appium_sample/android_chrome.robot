*** Settings ***

Library  SeleniumLibrary


*** Keywords ***
GoogleでPythonを検索してスクリーンショットを撮り、結果を出力する
    # 以下のコードをRobot Framework風にした
    # http://qiita.com/orangain/items/db4594113c04e8801aad

    # 以下を参考に、Chromeのオプションを追加して、Chromeを起動する
    # https://sites.google.com/a/chromium.org/chromedriver/getting-started/getting-started---android
    ${options} =  evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys
    call method  ${options}  add_experimental_option  androidPackage  com.android.chrome
    create webdriver  Chrome  chrome_options=${options}

    # Googleのトップ画面を開く
    go to  https://www.google.co.jp/

    # タイトルにGoogleが含まれていることを確認する
    ${page_title} =  get title
    should contain  ${page_title}  Google

    # 検索後を入力してEnter
    input text  name=q  Python
    # Robot FrameworkではEnterキーは\\13になる
    # https://github.com/robotframework/Selenium2Library/issues/4
    press key  name=q  \\13

    # Ajax遷移のため、適当に2秒待つ
    sleep  2sec

    # タイトルにPythonが含まれていることを確認する
    ${result_title} =  get title
    should contain  ${result_title}  Python

    # スクリーンショットを撮る
    capture page screenshot  filename=result_google_python_android.png

    # ログを見やすくするために改行を入れる
    log to console  ${SPACE}

    # 検索結果を表示する
    @{web_elements} =  get webelements  css=h3 > a
    :for  ${web_element}  in  @{web_elements}
    \  ${text} =  get text  ${web_element}
    \  log to console  ${text}
    \  ${href} =  call method  ${web_element}  get_attribute  href
    \  log to console  ${href}

    # ブラウザを終了する
    close browser


*** TestCases ***

GoogleでPythonを検索するテスト
    GoogleでPythonを検索してスクリーンショットを撮り、結果を出力する
