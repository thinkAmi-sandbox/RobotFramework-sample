*** Settings ***

# Libraryは大文字小文字の区別があるようで、libraryとしてしまうとIDEが認識しない
Library  Selenium2Library


*** Keywords ***
GoogleでPythonを検索してスクリーンショットを撮り、結果を出力する
    # 以下のコードをRobot Framework風にした
    # http://qiita.com/orangain/items/db4594113c04e8801aad

    # 以下を参考に、Chromeのオプションを追加して、Chromeを起動する
    # https://groups.google.com/d/msg/robotframework-users/gPsiVaMo19A/cBRH7mr2BAAJ
    ${options} =  evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys
    call method  ${options}  add_argument  --headless
    create webdriver  Chrome  chrome_options=${options}

    # Googleのトップ画面を開く
    go to  https://www.google.co.jp/

    # タイトルにGoogleが含まれていることを確認する
    ${page_title} =  get title
    should contain  ${page_title}  Google

    # 検索後を入力して送信する
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
    # stableなChrome59だと、1x1の画像しか撮れない...
    capture page screenshot  filename=result_google_python.png

    # ログを見やすくするために改行を入れる
    log to console  ${SPACE}

    # 検索結果を表示する
    # ForでElementを回したかったことから、WebElementを取得し、そのAPIを利用する
    # http://robotframework.org/Selenium2Library/Selenium2Library.html#Get%20Webelements
    # https://stackoverflow.com/a/42508200
    @{web_elements} =  get webelements  css=h3 > a
    :for  ${web_element}  in  @{web_elements}
    \  ${text} =  get text  ${web_element}
    \  log to console  ${text}
    # 以下を参考に、WebElementからattribute(href)を取得
    # https://groups.google.com/d/msg/robotframework-users/xx3KYxpDu_w/0hyulqKPKQAJ
    # http://seleniumhq.github.io/selenium/docs/api/py/webdriver_remote/selenium.webdriver.remote.webelement.html#selenium.webdriver.remote.webelement.WebElement.get_attribute
    \  ${href} =  call method  ${web_element}  get_attribute  href
    \  log to console  ${href}

    # ブラウザを終了する
    close browser


*** TestCases ***

GoogleでPythonを検索するテスト
    GoogleでPythonを検索してスクリーンショットを撮り、結果を出力する







