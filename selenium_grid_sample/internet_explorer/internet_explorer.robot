*** Settings ***

# Libraryは大文字小文字の区別があるようで、libraryとしてしまうとIDEが認識しない
Library  SeleniumLibrary


*** Keywords ***
GoogleでPythonを検索してスクリーンショットを撮り、結果を出力する
    ${caps} =  create dictionary  browserName=internet explorer  platform=WINDOWS
    # Remoteを使う場合は、以下の記事を参考にすると良いかも
    # https://stackoverflow.com/questions/34507901/opening-chrome-browser-in-android-device-using-robot-framework-script-and-chrome
    create webdriver  Remote  command_executor=http://192.168.10.103:4444/wd/hub  desired_capabilities=${caps}
    # Googleのトップ画面を開く
    go to  https://www.google.co.jp/

    # タイトルにGoogleが含まれていることを確認する
    ${page_title} =  get title
    should contain  ${page_title}  Google

    # 検索後を入力して送信する
    input text  name=q  Python
    # Robot FrameworkではEnterキーは\\13になる
    # https://github.com/robotframework/Selenium2Library/issues/4っｚ１
    press key  name=q  \\13

    # Ajax遷移のため、適当に2秒待つ
    sleep  2sec

    # タイトルにPythonが含まれていることを確認する
    ${result_title} =  get title
    should contain  ${result_title}  Python

    # スクリーンショットを撮る
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
