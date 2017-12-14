import pyftpdlib.authorizers
import pyftpdlib.handlers
import pyftpdlib.servers
import pathlib
import shutil


def run_server():
    # FTPサーバのルートディレクトリを作る
    # __file__のパスを絶対パスに変換し、ルートディレクトリのパスも追加する
    ftp_server_root_path = pathlib.Path(__file__).resolve().parent.joinpath('serv')
    # ディレクトリがある場合は、一度削除しておく
    if ftp_server_root_path.exists():
        # pathlibのrmdir()ではファイルがあると削除できないので、shutilを使う
        shutil.rmtree(ftp_server_root_path.as_posix())
    # ディレクトリを作って、パーミッションは777にしておく
    ftp_server_root_path.mkdir()
    ftp_server_root_path.chmod(0o777)
    print(ftp_server_root_path)

    # 認証ユーザーを作る
    authorizer = pyftpdlib.authorizers.DummyAuthorizer()
    authorizer.add_user('user', 'password', ftp_server_root_path.as_posix(), perm='elradfmw')

    # 個々の接続を管理するハンドラを作る
    handler = pyftpdlib.handlers.FTPHandler
    handler.authorizer = authorizer

    # FTPサーバーを立ち上げる
    # Unix系だと、21番ポートはsuper userがbindできるポートなので、それ以外のポートにする
    # https://github.com/giampaolo/pyftpdlib/blob/master/docs/faqs.rst#why-do-i-get-socket-error-permission-denied-error-on-ftpd-starting
    server = pyftpdlib.servers.FTPServer(("127.0.0.1", 12345), handler)
    server.serve_forever()


if __name__ == '__main__':
    run_server()
