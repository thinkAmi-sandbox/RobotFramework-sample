from robot.api import logger


class MyLibrary:
    """マイライブラリ

    | =タイトル= | =もう一つタイトル= |
    | 1行1列目 | 1行2列目 |
    | | 1列目が空白 |
    | 2列目が空白 | |

    = カスタムセクション =

    ここがカスタムセクション

    = 次のセクション =

    `カスタムセクション` へのリンク

    セクションへのリンク

    - `introduction`
    - `importing`
    - `shortcuts`
    - `keywords`

    *太字です*
    _イタリックです_
    普通です

    - リスト1
    - リスト2

    Googleへ https://google.co.jp
    こちらも [https://google.co.jp|Googleへ]

    `Hello World` へ

    ``インラインコードスタイル``

    複数行の *bold\n
    try* みる
    """

    ROBOT_LIBRARY_SCOPE = 'TEST SUITE'

    def hello_world(self, name='foo'):
        """ハローワールドを出力します"""
        logger.console(f'hello, world {name} !')

    def no_args(self):
        pass

    def multi_args(self, one, two='2', *args, **kwargs):
        pass
