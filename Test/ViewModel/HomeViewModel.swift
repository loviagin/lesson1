//
//  HomeViewModel.swift
//  Test
//
//  Created by Ilia Loviagin on 6/12/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var things: [Thing] = []
    
    init() {
        loadThings()
    }
    
    func isThingExist(id: String) -> Bool {
        return things.firstIndex(where: { $0.id == id }) != nil
    }
    
    func addThing(_ thing: Thing) {
        if let index = things.firstIndex(where: { $0.id == thing.id }) { // если мы обновляем существующее дело
            things[index] = thing
        } else { // или просто добавляем 
            things.append(thing)
        }
    }
    
    func removeThing(withId id: String) {
        if let index = things.firstIndex(where: { $0.id == id }) {
            things.remove(at: index)
        } else {
            print("error while removing thing from list")
        }
    }
    
    private func loadThings() {
        // Загрузка данных из базы данных
        things = [
            Thing(title: "Выучить Swift"),
            Thing(title: "Подписаться на канал"),
            Thing(title: "Идти на ужин", description: "Сегодня рыбный день", date: Date()), // Date() - текущая дата и время
            Thing(title: "Идти на завтрак", date: Calendar.current.date(byAdding: .hour, value: 8, to: Date()))  //  так мы можем делать любую дату/время
        ]
    }
}

extension HomeViewModel { // тестовые данные для работы с превью и тестированием
    static var mock: HomeViewModel {
        let viewModel = HomeViewModel()
        return viewModel
    }
}
