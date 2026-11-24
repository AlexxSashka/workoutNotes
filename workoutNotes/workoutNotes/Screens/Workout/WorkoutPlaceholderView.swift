//
//  Created by Gryaznoy Alexander on 21.11.2026.
//

import UIKit

final class WorkoutPlaceholderView: UIView {

    // MARK: - Subviews

    let imageView: UIImageView = {
        let config = UIImage.SymbolConfiguration(pointSize: 100)

        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "dumbbell",withConfiguration: config)
        imageView.tintColor = .brown
        imageView.contentMode = .scaleAspectFit


        return imageView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()

        label.text = "Создай свою первую тренировку"
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center

        return label
    }()

    let addWorkoutButton: UIButton = {
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

        let button = UIButton()
        button.configuration = config

        button.addTarget(
            self,
            action: #selector(didTapAddWorkout),
            for: .touchUpInside
        )

        return button
    }()

    let addWorkoutAction: () -> Void

    init(
        addWorkoutAction: @escaping () -> Void
    ) {
        self.addWorkoutAction = addWorkoutAction
        super.init(frame: .zero)

        clipsToBounds = true

        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(addWorkoutButton)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    private func didTapAddWorkout() {
        addWorkoutAction()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

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
