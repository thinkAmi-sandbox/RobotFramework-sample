*** Settings ***

# Libraryは大文字小文字の区別があるようで、libraryとしてしまうとIDEが認識しない
Library  SeleniumLibrary
Library  RequestsLibrary


# テストが失敗してもブラウザを必ず終了したいため、Test Teardownにブラウザを閉じるのを書く
Test Teardown  close all browsers


*** Keywords ***
RobotFramework-Requestを使ってイメージファイルが存在するか確認する
    # https://stackoverflow.com/a/24532956
    # 「page should contain image」や「element should be visible」だとimgタグのチェックだけで、
    # 本当にファイルが存在してるかまではチェックできていない
    # 実際には↓の場合はファイルは存在していないのにもかかわらず、テストはパスする
    page should contain image  id=img_404
    element should be visible  id=img_404

    # robotframework-requestsを使って、実際にファイルがあるかを確認する
    # https://github.com/bulkan/robotframework-requests
    # 忘れずに「library  RequestsLibrary」を追加する
    page should contain image  id=img_200
    element should be visible  id=img_200
    # http://robotframework.org/Selenium2Library/Selenium2Library.html#Get%20Element%20Attribute
    ${src404} =  get element attribute  id=img_404@src
    log to console  ${src404}

    create session  not-found-session  ${src404}
    # getキーワードを使うと「Deprecation Warning: Use Get Request in the future」
    # http://bulkan.github.io/robotframework-requests/
    ${response404} =  get request  not-found-session  /
    should be equal as integers  ${response404.status_code}  404
    should be equal as strings  ${response404.status_code}  404
    log to console  ${response404}

    # 存在するパターンはこちら
    ${src200} =  get element attribute  id=img_200@src
    log to console  ${src200}

    create session  found-session  ${src200}
    ${response200} =  get request  found-session  /
    should be equal as strings  ${response200.status_code}  200
    log to console  ${response200}


*** TestCases ***
Reequestsのテスト
    create webdriver  Chrome
    go to  http://localhost:8084/image-exist

    # 改行のため一つコンソールへ出しておく
    log to console  ${SPACE}

    RobotFramework-Requestを使ってイメージファイルが存在するか確認する
