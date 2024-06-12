//
//  AddThingView.swift
//  Test
//
//  Created by Ilia Loviagin on 6/12/24.
//

import SwiftUI

struct AddThingView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var viewModel: HomeViewModel
    
    @Binding var thing: Thing // связка с State в HomeView
    
    @State private var description = ""
    @State private var date = Date()
    
    var body: some View {
        VStack {
            Text("Добавить дело")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.vertical)
            
            Text("Название дела")
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField(text: $thing.title) {
                Text("Название")
            }
            .lineLimit(1)
            .textFieldStyle(.roundedBorder)
            
            Text("Описание")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top)
            
            TextEditor(text: $description)
                .frame(maxHeight: 100)
                .overlay (
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.gray.opacity(0.4), lineWidth: 1)
                )
            
            DatePicker(selection: $date) {
                Text("Время")
            }
            .padding(.top)
            
            Button {
                if !description.isEmpty {
                    thing.description = self.description
                }
                thing.date = self.date
                
                viewModel.addThing(thing)
                dismiss()
            } label: {
                Label(viewModel.isThingExist(id: thing.id) ? "Обновить дело" : "Добавить дело", systemImage: viewModel.isThingExist(id: thing.id) ? "pencil" : "plus.circle")
                    .padding()
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity)
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding(.top)
            
            Spacer()
        }
        .padding(.horizontal)
        .onAppear {
            if let description = thing.description {
                self.description = description
            }
            
            if let date = thing.date {
                self.date = date
            }
        }
    }
}

#Preview {
    AddThingView(thing: .constant(Thing(title: "")))
        .environmentObject(HomeViewModel.mock) // нужно чтобы превью не крашилось
}
