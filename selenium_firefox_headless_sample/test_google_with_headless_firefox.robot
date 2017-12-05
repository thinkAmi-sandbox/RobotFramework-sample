*** Settings ***
Library  SeleniumLibrary


*** Keywords ***
Headlessのつもりが普通のFirefoxが起動する
    ${binary} =  Evaluate  sys.modules['selenium.webdriver.firefox.firefox_binary'].FirefoxBinary()  sys
    Call Method  ${binary}  add_command_line_options  -headless
    Create Webdriver  Firefox  firefox_binary=${binary}


set_headlessメソッドがない場合はテストをパスする
    ${version} =  Evaluate  selenium.__version__  selenium
    ${selenium_version} =  Evaluate  importlib.import_module('distutils.version').LooseVersion($version)  importlib
    # set_headlessメソッドは、python seleniumの3.8.0以降に実装された
    ${min_version} =  Evaluate  importlib.import_module('distutils.version').LooseVersion('3.8.0')  importlib

    Pass Execution If  $selenium_version < $min_version  seleniumが${min_version}以上でないと動作しません


set_headlessメソッドを使ってHeadlessなFirefoxを起動する
    set_headlessメソッドがない場合はテストをパスする
    ${options} =  Evaluate  sys.modules['selenium.webdriver.firefox.options'].Options()  sys
    Call Method  ${options}  set_headless
    Create Webdriver  Firefox  firefox_options=${options}


add_argumentメソッドを使ってHeadlessなFirefoxを起動する
     ${options} =  Evaluate  sys.modules['selenium.webdriver.firefox.options'].Options()  sys
     Call Method  ${options}  add_argument  -headless
     Create Webdriver  Firefox  firefox_options=${options}


GoogleでPythonを検索してスクリーンショットを撮り、結果を出力する
    # Googleのトップ画面を開く
    Go To  https://www.google.co.jp/

    # タイトルにGoogleが含まれていることを確認する
    ${page_title} =  Get Title
    Should Contain  ${page_title}  Google

    # 検索後を入力して送信する
    Input Text  name=q  Python
    Press Key  name=q  \\13

    # Ajax遷移のため、適当に2秒待つ
    Sleep  2sec

    # タイトルにPythonが含まれていることを確認する
    ${result_title} =  Get Title
    Should Contain  ${result_title}  Python

    # スクリーンショットを撮る
    Capture Page Screenshot  filename=result_google_python.png

    # ログを見やすくするために改行を入れる
    Log To Console  ${SPACE}

    # 検索結果を表示する
    @{web_elements} =  Get Webelements  css=h3 > a
    :For  ${web_element}  In  @{web_elements}
    \  ${text} =  Get Text  ${web_element}
    \  Log To Console  ${text}
    \  ${href} =  Call Method  ${web_element}  get_attribute  href
    \  Log To Console  ${href}

    # ブラウザを終了する
    Close Browser


*** TestCases ***
add_argumentメソッドを使ってHeadlessなFirefoxを起動しテストする
    add_argumentメソッドを使ってHeadlessなFirefoxを起動する
    GoogleでPythonを検索してスクリーンショットを撮り、結果を出力する

set_headlessメソッドを使ってHeadlessなFirefoxを起動しテストする
    set_headlessメソッドを使ってHeadlessなFirefoxを起動する
    GoogleでPythonを検索してスクリーンショットを撮り、結果を出力する
