*** Settings ***
Library  SeleniumLibrary


*** Keywords ***
set_headlessメソッドがない場合はテストをパスする
    ${version} =  evaluate  selenium.__version__  selenium
    ${selenium_version} =  evaluate  importlib.import_module('distutils.version').LooseVersion($version)  importlib
    # set_headlessメソッドは、python seleniumの3.8.0以降に実装された
    ${min_version} =  evaluate  importlib.import_module('distutils.version').LooseVersion('3.8.0')  importlib

    Pass Execution If  $selenium_version < $min_version  seleniumが${min_version}以上でないと動作しません


set_headlessメソッドを使ってHeadlessなChromeを起動する
    set_headlessメソッドがない場合はテストをパスする
    ${options} =  evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys
    Call Method  ${options}  set_headless
    Create Webdriver  Chrome  chrome_options=${options}


add_argumentメソッドを使ってHeadlessなChromeを起動する
    # https://groups.google.com/d/msg/robotframework-users/gPsiVaMo19A/cBRH7mr2BAAJ
    ${options} =  evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys
    Call Method  ${options}  add_argument  --headless
    Create Webdriver  Chrome  chrome_options=${options}


GoogleでPythonを検索してスクリーンショットを撮り、結果を出力する
    # 以下のコードをRobot Framework風にした
    # http://qiita.com/orangain/items/db4594113c04e8801aad

    # Googleのトップ画面を開く
    Go To  https://www.google.co.jp/

    # タイトルにGoogleが含まれていることを確認する
    ${page_title} =  get title
    Should Contain  ${page_title}  Google

    # 検索後を入力して送信する
    Input Text  name=q  Python
    # Robot FrameworkではEnterキーは\\13になる
    # https://github.com/robotframework/Selenium2Library/issues/4
    Press Key  name=q  \\13

    # Ajax遷移のため、適当に2秒待つ
    Sleep  2sec

    # タイトルにPythonが含まれていることを確認する
    ${result_title} =  get title
    should contain  ${result_title}  Python

    # スクリーンショットを撮る
    Capture Page Screenshot  filename=result_google_python2.png

    # ログを見やすくするために改行を入れる
    Log To Console  ${SPACE}

    # 検索結果を表示する
    # ForでElementを回したかったことから、WebElementを取得し、そのAPIを利用する
    # http://robotframework.org/Selenium2Library/Selenium2Library.html#Get%20Webelements
    # https://stackoverflow.com/a/42508200
    @{web_elements} =  Get Webelements  css=h3 > a
    :For  ${web_element}  In  @{web_elements}
    \  ${text} =  Get Text  ${web_element}
    \  Log To Console  ${text}
    # 以下を参考に、WebElementからattribute(href)を取得
    # https://groups.google.com/d/msg/robotframework-users/xx3KYxpDu_w/0hyulqKPKQAJ
    # http://seleniumhq.github.io/selenium/docs/api/py/webdriver_remote/selenium.webdriver.remote.webelement.html#selenium.webdriver.remote.webelement.WebElement.get_attribute
    \  ${href} =  Call Method  ${web_element}  get_attribute  href
    \  Log To Console  ${href}

    # ブラウザを終了する
    Close Browser


*** TestCases ***
add_argumentメソッドを使ってHeadlessなChromeを起動しテストする
    add_argumentメソッドを使ってHeadlessなChromeを起動する
    GoogleでPythonを検索してスクリーンショットを撮り、結果を出力する

set_headlessメソッドを使ってHeadlessなChromeを起動しテストする
    set_headlessメソッドを使ってHeadlessなChromeを起動する
    GoogleでPythonを検索してスクリーンショットを撮り、結果を出力する
