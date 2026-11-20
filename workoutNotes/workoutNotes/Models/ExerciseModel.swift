//
//  Created by Gryaznoy Alexander on 20.11.2026.
//

import SwiftData

@Model
final class ExerciseModel {
    var title: String
    var muscles: [String]

    @Relationship(deleteRule: .cascade) var approaches: [ApproachModel]

    init(
        title: String,
        muscles: [String]
    ) {
        self.title = title
        self.muscles = muscles
        self.approaches = []
    }
}
