//
//  Created by Gryaznoy Alexander on 21.11.2026.
//

import UIKit

final class WorkoutPlaceholderView: UIView {

    let imageView = UIImageView()
    let titleLabel = UILabel()
    let addWorkoutButton = UIButton()

    let addWorkoutAction: () -> Void

    init(
        addWorkoutAction: @escaping () -> Void
    ) {
        self.addWorkoutAction = addWorkoutAction
        super.init(frame: .zero)

        clipsToBounds = true

        setupImageView()
        setupTitleLabel()
        setupAddWorkoutButton()
    }

    // MARK: - Setups

    private func setupImageView() {
        let config = UIImage.SymbolConfiguration(pointSize: 100)
        imageView.image = UIImage(systemName: "dumbbell", withConfiguration: config)
        imageView.tintColor = .brown
        imageView.contentMode = .scaleAspectFit

        addSubview(imageView)
    }

    private func setupTitleLabel() {
        titleLabel.text = "Создай свою первую тренировку"
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center

        addSubview(titleLabel)
    }

    private func setupAddWorkoutButton() {
        var config = UIButton.Configuration.filled()
        config.title = "Добавить тренировку"
        config.baseBackgroundColor = .brown
        config.baseForegroundColor = .white
        config.cornerStyle = .large

        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = .systemFont(ofSize: 16, weight: .medium)

            return outgoing
        }

        addWorkoutButton.configuration = config

        addWorkoutButton.addTarget(self, action: #selector(didTapAddWorkout), for: .touchUpInside)

        addSubview(addWorkoutButton)
    }

    @objc
    private func didTapAddWorkout() {
        addWorkoutAction()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {

        let imageSize = imageView.image?.size ?? CGSize(width: 100, height: 100)
        imageView.frame = .init(
            x: bounds.width / 2 - imageSize.width / 2,
            y: 0,
            width: imageSize.width,
            height: imageSize.height
        )

        titleLabel.frame = .init(
            x: 0,
            y: imageView.frame.maxY + 10,
            width: bounds.width,
            height: 25
        )

        addWorkoutButton.frame = .init(
            x: bounds.width / 2 - 100,
            y: titleLabel.frame.maxY + 15,
            width: 200,
            height: 40
        )
    }
}
