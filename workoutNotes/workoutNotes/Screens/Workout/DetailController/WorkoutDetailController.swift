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

    private let titleLabel = UILabel()

    private lazy var headerView = DetailHeaderView(workout: workout)

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

        setupTitle()
        setupHeader()
    }

    // MAKR: - Setups

    private func setupTitle() {
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 35, weight: .bold)
        titleLabel.text = workout.workoutTitle
        titleLabel.textAlignment = .left
        view.addSubview(titleLabel)

        editRightButton.addTarget(
            self,
            action: #selector(didTapEditButton),
            for: .touchUpInside
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: editRightButton)
    }

    private func setupHeader() {
        view.addSubview(headerView)
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

