//
//  HomeView.swift
//  Test
//
//  Created by Ilia Loviagin on 6/12/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var viewModel: HomeViewModel // один экземпляр класса HomeViewModel на все приложение
    @State private var showAddThing = false
    @State var currentThing = Thing(title: "") // связка с AddThingView с помощью Binding
     
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.things, id: \.id) { item in
                    ThingItemView(thing: item)
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button {
                                viewModel.removeThing(withId: item.id)
                            } label: {
                                Image(systemName: "trash")
                                    .tint(.red)
                            }
                        }
                        .onTapGesture {
                            currentThing = item
                            showAddThing = true
                        }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Список дел")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAddThing = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddThing, onDismiss: {
                currentThing = Thing(title: "")
            }) {
                AddThingView(thing: $currentThing)
            }
        }
    }
}

struct ThingItemView: View {
    let thing: Thing
    
    var body: some View {
        HStack {
            Image(systemName: "star")
            
            VStack(alignment: .leading) {
                Text(thing.title)
                    .fontWeight(.bold)
                
                 if let description = thing.description {
                    Text(description)
                 }
            }
            
            Spacer()
            
            if let date = thing.date {
                Text("\(Calendar.current.component(.hour, from: date)):\(Calendar.current.component(.minute, from: date))")
            }
        }
    }
}

#Preview {
    HomeView()
      .environmentObject(HomeViewModel.mock)
}
