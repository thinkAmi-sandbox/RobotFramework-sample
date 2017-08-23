*** Settings ***
Library  Selenium2Library


*** Keywords ***
リファラが書き換わっているかを確認する
        # Chrome拡張をSeleniumに追加する
        ${options} =  evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys

        # HeadlessだとChrome拡張ページが開けない
        # call method  ${options}  add_argument  --headless

        # テストはtests/ディレクトリの中で実行するので、${OUTPUT_DIR}もtests/になる
        # そのため、crxファイルもtests/ディレクトリに置いておく
        # なお、今回のリポジトリには「Referer Control」拡張のcrxファイルはコミットしてないため、
        # Chrome拡張「Get CRX」などを使ってcrxファイルを用意する必要あり
        call method  ${options}  add_extension  ${OUTPUT DIR}/referer_control.crx
        create webdriver  Chrome  chrome_options=${options}

        # 「Referer Control」拡張の設定ページを開く
        go to  chrome-extension://hnkcfpcejkafcihlgbojoidoihckciin/chrome/content/options.html

        wait until page contains element  xpath=//*[@id="settingsTable"]/tbody/tr/td[2]/input
        click element  xpath=//*[@id="settingsTable"]/tbody/tr/td[2]/input
        # site filterに入力する
        # 今回は、「http://localhost:8084/referer/target」というサイトであればリファラを書き換える
        input text     xpath=//*[@id="settingsTable"]/tbody/tr/td[2]/input  http://localhost:8084/referer/target
        # Customボタンを押す
        click element  xpath=//*[@id="settingsTable"]/tbody/tr/td[8]

        # Custom refererを入力する(Googleから来たことにする)
        # 1秒待たないとうまくいかない
        sleep  1s
        input text  xpath=//*[@id="settingsTable"]/tbody/tr[5]/td[2]/table/tbody/tr[1]/td[1]/input  https://www.google.co.jp
        # 適当なところをクリックして保存
        click element  xpath=//*[@id="settingsTable"]/tbody/tr/td[2]/input

        # リファラが書き換わるページへアクセス
        go to  http://localhost:8084/referer/target
        ${target} =  get text  id=referer

        # リファラが書き換わらないページへアクセス
        go to  http://localhost:8084/referer/exclude
        ${exclude} =  get text  id=referer

        # 検証してブラウザを閉じる
        log to console  ${EMPTY}
        log to console  ${target}
        log to console  ${exclude}
        should not be equal  ${target}  ${exclude}
        close browser


*** TestCases ***
Chrome拡張でリファラを書き換えるテスト
    リファラが書き換わっているかを確認する
