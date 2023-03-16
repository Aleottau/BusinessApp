//
//  CalificationModel.swift
//  BusinessApp
//
//  Created by alejandro on 14/03/23.
//

import Foundation

struct CalificationModel {
    let cantidadDeVotos: Int32
    let promedio: Int32
}
extension CalificationModel {
    init(calificacionCoreData: CalificationCoreData) {
        self.init(cantidadDeVotos: calificacionCoreData.cantidadDeVotos, promedio: calificacionCoreData.promedio)
    }
}
