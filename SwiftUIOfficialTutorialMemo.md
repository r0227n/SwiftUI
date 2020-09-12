# Essentials
## BuildingListsAndNavigation
### 画面遷移の方法
宣言
```
NavigationLink(destination: LandmarkDetail(landmark: landmark)) {
```
- NavigationLink() : 画面遷移する宣言  
- destination : 遷移先を指定。画面遷移先のViewを別ファイルに書き、`destination`のパラメーターに指定することで画面遷移する

### プレビュー画面の選択
宣言  
```
ForEach(["iPhone SE", "iPhone XS Max"], id: \.self) {
  deviceName in LandmarkList()
    .previewDevice(PreviewDevice(rawValue: deviceName))
    .previewDisplayName(deviceName)
  }
```
リストプレビュー内で、デバイス名を配列にしてインスタンスに埋め込む。

## HandlingUserInput
### 非同期処理を効率的に行う
宣言
 ```
 import Combine
 ```
Combine:イベントの発行と購読をすることできるフレームワーク  
- `Publishers` : イベントの発行者
- `Subscribers` : イベントの購読者
- `Operators`   : 流れてくる値を加工することができる

引用元:https://dev.classmethod.jp/articles/swift-combine-framework-for-beginners/

### 複数のviewを一括管理
宣言  
```
final class UserData: ObservableObject {
    @Published var showFavoritesOnly = false
    @Published var landmarks = landmarkData
}
```
- ObservableObject : 複数のviewの状態管理をひとまとまりのオブジェクトとして管理する
- @Published : ObservableObjectの監視するプロパティに指定する

参考サイト:https://www.isoroot.jp/blog/2381/

### アプリ全体で共通のプロパティ
```
@EnvironmentObject private var userData: UserData
```
- `@EnvironmentObject` : アプリ全体で共通のプロパティ
- `private` : 同じソースファイル内からのみアクセスできる

`userData`は同一ファイル内のみでメッソド間共通のプロパティとして宣言している。

参考サイト:<https://www.isoroot.jp/blog/2381/>

### オプショナルバインディング
宣言  
```
$userData.showFavoritesOnly
```
「＄」こいつがオプショナルバインディングし、`userData`の`nil`チェックを行う。

### environmentObject(_:)メソッド  
View階層全体にモデルを設定する。
>environmentObject(_:)メソッドは直接指定したViewと、そこに含まれるViewにObservableObject準拠のモデルを供給します。    
>Viewでは @EnvironmentObject 属性を付けたプロパティで供給されたオブジェクトを使うことができます。  
>[引用元:SwiftUIのデータフローその３](https://note.com/kaigian/n/n425b108dc9a3#3N8zy)

### UIHostingController()クラス
UIKitで構成されたView階層にSwiftUIで作ったViewを追加する。　　

>SwiftUI(のView)を管理するUIKitViewController。  
UIKitのView階層にSwiftUIを統合する時にオブジェクトを作成する。作成時、このビViewControllerをroot viewとしてSwiftUIを指定する。  
>[翻訳元:UIHostingControllerの公式ドキュメント](https://developer.apple.com/documentation/swiftui/uihostingcontroller)

### rootViewControllerインスタンスプロパティ
ViewController(画面)を管理するコントローラー。  
ViewControllerの階層構造を設定する時に使うらしい。

### makeKeyAndVisible()インスタンスメソッド
指定したViewControllerをView階層最前面(key window)にするらしい。

### @Published
`@ObservedObject`(グループ化された@State)を変更するための変数を定義する。  

参考サイト  
https://note.com/dngri/n/  
https://qiita.com/yimajo/items/8846207d2b7a17ace809

### UserDataオブジェクトを開発環境に設定する
```php:UserData.swif
import Combine
import SwiftUI

/*
 Combine:イベントの発行と購読をすることできるフレームワーク
 ・Publishers:イベントの発行者
 ・Subscribers:イベントの購読者
 ・Operators:流れてくる値を加工することができる
 */

/*
 ObservableObject:複数のviewの状態管理をひとまとまりのオブジェクトとして管理する
 @Published:ObservableObjectの監視するプロパティに指定する
 final:継承するのを禁止、サブクラスでオーバーライドされるのを禁止することでデータが変更されないようにする
 */

final class UserData: ObservableObject {
    @Published var showFavoritesOnly = false
    @Published var landmarks = landmarkData
}
```

```php:LandmarkList.swift
// @EnvironmentObject プロパティを宣言
@EnvironmentObject var userData: UserData

// environmentObject(_:) 修飾子を追加
LandmarkList().environmentObject(UserData())
```
これで`UserData.swift`をファイル内でプロパティとして参照することができるようにする。

```php:SceneDelegate.swift
func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    if let windowScene = scene as? UIWindowScene {
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UIHostingController(rootView: LandmarkList().environmentObject(UserData()))
        self.window = window
        window.makeKeyAndVisible()
    }
}
```
こいつでViewの階層構造に`UserData`の情報が反映されるようになる。

---

# Drawing and Animation
## Drawing Paths and Shapes
`PathAPI`を使い、複数の`CGPoint`同士をつなげることでオブジェクトを作成することができる。
正直、コードを読むことはできるが作ることができないため復讐が必要。

## Animating Views and Transitions
### .animation(_ : )
アニメーションが実装できる。  
[公式ドキュメント](https://developer.apple.com/documentation/swiftui/animation)に概要が記載されていない＆ネットの情報が少ないため、どのような種類があるか調べないといけない。

### Viewの遷移
>Viewはフェードインおよびフェードアウトすることにより、画面内と画面外を遷移する。  
>transition(_ : ) を使うことによって、遷移をカスタマイズすることができる。  
>[翻訳元:SwiftUI Tutorials Animating Views and transition  Section3](https://developer.apple.com/tutorials/swiftui/animating-views-and-transitions)

宣言
```
transition(パラメーター)
```

パラメーターによって、アニメーションが変化する
- `.slide` : 左からスライドして画面内、右へスライドして画面外に遷移する
- `.opacity` : フェードイン、フェードアウトする
- `.scale` : 徐々に拡大して表示、縮小して非表示にする
- `.scale(scale: CGFloat, anchor: UnitPoint = .center)` :
第1引数(scale)に拡大・縮小の倍率、第2引数(anchor)に変化の原点を[UnitPoint構造体](https://capibara1969.com/2345/)で指定する。第2引数が未定義の場合、デフォルト値として.centerが指定される。
- `.move(edge: Edge)` : 引数で指定された方向から表示、同方向から非表示する
- `offset(CGSize)` : CGSizeで指定された位置から移動しながら表示、同じ方向に移動しながら非表示になる
- `.offset(x: CGFloat=0,y:CGFloat=0)` : 「offset()」の位置をして、同じような表現をする
- `.identity`: トランザクション効果をしない

[参考サイト：トランザクションの使い方](https://capibara1969.com/2442)

## Composing Complex Interfaces
### init(grouping:by:) ジェネリック初期化子
指定したクロージャによって、返されたキーを分類し、その値を各キーとした要素の配列を作成する。  

宣言
```
init<S>(grouping values: S, by keyForValue: (S.Element) throws -> Key) rethrows where Value == [S.Element], S : Sequence
```
パラメーター
- `values` :  配列に分類するときの値
- `keyForValue` : valuesの各要素のキーを返すためのクロージャ

新しい配列の値は、最低でも１つの要素を含み、ソースシーケンス（元の配列）と同じ順番に格納される。

#### init(grouping:by:)の使用例
```
let students = ["Kofi", "Abena", "Efua", "Kweku", "Akosua"]
let studentsByLetter = Dictionary(grouping: students, by: { $0.first! })
// ["E": ["Efua"], "K": ["Kofi", "Kweku"], "A": ["Abena", "Akosua"]]
```
studentsという配列に格納されている文字列の最初の文字で部類分けし、studentsByLetterという配列に作り直している。

[翻訳元:公式ドキュメント](https://developer.apple.com/documentation/swift/dictionary/3127163-init)

### 「$0.category.rawValue」ってなに？
```php:Home.swift
Dictionary(
  grouping: landmarkData,
  by: { $0.category.rawValue }
)
```
この箇所は、landmarkData配列をcategory.rawValueを基準に分類し、新たな配列に作り替えている部分。  
先ほどの”init(grouping:by:)の使用例”から「$0.α」を推測するに...  
**αはクロージャだよ！！！**  
と宣言しているのだと思う。

### .resizable()
```
func resizable(capInsets: EdgeInsets = EdgeInsets(), resizingMode: Image.ResizingMode = .stretch) -> Image
```
[公式ドキュメント](https://developer.apple.com/documentation/swiftui/image/resizable(capinsets:resizingmode:))を見る限りだと、サイズ指定後こいつを使うことによって、Imageに情報が返されてリサイズ処理をすることができるっぽい。

### listRowInsets(_ : )
Listに余白を宣言することができる。  

宣言
```
func listRowInsets(_ insets: EdgeInsets?) -> some View
```

返り値  
指定された余白をListCellに返す。  

パラメーター  
- `insets` : EdgeInsetsViewの端に適用する。

#### listRowInsets(_ : )の使用例
```
List(Flavor.allCases, id: \.self) {
  Text($0.rawValue)
}
.listRowInsets(EdgeInsets(top: 0, leading: 75, bottom: 0, trailing: 0))
```
ListのCell間隔を上側０、先頭（左側）75、下側0、末尾（右側）０の余白を設定している。   

[翻訳元:公式ドキュメント](https://developer.apple.com/documentation/swiftui/list/listrowinsets(_:))

### renderingMode(_ : )
レンダリング方法を宣言する修飾子。パラメーターによって、種類が変化する。  

パラメーター
- `.none` : 参照するデータがないかな？（灰色にレンダリングされる）
- `.original` : データをそのままレンダリングする。
- `.some(Image.TemplateRenderingMode)` : 使い方不明、.originと同じような働きらしい。（詳しい人いましたら教えてください）
- `.template` : データを参照せず、ただ単に指定されたサイズのオブジェクトを生成するかな？（灰色にレンダリングされる）
- `nil` : .noneと同じ

公式ドキュメンに概要がなく、情報が少ないため理解度が低いので詳しい人いたら教えて欲しいです...

参考サイト  
https://medium.com/better-programming/swiftui-rendering-mode-5f79454b13a2
https://qiita.com/Pman5151/items/9a7c905a2fac10cd3685
https://stackoverflow.com/questions/56820779/how-can-i-create-a-button-with-image-in-swiftui

### .sheet(: _ )
Storybord上で**Segue遷移→show**を選択した時と同じような処理。  
[参考サイト：シートの使い方](https://capibara1969.com/2521/)

## Working with UI Controls
### @Environment
システムから取得した固定プロパティを編集するためにデータを他の型に委譲（Property wrappers）する。  

Property wrappersするのに最適な処理
- デバイスがダークモードorライトモードを判断
- Viewのレンタリングに使用するクラス
- CoreDataの管理対象オブジェクトを読み取る  

環境内全てのデータを探して委譲するため、複雑かつ複数の情報を読み書きする場合はデータの整合性が保てないので使用してはいけない。

参考サイト  
@Environmentについて：   
https://www.hackingwithswift.com/quick-start/swiftui/what-is-the-environment-property-wrapper  
Property wrappersについて：  
https://dev.classmethod.jp/articles/property-wrappers/

### @EnvironmentObject
環境内の任意のオブジェクトを読み取り、データを他の型に委譲する。  
参照先を指定してProperty wrappersするため、データの整合性が保たれる。  

参考サイト  
https://www.hackingwithswift.com/quick-start/swiftui/what-is-the-environment-property-wrapper

### .inactive
遷移する時に呼び出される状態。  

参考サイト  
https://gist.github.com/shinyaohira/5975781

---

# Framework Integration
## Interfacing with UIKit
### UIViewControllerRepresentable
UIKitViewControllerを表すView。  
UIKitに属するViewControllerを継承し、SwiftUIで活用するために使用する。

使用例
```
struct PageViewController: UIViewControllerRepresentable {}
```

[翻訳元：公式ドキュメント](https://developer.apple.com/documentation/swiftui/uiviewcontrollerrepresentable)

### makeUIViewController(context:)
ViewControllerの初期化（初回起動時のみ）に呼び出される必須のインスタンスメソッド。  
現在のアプリのデータとコンテキストパラメータの内容を使用してViewControllerを作成する。このメソッドは、ViewControllerを初めて作成するときに一度だけ呼び出され、以降の更新処理はupdateUIViewController(_:context:)メッソドで行う。  

宣言  
```
func makeUIViewController(context: Self.Context) -> Self.UIViewControllerType
```

返り値  
提供された情報で構成されたUIKitViewController。  

パラメーター  
- `context` : 現在のシステム状態に関する情報を含んだコンテキスト構造。  

[翻訳元：公式ドキュメント](https://developer.apple.com/documentation/swiftui/uiviewcontrollerrepresentable/makeuiviewcontroller(context:))


### updateUIViewController(_:context:)
指定されたViewControllerの情報を更新するインスタンスメソッド。  
このメソッドは、アプリの状態が変化すると影響を受けるAppKitとUIKit（公式ドキュメントにUIKitは明記されていない）のViewControllerに対して呼び出される。  
このメソッドを使用して、コンテキストパラメータで提供される新しい状態情報と一致するようにViewControllerの設定を更新する。  

宣言  
```
func updateUIViewController(_ uiViewController: Self.UIViewControllerType, context: Self.Context)
```

パラメーター
- `uiViewController` : カスタムViewControllerオブジェクト。
- `context` : 現在のシステムの状態に関する情報を含むコンテキスト構造。

[翻訳元：公式ドキュメント](https://developer.apple.com/documentation/swiftui/uiviewcontrollerrepresentable/updateuiviewcontroller(_:context:))

### Coordinator
画面遷移処理と画面実装処理を分割し、アップデート時に管理しやすいようにするデザインパターン。  
Coordinatorを使用することにより、デリゲート、データソース、ターゲットアクションを介したユーザーイベントへの応答など、一般的なCocoa(Cocoa Touch)フレームワークを擬似的に実装することができる。  

画面遷移の多くは、遷移先をセットで定義する。そのため、遷移先は同じ画面なのに遷移方法が異なった場合、宣言するたびに再定義をしないといけない。この再利用性の乏しい画面遷移方法を解決するために、2015年にSoroush  Khanlou氏がCoordinatorを提唱したらしい。  
だが、これはUIKit前提の処理のためSwiftUIで作成したViewを再利用するには、`UIHostingController`でUIKitのView階層にViewを追加しUIViewControllerとして再定義しなければいけないらしい。  

このサンプルプログラムの場合、「PageViewControllerの管理下にあるViewが選択された時、詳細画面に遷移」という処理を再利用可能にしている。  

まだCoordinatorの概念を理解しておらず、サンプルプログラムを参考にしながらだと実装できる程度だが、画面の遷移処理を委譲しプログラムの再利用性を高める処理はコード量が減り読みやすいプログラムになるため積極的に勉強していきたい。  

参考サイト  
https://blog.personal-factory.com/2020/05/27/swiftui-coordinator-pattern/

### @Binding
>@BindingをつけてやるとView間での双方向のデータ共有が可能になります。  
>@Bindingで定義したisPresentedの値を変更すると  
>@Stateで定義したisPresentedの値も変更され、関連するViewが全て更新されます。  
>[引用元：【SwiftUI】@Stateとか@Bindingて何](https://qiita.com/akasasan454/items/b8a2d239bb118dbba449)

### setViewControllers(_:direction:animated:completion:)
データソースを使用して、遷移するViewControllerを指定するインスタンスメソッド。  
トランジションスタイルがUIPageViewController.TransitionStyle.pageCurl の場合、[spine location](https://hajihaji-lemon.com/swift/spine-location/)と isDoubleSided プロパティによって、変化する。  

| Spain location                                                                                | isDoubleSided | 何を返すか |
|:----------------------------------------------------------------------------------------------|:--------------|:-|
| UIPageViewController<br>.SpineLocation.mid                                                    | true          | 左に表示するページと右に表示するページを返す。 |
| UIPageViewController<br>.SpineLocation.min or<br>  UIPageViewController<br>.SpineLocation.max | true          | 表示したいページの表と裏を返す。裏はページをめくるアニメーションに使用する。 |
| UIPageViewController<br>.SpineLocation.min or<br> UIPageViewController<br>.SpineLocation.max  | false         | 表示される前のページを返す。 |

宣言  
```
func setViewControllers(_ viewControllers: [UIViewController]?,
              direction: UIPageViewController.NavigationDirection,
              animated: Bool,
              completion: ((Bool) -> Void)? = nil)
```

パラメーター  
- `viewControllers` : 表示するViewController。
- `direction` : ナビゲーションの方向を指定する。
- `animated` : 遷移時アニメーションのOn/Offをbool値で指定する。
- `completion` : ”ページをめくる”アニメーションが終了した時に呼び出され、次のパラメーターを指定する。
- `finished` : アニメーションが終了した場合はtrue、スキップされた場合はfalseを返す。

[翻訳元：公式ドキュメント](https://developer.apple.com/documentation/uikit/uipageviewcontroller/1614087-setviewcontrollers)

### WKInterfaceObjectRepresentable
SwiftUIでWatchKitインターフェースオブジェクトを作成および管理するプロトコル。  
インターフェースオブジェクトないで発生した変更をSwiftUIで自動的に共有しないため、Cordinatorを使用してインターフェースオブジェクトの情報をSwiftUIに転送しなければいけない。  
[翻訳元：公式ドキュメント](https://developer.apple.com/documentation/swiftui/wkinterfaceobjectrepresentable)

### makeWKInterfaceObject
SwiftUIでWatchKitインターフェースオビュジェクトを作成する時、初回起動時のみアプリの現在のデータとcontextパラメーターの内容を使用してオブジェクトを作成する。  

宣言  
```
func makeWKInterfaceObject(context: Self.Context) -> Self.WKInterfaceObjectType
```

返り値  
提供された情報で構成されたインターフェースオブジェクト  

パラメーター  
- `context` : システムの現在の状態に関する情報を含むコンテキス構造。

[翻訳元：公式ドキュメント](https://developer.apple.com/documentation/swiftui/wkinterfaceobjectrepresentable/makewkinterfaceobject(context:))

### updateWKInterfaceObject
SwiftUIでWatchKitインターフェースオブジェクトを作成するとき、データを更新するするために呼び出されるインスタンスメソッド。  

宣言  
```
func updateWKInterfaceObject(_ wkInterfaceObject: Self.WKInterfaceObjectType, context: Self.Context)
```

パラメーター  
- `wkInterfaceObject` : カスタムインターフェイスオブジェクト。
- `context` : 現在のシステムの情報に関したコンテキスト構造。

[翻訳元：公式ドキュメント](https://developer.apple.com/documentation/swiftui/wkinterfaceobjectrepresentable/updatewkinterfaceobject(_:context:))

### WKInterfaceObjectRepresentableContext
SwiftUIでWatchKitインターフェイスオブジェクトの作成および更新に使用するシステムの状態に関するコンテキスト情報が含まれる構造体。  
構造体には、システムの現状について詳細に保存されている。インターフェイスオブジェクトを作成および更新すると、システムはこれらの構造体を１つ作成、インスタンスに適切なメソッドを返す。  
[翻訳元：公式ドキュメント](https://developer.apple.com/documentation/swiftui/wkinterfaceobjectrepresentablecontext)

## Creating a macOS App
### filter(_: )
指定された条件を満たす[シーケンス](http://e-words.jp/w/%E3%82%B7%E3%83%BC%E3%82%B1%E3%83%B3%E3%82%B9.html)（配列や辞書など）の要素を順番に含むはいれうtを返す。  

宣言
```
func filter(_ isIncluded: (Self.Element) throws -> Bool) rethrows -> [Self.Element]
```

パラメーター  
- `isIncluded` : シーケンスの要素を引数として取り、要素が返される配列に含まれるかどうかを示すブール値を返すクロージャー。

返り値  
isIncludedが許可されている要素の配列。
