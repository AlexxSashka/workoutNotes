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

    private let dateIcon = UIImageView()
    private let dateLabel = UILabel()

    private let timeIcon = UIImageView()
    private let timeLabel = UILabel()

    private let exerciseIcon = UIImageView()
    private let exerciseLabel = UILabel()

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
        setupTitleFooter()
    }

    // MAKR: - Setups

    private func setupTitle() {
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 25, weight: .bold)
        titleLabel.text = workout.title
        titleLabel.textAlignment = .left
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
        let oldTitle = self.workout.title

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

            self.workout.title = newTitle
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

    private func setupTitleFooter() {

        dateIcon.image = UIImage(systemName: "calendar")
        dateIcon.tintColor = .systemGreen
        dateLabel.text = workout.date.relativeText
        dateLabel.textColor = .white

        timeIcon.image = UIImage(systemName: "clock")
        timeIcon.tintColor = .systemGreen
        timeLabel.textColor = .white
        if let durationMinutes = workout.durationMinutes {
            timeLabel.text = String(durationMinutes)
        } else {
            timeLabel.text = "-"
        }

        view.addSubview(dateIcon)
        view.addSubview(dateLabel)

        view.addSubview(timeIcon)
        view.addSubview(timeLabel)

        view.addSubview(exerciseIcon)
        view.addSubview(exerciseLabel)
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
                height: 28
            )
        )

        dateIcon.frame = .init(
            x: 10,
            y: titleLabel.frame.maxY + 10,
            width: 24,
            height: 24
        )
        let dateLabelSize = dateLabel.sizeThatFits(
            CGSize(
                width: 60,
                height: 30
            )
        )
        dateLabel.frame = .init(
            x: dateIcon.frame.maxX + 5,
            y: dateIcon.frame.origin.y,
            width: dateLabelSize.width,
            height: dateLabelSize.height
        )

        timeIcon.frame = .init(
            x: dateLabel.frame.maxX + 5,
            y: dateIcon.frame.origin.y,
            width: 24,
            height: 24
        )
        let timeLabelSize = timeLabel.sizeThatFits(
            CGSize(
                width: 30,
                height: 30
            )
        )
        timeLabel.frame = .init(
            origin: .init(
                x: timeIcon.frame.maxX + 3,
                y: timeIcon.frame.origin.y
            ),
            size: timeLabelSize
        )
    }
}


private extension Date {
    var relativeText: String {
        let calendar = Calendar.current

        if calendar.isDateInToday(self) {
            return "Today, " + formatted(.dateTime.hour().minute())
        } else if calendar.isDateInYesterday(self) {
            return "Yesterday, " + formatted(.dateTime.hour().minute())
        } else {
            return formatted(.dateTime.month(.abbreviated).day().hour().minute())
        }
    }
}
