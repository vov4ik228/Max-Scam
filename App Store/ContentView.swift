//
//  ContentView.swift
//  App Store
//
//  Created by comp1 on 14.09.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("    Чтобы получить доступ к \nApp Store, включите передачу \nданных по сотовой сети или \n         используйте Wi-Fi.")
                
                .foregroundStyle(.gray)
                .padding()
            Button("Настройки"){
                UIApplication.shared.open(URL(string: "App-prefs:root=General&path=Network")!)
            }
            
            .padding(.horizontal, 15)   // Вертикальные отступы
                    .foregroundColor(.gray)    // Цвет текста
                    .overlay(
                        RoundedRectangle(cornerRadius: 3)
                            .stroke(Color.gray, lineWidth: 1) // Обводка: серый цвет, толщина 1
                    )
                    .background(Color.black)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
    }
        
}

#Preview {
    ContentView()
}
