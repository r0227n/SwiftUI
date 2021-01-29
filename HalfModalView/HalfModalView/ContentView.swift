//
//  ContentView.swift
//  HalfModalView
//
//  Created by RyoNishimura on 2021/01/29.
//

import SwiftUI

struct ContentView: View {
    @State var screenHeight: CGFloat = 0.0
    @State private var showHalfModal = false
    
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack{
                Button(action: {
                    self.showHalfModal.toggle()
                }, label: {
                    Text("モーダルを表示")
                        .font(.largeTitle)
                })
                HalfModal(closedButton: $showHalfModal,
                          sizeY: screenHeight,
                          objectHeight: 400.0)
            }
            .onAppear(perform: {
                screenHeight = geometry.size.height  // スクリーンサイズ（縦幅）を取得
            })
        })
        .ignoresSafeArea(.all) // 上下のサーフエリアを無効化
    }
}

struct HalfModal: View {
    @Binding var closedButton: Bool
    let sizeY: CGFloat
    let objectHeight: CGFloat
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 50.0)
                .foregroundColor(.red)
            VStack {
                Spacer()
                Button(action: {
                    closedButton.toggle()
                }, label: {#imageLiteral(resourceName: "simulator_screenshot_CE52D1DE-5BC5-47DC-ABCA-6872703BC91E.png")
                    Text("閉じる")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                })
                Spacer()
            }
        }
        .frame(height: objectHeight)
        .offset(y: closedButton ? sizeY-objectHeight :  sizeY)
        .onAppear(perform: {
            print(closedButton)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        HalfModal(closedButton: .constant(true), sizeY: 400, objectHeight: 400)
    }
}
