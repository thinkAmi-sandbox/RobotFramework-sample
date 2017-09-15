*** Settings ***

# Libraryは大文字小文字の区別があるようで、libraryとしてしまうとIDEが認識しない
Library  SeleniumLibrary

# テストケースごとにブラウザを閉じる
Test Teardown  close browser

*** Keywords ***
Googleのトップページでスクリーンショットを撮る
    # iOSシミュレータを使うためのDesired Capabilitiesを設定する
    # platformVersionとdeviceNameはXcodeで作成した内容を指定
    ${caps}=  create dictionary  browserName=safari  platformName=iOS  platformVersion=10.2
    ...                          deviceName=iOS10.2 for RF

    # WebDriverにはRemote、command_executorにはAppiumの待ち受けているURL、
    # desired_capabilitiesには作成したDesired Capabilitiesをそれぞれ指定
    create webdriver  Remote  command_executor=http://localhost:4723/wd/hub  desired_capabilities=${caps}

    # Googleのトップページを開く
    go to  https://www.google.co.jp/

    # スクリーンショットを撮る
    capture page screenshot  filename=result_google_top.png


GoogleでPythonを検索してスクリーンショットを撮り、結果を出力する
    ${caps}=  create dictionary  browserName=safari  platformName=iOS  platformVersion=10.2
    ...                          deviceName=iOS10.2 for RF
    create webdriver  Remote  command_executor=http://localhost:4723/wd/hub  desired_capabilities=${caps}
    go to  https://www.google.co.jp/

    # タイトルにGoogleが含まれていることを確認する
    ${page_title} =  get title
    should contain  ${page_title}  Google

    # 検索語を入力して送信する
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
    capture page screenshot  filename=result_google_python.png

    # ログを見やすくするために改行を入れる
    log to console  ${SPACE}

    # 検索結果を表示する
    @{web_elements} =  get webelements  css=h3 > a
    :for  ${web_element}  in  @{web_elements}
    \  ${text} =  get text  ${web_element}
    \  log to console  ${text}
    \  ${href} =  call method  ${web_element}  get_attribute  href
    \  log to console  ${href}


*** TestCases ***

Googleのトップページに関するテスト
    [Tags]  top
    Googleのトップページでスクリーンショットを撮る

GoogleでPythonを検索するテスト
    [Tags]  python
    GoogleでPythonを検索してスクリーンショットを撮り、結果を出力する
