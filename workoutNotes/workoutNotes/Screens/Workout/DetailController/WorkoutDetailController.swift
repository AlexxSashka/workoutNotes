//
//  Created by Gryaznoy Alexander on 20.11.2026.
//

import UIKit
import SwiftData

final class WorkoutDetailController : UIViewController {

    // MARK: - Subviews

    private let editRightButton: UIButton = {
        let button = UIButton()

        let imageConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .bold)
        let image = UIImage(systemName: "pencil",withConfiguration: imageConfig)
        button.setImage(image, for: .normal)
        button.tintColor = .white

        return button
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 35, weight: .bold)
        label.textAlignment = .left

        return label
    }()

    private lazy var headerView: DetailHeaderView = {
        let header = DetailHeaderView(frame: .zero)
        header.configure(workout: workout)

        return header
    }()

    private let button: UIButton = {
        let button = UIButton()

        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .brown
        config.baseForegroundColor = .white
        config.cornerStyle = .large
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = .systemFont(ofSize: 16, weight: .medium)

            return outgoing
        }

        button.configuration = config

        return button
    }()

    // MARK: - Model

    let workout: WorkoutModel
    let modelContext: ModelContext

    // MARK: Init

    init(
        modelContext: ModelContext,
        workout: WorkoutModel
    ) {
        self.workout = workout
        self.modelContext = modelContext
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .secondarySystemBackground

        setup()
    }

    // MAKR: - Setups

    private func setup() {
        titleLabel.text = workout.workoutTitle

        view.addSubview(headerView)
        view.addSubview(titleLabel)

        editRightButton.addTarget(
            self,
            action: #selector(didTapEditButton),
            for: .touchUpInside
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: editRightButton)
    }

    @objc
    private func didTapEditButton() {
        let alertController = UIAlertController(
            title: "Жопа",
            message: nil,
            preferredStyle: .alert
        )
        let oldTitle = self.workout.workoutTitle

        alertController.addTextField { textField in
            textField.text = oldTitle
            textField.placeholder = "Название тренировки"
            textField.autocapitalizationType = .sentences
        }

        let saveAction = UIAlertAction(
            title: "Сохранить",
            style: .default
        ) { [weak self] _ in
            guard
                let self,
                let newTitle = alertController.textFields?.first?.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                !newTitle.isEmpty,
                oldTitle != newTitle
            else {
                return
            }

            self.workout.workoutTitle = newTitle
            do {
                try self.modelContext.save()
                titleLabel.text = newTitle
            } catch {
                print("Не получилось изменить название: \(error)")
            }
        }
        let cancelAction = UIAlertAction(title: "Отменить", style: .cancel)

        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true)
    }

    // MARK: - Layout

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        titleLabel.frame = .init(
            origin: .init(
                x: 10,
                y: view.safeAreaInsets.top
            ),
            size: .init(
                width: view.frame.width - 10,
                height: 35
            )
        )

        headerView.frame = .init(
            x: 0,
            y: titleLabel.frame.maxY,
            width: view.frame.width,
            height: 40
        )
    }
}

