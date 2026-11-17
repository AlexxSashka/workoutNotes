//
//  Created by Gryaznoy Alexander on 17.11.2026.
//

import UIKit


class MainTabBarController: UITabBarController {

    private struct Constants {
        static let workoutControllerImage = UIImage(systemName: "figure.highintensity.intervaltraining")
        static let exercisesControllerImage = UIImage(systemName: "dumbbell")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabs()
    }

    private func setupTabs() {
        let workoutController = UINavigationController(rootViewController: WorkoutController())
        workoutController.tabBarItem.image = Constants.workoutControllerImage

        let exercisesController = UINavigationController(rootViewController: ExercisesController())
        exercisesController.tabBarItem.image = Constants.exercisesControllerImage

        viewControllers = [workoutController, exercisesController]
    }
}
