//
//  MenuEditView.swift
//  Barzooka
//
//  Created by Zhuo FENG on 2022/6/23.
//

import SwiftUI

class MenuPool: ObservableObject {
    @Published var menus: [Menu] = []
    @Published var menuItems: [MenuItem] = []
}


struct MenuEditView: View {
    
    
    var body: some View {
        VStack {
        }
        .padding()
    }
}

struct MenuEditView_Previews: PreviewProvider {
    static var previews: some View {
        MenuEditView()
    }
}
