*** Keywords ***
ELSEをUPPER CASEで書く
    Run Keyword If  0 == 1  Log To Console  IFの表示
    ...  ELSE  Log To Console  ELSEの表示

ELSE IFとELSEをUPPER CASEで書く
    Run Keyword If  0 == 1  Log To Console  IFの表示
    ...  ELSE IF  0 == 2  Log To Console  ELSE IF の表示
    ...  ELSE  Log To Console  ELSE IFの表示


ELSEをPascal Caseで書く
    Run Keyword If  0 == 1  Log To Console  Ifの表示
    ...  Else  Log To Console  Elseの表示

    # 試しに、IfをTrueにしてみると、シンタックスエラーで落ちる
    # Run Keyword If  1 == 1  Log To Console  Ifの表示
    #     ...  Else  Log To Console  Elseの表示
    # => Keyword 'BuiltIn.Log To Console' expected 1 to 3 arguments, got 4.

ELSE IFとELSEをPascal Caseで書く
    Run Keyword If  0 == 1  Log To Console  Ifの表示
    ...  Else If  0 == 2  Log To Console  Else Ifの表示
    ...  Else  Log To Console  Else Ifの表示


ELSEをlower caseで書く
    Run Keyword If  0 == 1  Log To Console  ifの表示
    ...  Else  Log To Console  elseの表示

ELSE IFとELSEをlower caseで書く
    Run Keyword If  0 == 1  Log To Console  ifの表示
    ...  else if  0 == 2  Log To Console  else ifの表示
    ...  else  Log To Console  elseの表示

*** Test Cases ***

UPPER CASEで書く
    Log To Console  ${SPACE}
    ELSEをUPPER CASEで書く
    ELSE IFとELSEをUPPER CASEで書く

Pascal Caseで書く
    ELSEをPascal Caseで書く
    ELSE IFとELSEをPascal Caseで書く

lower caseで書く
    ELSEをlower caseで書く
    ELSE IFとELSEをlower caseで書く
