*** Settings ***

# 準備
# HomebrewでImageMagickを入れる
# $ brew install imagemagick

# Libraryは大文字小文字の区別があるようで、libraryとしてしまうとIDEが認識しない
Library  Selenium2Library
# Runキーワードのために、OperatingSystemライブラリを使う
# http://robotframework.org/robotframework/latest/libraries/OperatingSystem.html
Library  OperatingSystem


*** Keywords ***
スクリーンショットを撮って差分を確認する
    # headlessなChromeで確認する
    # Chromeはv60、chromedriverは2.31である必要がある
    # (スクリーンショット撮影機能に不具合があるため)
    ${options} =  evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys
    call method  ${options}  add_argument  --headless
    create webdriver  Chrome  chrome_options=${options}

    # ImageMagickのトップページへ
    go to  https://www.imagemagick.org/script/index.php

    # リロード前にスクリーンショットを撮る
    capture page screenshot  filename=before1.png

    # もう一度、リロード前のスクリーンショットを撮る
    capture page screenshot  filename=before2.png

    # ページをリロードする：たぶん広告が変わるはず
    # http://robotframework.org/Selenium2Library/Selenium2Library.html#Reload%20Page
    reload page

    # after.pngという名前でスクリーンショットを撮る
    capture page screenshot  filename=after.png

    # ブラウザを閉じる
    close browser

    # ImageMagickを使って、差分があるかを確認する
    # http://robotframework.org/robotframework/latest/libraries/OperatingSystem.html#Run%20And%20Return%20Rc%20And%20Output
    # http://qiita.com/pekepek/items/d91baa27be95e01b7696
    ${rc}  ${output} =  run and return rc and output  compare -metric AE before1.png before2.png diff1.png

    # リロードする前なので、差分はないはず
    run keyword if  ${output} == 0  log to console  差分はありません

    ${rc}  ${output} =  run and return rc and output  compare -metric AE before1.png after.png diff2.png

    # リロード後は差分があるはずなので、差分を表示する
    # http://robotframework.org/robotframework/latest/libraries/OperatingSystem.html#Run
    run keyword if  ${output} != 0  run  open diff2.png


*** TestCases ***

ImageMagickサイトでのテスト
    スクリーンショットを撮って差分を確認する
