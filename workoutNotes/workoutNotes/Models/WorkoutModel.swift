//
//  Created by Gryaznoy Alexander on 20.11.2026.
//

import Foundation
import SwiftData

@Model
final class WorkoutModel {
    var workoutTitle: String
    var createWorkoutDate: Date
    var startWorkoutDate: Date? = nil
    var endWorkoutDate: Date? = nil

    @Relationship(deleteRule: .cascade) var exercises: [ExerciseModel]

    init(
        workoutTitle: String,
        createWorkoutDate: Date,
        startWorkoutDate: Date? = nil,
        endWorkoutDate: Date? = nil
    ) {
        self.workoutTitle = workoutTitle
        self.createWorkoutDate = createWorkoutDate
        self.startWorkoutDate = startWorkoutDate
        self.endWorkoutDate = endWorkoutDate
        self.exercises = []
    }
}
