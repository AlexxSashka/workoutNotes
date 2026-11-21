//
//  Created by Gryaznoy Alexander on 17.11.2026.
//

import UIKit
import SwiftData

class MainTabBarController: UITabBarController {

    private let modelContext: ModelContext

    init(
        modelContext: ModelContext
    ) {
        self.modelContext = modelContext
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabs()
    }

    private func setupTabs() {
        let workoutController = UINavigationController(
            rootViewController: WorkoutController(
                modelContext: modelContext
            )
        )
        workoutController.tabBarItem.image = Constants.workoutControllerImage
        workoutController.tabBarItem.title = "Workouts"

        let exercisesController = UINavigationController(rootViewController: ExercisesController())
        exercisesController.tabBarItem.image = Constants.exercisesControllerImage
        exercisesController.tabBarItem.title = "Exercises"

        viewControllers = [workoutController, exercisesController]
    }
}

private extension MainTabBarController {

    private struct Constants {
        static let workoutControllerImage = UIImage(systemName: "figure.highintensity.intervaltraining")
        static let exercisesControllerImage = UIImage(systemName: "dumbbell")
    }

}
