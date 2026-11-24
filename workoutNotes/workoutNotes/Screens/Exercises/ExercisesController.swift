//
//  Created by Gryaznoy Alexander on 17.11.2026.
//

import UIKit

class ExercisesController: UIViewController {

    // MARK: - Subviews

    let addExerciseButton: UIButton = {
        let button = UIButton()

        let imageConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .bold)
        let image = UIImage(systemName: "plus", withConfiguration: imageConfig)

        button.setImage(image, for: .normal)
        button.tintColor = .white

        button.layer.cornerRadius = 32
        button.clipsToBounds = true

        button.addTarget(
            self,
            action: #selector(didTapAddExercise),
            for: .touchUpInside
        )

        return button
    }()

    @objc
    private func didTapAddExercise() {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Exercises"

        setup()
        setupAddExerciseButton()
    }

    private func setup() {
        view.backgroundColor = .secondarySystemBackground
    }

    private func setupAddExerciseButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addExerciseButton)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }
}
