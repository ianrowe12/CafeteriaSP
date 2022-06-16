//
//import Foundation
//import UIKit
//
//struct SubView: UIView {
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
//
//    var body: some UIView {
//            List {
//                Text("hello world")
//                Text("hello world")
//                Text("hello world")
//            }
//            .navigationBarTitle(todoList.title!, displayMode: .inline) // 1
//            .navigationBarBackButtonHidden(true)
//            .navigationBarItems(leading: backButton, trailing: addButton)
//    }
//
//    var backButton: some View {
//        Button(action: {
//            self.presentationMode.wrappedValue.dismiss()
//        }, label: {
//            HStack {
//                Image(systemName: "chevron.left")
//                Text("Back") // 2
//            }
//        })
//    }
