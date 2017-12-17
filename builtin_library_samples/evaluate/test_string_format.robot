*** Keywords ***


*** TestCases ***

Evaluateでいろいろな文字列のフォーマットを試す
    # 改行して見やすくする
    Log To Console  ${\n}

    # %演算子
    ${結果1} =  Evaluate  '%06d %s' % (1, 'ゼロ埋めです')
    Log To Console  ${結果1}

    # str.format()関数
    ${結果2} =  Evaluate  'foo {}'.format('bar')
    Log To Console  ${結果2}

    # f-strings (Python3.6以上)
    ${結果3} =  Evaluate  f'baz ${結果2}'
    Log To Console  ${結果3}

