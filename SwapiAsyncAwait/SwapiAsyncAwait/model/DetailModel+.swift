extension DetailModel {
    static func create(figure: Figure, vehicles: [Vehicle], films: [Film]) -> DetailModel {
        DetailModel(name: figure.name, vehicles: vehicles.map{ $0.name }, films: films.map{ $0.title })
    }
}
