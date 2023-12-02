# SwiftUIにおけるデザインパターン

## デザインパターンとは
概要はMVVM_UIKitのMVVM.mdを参照

## WebAPIとMVVMの構成
ViweがWebサービスを呼び出しJSONを取得するのはNG
ViewがViewModelにアクセスし、ViewModelがWebサービスを呼び出してJSONを取得するのが望ましい

## クラスと構造体
Modelは構造体、ViewModelはObservableObjectを継承できるようにクラスが良い
ViewModel の責任は、更新された値をビューに提供すること

APIの確認
モデルを作る
WebServicesクライアントを実装


直すところ
//@Publishedプロパティラッパーを使ってModelのインスタンスを監視可能にし、値が増加したことがビューに通知され、再レンダリングされる
    @Published private var でモデルを公開しない

リストをcellに分ける