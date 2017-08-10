*** Settings ***

Library  Selenium2Library

# テストごとにブラウザを開く
Test Setup  create webdriver  Chrome

# テストごとにブラウザを閉じてキャッシュをリセットする
# http://robotframework.org/Selenium2Library/Selenium2Library.html#Close%20All%20Browsers
Test Teardown  close all browsers


*** Variables ***
${INPUT_TEXT}  件名を入力する
@{EXPECTED_MULTI_SELECTION}  紙  容器


*** Keywords ***

送信ボタンをクリックする
    フォームページへ移動する
    click button  id=id_submit

    POST後のページにいることを確認する


送信ボタンでEnterキーを押す
    フォームページへ移動する

    # clickを使わなくても、Enterキーを押すことでもPOSTできる
    # なお、有効なelement(今回はsubmitボタン)をlocatorで指定する必要がある
    # https://stackoverflow.com/questions/37199594/robot-framework-any-alternative-to-selenium2librarys-input-text-for-enterin
    press key  id=id_submit  \\13
    POST後のページにいることを確認する


リンクをクリックする(ClickElement版)
    フォームページへ移動する
    # click elementでエレメントをクリックする
    # http://robotframework.org/Selenium2Library/Selenium2Library.html#Click%20Element
    click element  id=back_to_top
    トップページにいることを確認する

リンクをクリックする(ClickLink版)
    フォームページへ移動する
    # click linkでもリンクをクリックできる
    # http://robotframework.org/Selenium2Library/Selenium2Library.html#Click%20Link
    click link  id=back_to_top
    トップページにいることを確認する


フォームページへ移動する
    # フォームページにいないなら移動する
    ${成否} =  run keyword and return status  フォームページにいることを確認する
    run keyword unless  ${成否}  go to  http://localhost:8084/form

フォームページにいることを確認する
    page should contain element  id=id_form


POST後のページにいることを確認する
    page should contain element  id=form_values


トップページにいることを確認する
    page should contain element  id=hello


input_textにテキスト「${input_value}」を入力する
    フォームページへ移動する
    # http://robotframework.org/Selenium2Library/Selenium2Library.html#Input%20Text
    input text  id=id_subject  ${input_value}
    送信ボタンをクリックする


input_passwordにパスワード「${password_value}」を入力する
    フォームページへ移動する
    input password  id=id_password  ${password_value}
    送信ボタンをクリックする


ラジオボタンを選択する
    フォームページへ移動する
    # http://robotframework.org/Selenium2Library/Selenium2Library.html#Select%20Radio%20Button
    # 第一引数はグループ名(name属性)、第二引数は実際の値を指定
    select radio button  fruit  りんご
    # ラジオボタンの確認も同様
    # http://robotframework.org/Selenium2Library/Selenium2Library.html#Radio%20Button%20Should%20Be%20Set%20To
    radio button should be set to  fruit  りんご

    # click elementでもOK
    click element  id=id_small
    radio button should be set to  fruit_size  小さいもの

    送信ボタンをクリックする


単一選択のみ可能なselectにて選択する
    フォームページへ移動する

    # selectをラベルで選択する
    # ラベルとは「<select>ここ</select>」の「ここ」に記載されたもの
    # locatorには<select>タグのidなどを指定
    # http://robotframework.org/Selenium2Library/Selenium2Library.html#Select%20From%20List%20By%20Label
    select from list by label  id=id_quantity  2
    # 選択したものの検証
    # 第二引数はselectのラベル・valueなどを指定可能(idやnameは不可)
    # http://robotframework.org/Selenium2Library/Selenium2Library.html#List%20Selection%20Should%20Be
    list selection should be  id=id_quantity  2
    list selection should be  id=id_quantity  2個

    # selectをindexで選択する
    # indexはゼロ始まり
    select from list by index  id=id_quantity  0
    list selection should be  id=id_quantity  1

    # selectをvalueで選択する
    select from list by value  id=id_quantity  3個
    list selection should be  id=id_quantity  3

    # 選択したラベルを取得する
    # http://robotframework.org/Selenium2Library/Selenium2Library.html#Get%20Selected%20List%20Label
    ${選択ラベル} =  get selected list label  id=id_quantity
    should be equal  ${選択ラベル}  3

    # 選択した値を取得する
    # http://robotframework.org/Selenium2Library/Selenium2Library.html#Get%20Selected%20List%20Value
    ${選択値} =  get selected list value  id=id_quantity
    should be equal  ${選択値}  3個

    # selectのoptionにある件数を確認
    # https://stackoverflow.com/questions/24427969/check-whether-selectbox-has-items-robot-framework-selenium2library
    # get list itemsを使う方法
    # get list itemsはリスト型の変数になる
    @{items} =  get list items  id=id_quantity
    # get lengthでは引数にスカラ変数を取るため、波括弧の前を@から$へと切り替える
    # http://robotframework.org/robotframework/latest/libraries/BuiltIn.html#Get%20Length
    ${list_length} =  get length  ${items}
    should be equal as integers  ${list_length}  3

    # get matching xpath countを使う方法
    ${list_count} =  get matching xpath count  //select[@id="id_quantity"]/option
    should be equal as integers  ${list_count}  3

    送信ボタンをクリックする


複数選択可能なselectにて選択する
    フォームページへ移動する

    # 「unselect from list」は複数選択可能なものだけ実行できる
    # なお、「Unselect From List By Label」などのほうが速いらしい
    # http://robotframework.org/Selenium2Library/Selenium2Library.html#Unselect%20From%20List
    unselect from list  id=id_accessories
    # selectで一つも選んでないことを確認
    # http://robotframework.org/Selenium2Library/Selenium2Library.html#List%20Should%20Have%20No%20Selections
    list should have no selections  id=id_accessories

    # 全選択する
    # http://robotframework.org/Selenium2Library/Selenium2Library.html#Select%20All%20From%20List
    select all from list  id=id_accessories

    # 選択した件数を数える
    @{selected_items1} =  get selected list labels  id=id_accessories
    ${selected_count1} =  get length  ${selected_items1}
    should be equal as integers  ${selected_count1}  3

    # 一つ選択をやめる
    unselect from list by value  id=id_accessories  rope

    # 選択した件数を数える
    @{selected_items2} =  get selected list labels  id=id_accessories
    ${selected_count2} =  get length  ${selected_items2}
    should be equal as integers  ${selected_count2}  2

    # オブジェクトの比較なので、波括弧のプレフィックスは$にする
    @{expected} =  set variable  紙  容器
    should be equal  ${selected_items2}  ${expected}


チェックボックスを選択する
    フォームページへ移動する

    # チェックボックスを選択する
    # http://robotframework.org/Selenium2Library/Selenium2Library.html#Select%20Checkbox
    select checkbox  id=id_takeout
    checkbox should be selected  id=id_takeout

    # チェックボックスの選択をやめる
    unselect checkbox  id=id_takeout
    checkbox should not be selected  id=id_takeout


テキストエリアに入力する
    フォームページへ移動する

    # テキストエリアに入力する
    input text  id=id_memo  テキストエリアです

    # 検証
    # http://robotframework.org/Selenium2Library/Selenium2Library.html#Textarea%20Should%20Contain
    # 完全一致
    textarea value should be  id=id_memo  テキストエリアです
    # 部分一致
    textarea should contain  id=id_memo  エリア

    # 入力文字のクリア
    # https://stackoverflow.com/questions/38337906/robot-framework-text-field-clearing-and-inputting
    clear element text  id=id_memo
    element text should be  id=id_memo  ${EMPTY}



input_hiddenの値を確認する
    フォームページへ移動する

    # type=hiddenなinputのvalueを取得する
    # http://robotframework.org/Selenium2Library/Selenium2Library.html#Get%20Element%20Attribute
    # locatorを指定しないと、idかnameが有効
    ${hidden_value1} =  get element attribute  id_hidden_value@value
    should be equal  ${hidden_value1}  隠しデータ
    ${hidden_value2} =  get element attribute  hidden_value@value
    should be equal  ${hidden_value2}  隠しデータ

    # classを使いたい場合は、locatorを明示的に指定
    ${hidden_value3} =  get element attribute  css=.hidden_class@value
    should be equal  ${hidden_value3}  隠しデータ


フォームPOST後のページでlocatorが「${locator}」の値が「${expected}」であるかを確認する
    POST後のページにいることを確認する

    page should contain element  id=${locator}
    ${actual} =  get text  id=${locator}
    should be equal  ${actual}  ${expected}


*** TestCases ***
フォームのテスト
    送信ボタンをクリックする

    送信ボタンでEnterキーを押す

    リンクをクリックする(ClickElement版)

    リンクをクリックする(ClickLink版)

    input_textにテキスト「${INPUT_TEXT}」を入力する
    フォームPOST後のページでlocatorが「subject」の値が「${INPUT_TEXT}」であるかを確認する

    input_passwordにパスワード「1234」を入力する
    フォームPOST後のページでlocatorが「aikotoba」の値が「1234」であるかを確認する

    ラジオボタンを選択する
    フォームPOST後のページでlocatorが「fruit」の値が「りんご」であるかを確認する
    フォームPOST後のページでlocatorが「fruit_size」の値が「小さいもの」であるかを確認する

    単一選択のみ可能なselectにて選択する

    複数選択可能なselectにて選択する

    チェックボックスを選択する

    input_hiddenの値を確認する

    テキストエリアに入力する
