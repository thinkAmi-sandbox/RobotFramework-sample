*** Settings ***

Library  SeleniumLibrary


Test Teardown  close all browsers


*** Keywords ***
URIスキーム無しでlocalhostへアクセスする
    go to  localhost:8084/
    location should be  http://localhost:8084/

URIスキームありでlocalhostへアクセスする
    go to  http://localhost:8084/
    location should be  http://localhost:8084/

URIスキーム無しでGoogleへアクセスする
    go to  www.google.co.jp/
    location should be  https://wwww.google.co.jp/

URIスキームありでGoogleへアクセスする
    go to  https://www.google.co.jp/
    location should be  https://www.google.co.jp/

キーワード「${キーワード}」が失敗することを確認する
    ${エラー有無}  ${エラーメッセージ} =  run keyword and ignore error  ${キーワード}
    should be equal  ${エラー有無}  FAIL
    log to console  エラーメッセージ：\n${エラーメッセージ}\n_______________


*** TestCases ***
ノーマルなChromeでURIスキームを扱う
    create webdriver  Chrome
    log to console  ${SPACE}

    URIスキーム無しでlocalhostへアクセスする
    URIスキームありでlocalhostへアクセスする
    キーワード「URIスキーム無しでGoogleへアクセスする」が失敗することを確認する
    URIスキームありでGoogleへアクセスする


HeadlessなChromeでURIスキームを扱う
    ${options} =  evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys
    call method  ${options}  add_argument  --headless
    create webdriver  Chrome  chrome_options=${options}
    log to console  ${SPACE}

    キーワード「URIスキーム無しでlocalhostへアクセスする」が失敗することを確認する
    URIスキームありでlocalhostへアクセスする
    キーワード「URIスキーム無しでGoogleへアクセスする」が失敗することを確認する
    URIスキームありでGoogleへアクセスする
