//
//  String+Defined.swift
//  networkConnection
//
//  Created by Алина Кошманова on 16.01.2020.
//  Copyright © 2020 Алина Кошманова. All rights reserved.
//

import Foundation

extension String {
    
    enum NetworkError {
        static let error404 = "Ошибка данных"
        static let error401 = "Ошибка авторизации"
        static let error500 = "Ошибка сервера"
        static let error503 = "Сервер недоступен"
        static let standart = "Неизвестная ошибка"
        static let unreachable = "Отсутствует интернет"
    }
}
