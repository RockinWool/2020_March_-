#-------Discription(説明)--------#
#This Dockerfile can make Anaconda(runtime) environment.
#このDockerfileはAnacondaの実行環境を作成できる
# Maintainer is RockinWool
# 管理人はRockinWoolだよ~
#--------------------------------# 

#----1. Create Anaconda runtime---#
#NOTE! This Anaconda image is always latest version.#
FROM continuumio/anaconda3
LABEL author="RockinWool"

#---2. Create epidemic dir: コンテナ内に/epidemicディレクトリを作成する#
WORKDIR /
RUN mkdir epidemic 
ENV HOME=/epidemic
WORKDIR $HOME

#---3. コンテナのListen port numberを8888番portとする---# 
EXPOSE 8888

#---4.jupyter-labの立ち上げ設定。この部分は https://qiita.com/komiya_____/items/96c14485eb035701e218 を参考/引用元としている
# ENTRYPOINT命令はコンテナ起動時に実行するコマンドを指定（基本docker runの時に上書きしないもの）
# "jupyter-lab" => jupyter-lab立ち上げコマンド
# "--ip=0.0.0.0" => ip制限なし
# "--port=8888" => EXPOSE命令で書いたポート番号と合わせる
# ”--no-browser” => ブラウザを立ち上げない。コンテナ側にはブラウザがないので 。
# "--allow-root" => rootユーザーの許可。セキュリティ的には良くないので、自分で使うときだけ。
# "--NotebookApp.token=''" => トークンなしで起動許可。これもセキュリティ的には良くない。
ENTRYPOINT ["jupyter-lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]

#---5. プログラムをコンテナ内に移動する----#
COPY /program_A $HOME/
WORKDIR $HOME/program_A
# CMD命令はコンテナ起動時に実行するコマンドを指定（docker runの時に上書きする可能性のあるもの）
# "--notebook-dir=/workdir" => Jupyter Labのルートとなるディレクトリを指定
CMD [ "--notebook-dir=/epidemic" ]