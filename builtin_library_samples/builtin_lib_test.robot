*** Settings ***
Documentation  ビルトインの機能を使ったテスト

*** Variables ***
@{FRUIT}  りんご  みかん


*** Keywords ***
コンソールに文字を出力する
    # 出力したい内容はクォートで囲む必要はない
    log to console  Hello, world!
    log to console  こんにちは！
    # スペースが2個以上必要な場合は、組込変数${SPACE}を利用する
    log to console  スペースが${SPACE}${SPACE}${SPACE}3個必要
    # 拡張変数表記も使える
    log to console  スペースが${SPACE * 3}3個必要
    # 変数の値も出力できる：変数へ値をセットするキーワードはset variable
    # http://robotframework-ja.readthedocs.io/ja/latest/lib/BuiltIn.html#set-variable
    ${variable} =  set variable  こんばんは！
    log to console  ${variable}

    # 条件付きで変数に値を設定したい場合
    # http://robotframework-ja.readthedocs.io/ja/latest/lib/BuiltIn.html#set-variable-if
    ${condition_value} =  set variable if  False  空データ  条件を満たさない値
    # 変数に何も設定されない場合は、Noneがログに出る
    log to console  ${condition_value}


コンソールにリストを出力する
    # log to console でリストの中身を見てみる
    # 組込の改行文字があるので、そちらも使う
    # http://robotframework-ja.readthedocs.io/ja/latest/userguide/CreatingTestData/Variables.html#os
    log to console  ${\n}---$を出力---
    log to console  ${FRUIT}
    log to console  ---@を出力---
    # log to consoleの時にindex指定なしだとindex=0が出力
    log to console  @{FRUIT}
    log to console  @{FRUIT}[0]
    log to console  @{FRUIT}[1]

    # set variableで配列を作る
    @{medals} =  set variable  金  銀  銅
    log to console  ${medals}


文字列を結合する
    # 文字列の結合：Catenateを使う
    # http://robotframework-ja.readthedocs.io/ja/latest/lib/BuiltIn.html#catenate
    ${スペースあり} =  Catenate  スペース  あり
    log to console  ${スペースあり}
    # 区切り文字やスペースが不要な場合は、「SEPARATOR=」という書き方にする
    ${スペースなし} =  Catenate  SEPARATOR=  スペース  無し
    log to console  ${スペースなし}


文字列に該当の文字が含まれているか確認する
    # 文字列が含まれるか：should containを使う
    # 対象の文字列  含まれてほしい文字列の順に指定する
    should contain  Python  th


スペース があるキーワード を実行する
    # スペースが1個であれば、有効なキーワードとみなされる
    log to console  スペースのあるキーワードです


引数を受け取ってメッセージを出力する1
    # 変数のタイプ
    # ${}:文字列、@{}：リスト、&{}：辞書、%{}：環境変数
    # http://robotframework-ja.readthedocs.io/ja/latest/userguide/CreatingTestData/Variables.html#id3
    # キーワードと仮引数、仮引数と仮引数の間はスペースを2つ入れる
    # また、Argumentsは一行で書く：[Arguments]を複数回使うと、used multiple timesエラー
    [Arguments]  ${foo}  ${bar}
    log to console  ${foo}
    log to console  ${bar}

引数を受け取ってメッセージを出力する2
    # Argumentsの行を分割したい場合は、継続行の指定(...)を行う
    # https://stackoverflow.com/questions/28229676/if-elseif-in-robot-framework
    [Arguments]  ${foo}
    # three-dotの後にはスペースを2つ以上入れること：1つだと正しく認識されない
    ...          ${bar}
    log to console  ${foo}
    log to console  ${bar}


キーワードを埋め込んでコンソールに${メッセージ}を出力する
    log to console  ${メッセージ}

分かりやすくキーワードを埋め込んでコンソールに「${メッセージ}」を出力する
    log to console  ${メッセージ}


Returnで戻り値を取得する
    # http://robotframework-ja.readthedocs.io/ja/latest/userguide/CreatingTestData/CreatingUserKeywords.html#user-keyword-return-values
    # [Return]と戻り値の間はスペースを2つ入れる
    [Return]  戻り値1

ReturnFromKeywordで戻り値を取得する
    Return From Keyword  戻り値2

ReturnFromKeywordIfで戻り値を取得する
    # 組込変数の${true}を使う：大文字小文字の区別は無い
    # http://robotframework-ja.readthedocs.io/ja/latest/userguide/CreatingTestData/Variables.html#built-in-variables
    # http://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#built-in-variables
    Return From Keyword If  ${true}  戻り値3

ReturnFromKeywordで空の戻り値を取得する
    # 空の値を示す組込変数は、${EMPTY} (大文字小文字の区別無し)
    # http://robotframework-ja.readthedocs.io/ja/latest/userguide/CreatingTestData/Variables.html#id29
    Return From Keyword  ${EMPTY}


Ifを使って処理を切り替えてログを出力する
    [Arguments]  ${引数}
    # 空かどうかを比較するには、式の評価の都合上、仮引数と変数${EMPTY}をクォートで囲む必要がある
    # 囲まない場合、変数の値そのものではなくなるため、以下のエラーが出る
    # -> 「Evaluating expression ' == ' failed: SyntaxError: invalid syntax」
    # http://robotframework-ja.readthedocs.io/ja/latest/lib/BuiltIn.html#evaluating-expressions
    # http://robotframework.org/robotframework/latest/libraries/BuiltIn.html#Evaluating%20expressions
    # また、条件付きでキーワード(log to log to console)を実行するため、Run Keyword Ifを使う
    # 他に、2.7系では失敗するが、3.6系では動作する
    Run Keyword If  '${引数}' == '${EMPTY}'  log to console  空っぽです1
    # ELSE IFなどは、継続行表記を使う
    ...  ELSE IF  '${引数}' == '${false}'  log to console  Falseです1
    ...  ELSE  log to console  ${引数}

Ifを使って処理を切り替えてログを出力する(評価ネームスペース版)
    [Arguments]  ${引数}
    # 2.9以降では、クォートを使わなくても評価ネームスペースでも比較できる
    # ただし、${EMPTY}はうまく動作しない：「Variable '$EMPTY' not found.」
    Run Keyword If  $引数 == '${EMPTY}'  log to console  空っぽです2
    # ${false}は評価ネームスペースを使ってもうまく動作する
    ...  ELSE IF  $引数 == $false  log to console  Falseです2
    ...  ELSE  log to console  ${引数}


Forループを使う(InRange版)
    :FOR  ${i}  IN RANGE  1  4
    # ループブロックは、バックスラッシュで示す(バックスラッシュの後にスペースを2つ以上いれること)
    \   log to console  ${i}回目

Forループを使う(list版)
     # リストを作る時は、create listを使い、set variableは使わない
     # http://robotframework-ja.readthedocs.io/ja/latest/lib/BuiltIn.html#create-list
     # http://robotframework-ja.readthedocs.io/ja/latest/lib/BuiltIn.html#set-variable
     # create listとリストの要素の間やリストの要素間のスペースは、いずれも2つ以上必要
    @{items} =  create list  1  4  6
    :FOR  ${v}  IN  @{items}
    \   log to console  リストの値は${v}

ExitForLoopIfでForループを抜ける
    # http://robotframework-ja.readthedocs.io/ja/latest/lib/BuiltIn.html#exit-for-loop-if
    :FOR  ${v}  IN  one  two  three
    \   exit for loop if  $v == 'two'
    \   log to console  ${v}


常に失敗するキーワードを実行する
    # Failは常にテストを失敗させる
    # http://robotframework-ja.readthedocs.io/ja/latest/lib/BuiltIn.html#fail
    Fail  常に失敗する

RunKeywordAndReturnStatusでキーワードの成否を確認する
    # 「常に失敗するキーワードを実行する」など、失敗する可能性があるキーワードの実行については
    # 「Run Keyword And Return Status」を使うと成否が判定でき、テストも失敗しなくなる
    # http://robotframework-ja.readthedocs.io/ja/latest/lib/BuiltIn.html#run-keyword-and-return-status
    ${成否} =  Run Keyword And Return Status  常に失敗するキーワードを実行する
    log to console  ${成否}
    #=> False

RunKeywordAndIgnoreErrorでキーワードが失敗しても無視する
    # 失敗した時のメッセージを取得したい場合は、Run Keyword And Ignore Errorを使う
    # http://robotframework-ja.readthedocs.io/ja/latest/lib/BuiltIn.html#run-keyword-and-ignore-error
    ${エラーメッセージ} =  Run Keyword And Ignore Error  常に失敗するキーワードを実行する
    log to console  ${エラーメッセージ}
    #=> ('FAIL', '常に失敗する')


テストケースをパスする
    # 条件を満たした場合にテストをパスさせる
    # http://robotframework-ja.readthedocs.io/ja/latest/lib/BuiltIn.html#pass-execution-if
    # 常にパスさせる場合には、Pass Executionを使う
    Pass Execution If  ${true}  テストをパスしました！


Pythonコードを実行する
    # 文字列の処理などをPythonコードで実行する場合はEvaluateを使う
    # http://robotframework-ja.readthedocs.io/ja/latest/lib/BuiltIn.html#evaluate
    # https://stackoverflow.com/questions/34153036/robot-framework-string-padding
    ${結果} =  Evaluate  '%06d %s' % (1, 'ゼロ埋めです')
    log to console  ${結果}


現在のテスト名を取得する
    # 組込変数が用意されているので、そちらを使う
    # http://stackoverflow.com/questions/22719860/robot-framework-get-name-of-current-test-case
    log to console  ${TEST NAME}
    #=> コンソールを使ったテスト
    log to console  ${SUITE NAME}
    #=> Robotframework Sample.Builtin Library Samples.Builtin Lib Test



*** TestCases ***
コンソールを使ったテスト
    log to console  Hello, world!

    コンソールに文字を出力する

    コンソールにリストを出力する

    スペース があるキーワード を実行する

    # キーワードと実引数、実引数と実引数の間はスペースを2つ入れる
    # 引数の右辺の値はクォートで囲まなくて良い：囲むとクォートまで渡される
    引数を受け取ってメッセージを出力する1  foo=フー1  bar=バー1
    引数を受け取ってメッセージを出力する2  foo=フー2  bar=バー2


    キーワードを埋め込んでコンソールに分かりにくいハローを出力する
    分かりやすくキーワードを埋め込んでコンソールに「分かりやすいハロー」を出力する

    # 「<変数><スペース1個>=<スペース2個><キーワード>」という形式で、キーワードからの戻り値を変数に入れる
    ${foo4} =  Returnで戻り値を取得する
    キーワードを埋め込んでコンソールに${foo4}を出力する

    ${foo5} =  ReturnFromKeywordで戻り値を取得する
    キーワードを埋め込んでコンソールに${foo5}を出力する

    ${foo6} =  ReturnFromKeywordIfで戻り値を取得する
    キーワードを埋め込んでコンソールに${foo6}を出力する

    ${empty_value} =  ReturnFromKeywordで空の戻り値を取得する
    Ifを使って処理を切り替えてログを出力する  引数=${empty_value}
    Ifを使って処理を切り替えてログを出力する  引数=${false}
    Ifを使って処理を切り替えてログを出力する  引数=値が入ってます1

    ${empty_value} =  ReturnFromKeywordで空の戻り値を取得する
    Ifを使って処理を切り替えてログを出力する(評価ネームスペース版)  引数=${empty_value}
    Ifを使って処理を切り替えてログを出力する(評価ネームスペース版)  引数=${false}
    Ifを使って処理を切り替えてログを出力する(評価ネームスペース版)  引数=値が入ってます2

    Forループを使う(InRange版)
    Forループを使う(list版)

    ExitForLoopIfでForループを抜ける

    RunKeywordAndReturnStatusでキーワードの成否を確認する
    RunKeywordAndIgnoreErrorでキーワードが失敗しても無視する

    文字列を結合する
    文字列に該当の文字が含まれているか確認する

    Pythonコードを実行する

    現在のテスト名を取得する


パスするテスト
    テストケースをパスする
    常に失敗するキーワードを実行する
