# SwiftUIにおけるデザインパターン

## デザインパターンとは
概要はMVVM_UIKitのMVVM.mdを参照

## WebAPIとMVVMの構成
ViweがWebサービスを呼び出しJSONを取得するのはNG
ViewがViewModelにアクセスし、ViewModelがWebサービスを呼び出してJSONを取得するのが望ましい

