*** Settings ***

# Libraryは大文字小文字の区別があるようで、libraryとしてしまうとIDEが認識しない
Library  Selenium2Library


Test Setup  ブラウザを起動してindexへ移動する
Test Teardown  ブラウザを終了する


*** Keywords ***
ブラウザを起動してindexへ移動する
    create webdriver  Chrome
    go to  localhost:8084


ブラウザを終了する
    # テストごとにブラウザを閉じてキャッシュをリセットする
    # http://robotframework.org/Selenium2Library/Selenium2Library.html#Close%20All%20Browsers
    close all browsers


現在のURLを確認する
    # https://stackoverflow.com/questions/31833624/how-to-get-the-current-url-in-robot-framework
    ${url} =  get location
    # プロトコル、および、必要に応じて末尾のスラッシュを付けたものが取得できる
    should be equal  ${url}  http://localhost:8084/


ページにelememtや文字列があるか確認する
    # ページに「Hello, world!」の文字列が含まれる
    page should contain  Hello,${SPACE}world!

    # ページにid=helloのelementが含まれる
    page should contain element  id=hello


件数の確認
    # XPATHを使って、liタグのテキストが「エレメント」である件数を数える
    ${counter} =  get matching xpath count  //li[text()='エレメント']
    should be equal  ${counter}  3

    # 一行でやる場合
    xpath should match x times  //li[text()='エレメント']  3


ページのテキストの確認
    # id=helloのelementのテキストがHello, world!
    element text should be  id=hello  Hello,${SPACE}world!

    # id=helloのelementのテキストにworldが含まれる
    ${contain_item} =  get text  id=hello
    should contain  ${contain_item}  world

    # get textした時にstrongやemが無視される
    ${get_text} =  get text  id=get_text
    should be equal  ${get_text}  prefix-normal prefix-strong em-text suffix-strong suffix-normal


locatorの確認
    # http://robotframework.org/Selenium2Library/Selenium2Library.html

    # id
    page should contain element  id=locator_id

    # name
    page should contain element  name=locator_name

    # identifier
    page should contain element  identifier=locator_id
    page should contain element  identifier=locator_name

    # xpath
    # http://qiita.com/merrill/items/aa612e6e865c1701f43b
    page should contain element  xpath=/html/body/button[@class="locator_class"]
    page should contain element  xpath=//button[@class="locator_class"]
    # andを使う
    element text should be  xpath=//button[@class="locator_class" and @disabled]  locator_text2
    # containを使う(第二引数は文字列をクォートで囲む)
    element text should be  xpath=//button[@class="locator_class" and contains(@data-hoge, "spam")]  locator_text2
    # notを使う
    element text should be
    ...  xpath=//button[@class="locator_class_foo" and not(contains(@data-hoge, "egg"))]  locator_text4

    # css
    page should contain element  css=#locator_id
    page should contain element  css=button.locator_class
    # 少し複雑なもの：nth-childは1始まり
    # http://csspro.digitalskill.jp/%E3%83%81%E3%83%A5%E3%83%BC%E3%83%88%E3%83%AA%E3%82%A2%E3%83%AB/nth-child%E3%81%AE%E4%BD%BF%E3%81%84%E6%96%B9
    element text should be  css=#locator_css > ul:nth-child(2) > li:last-child > p  対象

    # jquery
    # locatorでjqueryを使う場合、html側にjqueryを読み込む設定が必要
    # https://github.com/robotframework/Selenium2Library/issues/262
    # 無い場合、「WebDriverException: Message: unknown error: jQuery is not defined」エラー
    page should contain image  jquery=img[alt='あの字']
    page should contain image  jquery=img[title='画像タイトル']


画像をaltやtitleなどの属性で検索する
    # jqueryを使うのが簡単
    page should contain image  jquery=img[alt='あの字']
    page should contain image  jquery=img[title='画像タイトル']


画像のソースを取得する
    # css
    ${src} =  get element attribute  css=#img_200@src
    ${url} =  get location
    should be equal  ${src}  ${url}static/image/a.png


visibleとenableとcontainの違い
    # display:noneとvisibility:hiddenはvisibleではないが、disabledはvisible
    element should not be visible  id=element_display_none
    element should not be visible  id=element_visibility_hidden
    element should be visible  id=element_disabled

    # display:noneとvisibility:hiddenはenabledだが、disabledはdisabled
    element should be enabled  id=element_display_none
    element should be enabled  id=element_visibility_hidden
    element should be disabled  id=element_disabled

    # elementとしては全て含まれている
    page should contain element  id=element_display_none
    page should contain element  id=element_visibility_hidden
    page should contain element  id=element_disabled


elementが見えている時に何かをする
    # ログを見やすくするため改行を出力しておく
    log to console  ${SPACE}

    # https://stackoverflow.com/questions/30622498/robot-framework-if-element-is-visible-execute-a-keyword
    # 見えてる
    ${visible} =  run keyword and return status  element should be visible  id=visible_button
    run keyword if  ${visible}  log to console  見えてます

    # 見えてない
    ${invisible} =  run keyword and return status  element should be visible  id=invisible_button
    # 「run keyword unless」を使うことで、第一引数がfalseの時に log to console する
    run keyword unless  ${invisible}  log to console  見えてないです


テーブルを検索する
    # 行番号(row)にはヘッダ行(th)も含まれていることに注意
    # また、「table row should contain」は、指定した行のどこかの列にその文字列があればPASSする
    table row should contain  css=#table_search > table:nth-child(2)  3  項目2
    table row should contain  css=#table_search > table:nth-child(2)  3  値2

    # 行・列の組み合わせで調べたい時は、「table cell should contain」を使う
    # 行、列、値の順で指定する
    table cell should contain  css=#table_search > table:nth-child(2)  3  2  値2


*** TestCases ***
静的HTML(indexページ)のテスト
    現在のURLを確認する

    ページにelememtや文字列があるか確認する

    件数の確認

    ページのテキストの確認

    locatorの確認

    visibleとenableとcontainの違い

    elementが見えている時に何かをする

    テーブルを検索する

    画像をaltやtitleなどの属性で検索する

    画像のソースを取得する
