//
//  Created by Gryaznoy Alexander on 20.11.2026.
//

import Foundation
import SwiftData

@Model
final class WorkoutModel {
    var title: String
    var date: Date
    var durationMinutes: Int? = nil

    @Relationship(deleteRule: .cascade) var exercises: [ExerciseModel]

    init(
        title: String,
        date: Date,
        durationMinutes: Int? = nil
    ) {
        self.title = title
        self.date = date
        self.durationMinutes = durationMinutes
        self.exercises = []
    }
}
