//
//  Created by Gryaznoy Alexander on 15.10.2026.
//

import UIKit
import SwiftData

class WorkoutController: UIViewController {

    private let modelContext: ModelContext
    private var workouts: [WorkoutModel] = []

    init(
        modelContext: ModelContext
    ) {
        self.modelContext = modelContext
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private struct Constants {
        static let cellHorizontalPadding: CGFloat = 20
        static let itemHeight: CGFloat = 40
    }

    // MARK: - Subviews

    let rightButton: UIButton = {
        let button = UIButton()

        let imageConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .bold)
        let image = UIImage(systemName: "plus", withConfiguration: imageConfig)

        button.setImage(image, for: .normal)
        button.tintColor = .white

        button.layer.cornerRadius = 32
        button.clipsToBounds = true

        return button
    }()

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .secondarySystemBackground

        return collectionView
    }()

    private lazy var placeholderView = WorkoutPlaceholderView() { [weak self] in
        self?.didTapAddWorkoutButton()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .secondarySystemBackground
        setupTitle()
        setupCollectionView()
        setupPlaceholder()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        loadWorkouts()
    }

    // MARK: - Layout

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        collectionView.frame = .init(
            origin: .zero,
            size: .init(
                width: view.bounds.width,
                height: view.bounds.height
            )
        )

        placeholderView.frame = .init(
            x: view.frame.width / 2 - 150,
            y: view.frame.height / 2 - 150,
            width: 300,
            height: 200
        )
    }

    private func setupTitle() {
        title = "Workouts"

        rightButton.addTarget(
            self,
            action: #selector(didTapAddWorkoutButton),
            for: .touchUpInside
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
    }

    private func setupCollectionView() {
        view.addSubview(collectionView)

        collectionView.register(
            WorkoutCell.self,
            forCellWithReuseIdentifier: WorkoutCell.reuseIdentifier
        )

        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func setupPlaceholder() {
        placeholderView.isHidden = true
        view.addSubview(placeholderView)
    }

    @objc
    private func didTapAddWorkoutButton() {
        let alertController = UIAlertController(
            title: "Добавить тренировку",
            message: nil,
            preferredStyle: .alert
        )

        alertController.addTextField { textField in
            textField.placeholder = "Название тренировки"
            textField.autocapitalizationType = .sentences
        }

        let addAction = UIAlertAction(
            title: "Добавить",
            style: .default
        ) { [weak self] _ in

            guard
                let self,
                let addText = alertController.textFields?.first?.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                !addText.isEmpty
            else {
                return
            }

            let workout = WorkoutModel(
                workoutTitle: addText,
                createWorkoutDate: .now
            )

            modelContext.insert(workout)

            do {
                try modelContext.save()
                loadWorkouts()
            } catch {
                print("Ошибка добавления \(error)")
                // надо сделать нормальный алерт
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)

        alertController.addAction(addAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true)
    }
}

extension WorkoutController: UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return workouts.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {

        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: WorkoutCell.reuseIdentifier,
                for: indexPath
            ) as? WorkoutCell
        else {
            return UICollectionViewCell()
        }

        cell.configure(
            workoutModel: workouts[indexPath.item]
        )

        return cell
    }
}

extension WorkoutController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(
            width: view.bounds.width - Constants.cellHorizontalPadding * 2,
            height: 110
        )
    }

    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let detailController = WorkoutDetailController(
            modelContext: modelContext,
            workout: workouts[indexPath.item]
        )
        navigationController?.pushViewController(detailController, animated: true)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        contextMenuConfigurationForItemAt indexPath: IndexPath,
        point: CGPoint
    ) -> UIContextMenuConfiguration? {

        return UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: nil
        ) { [weak self] _ in

            let editAction = UIAction(
                title: "Редактировать",
                image: UIImage(systemName: "pencil")
            ) { [weak self] _ in

                let workout = self?.workouts[indexPath.item]
                let oldTitle = workout?.workoutTitle

                let alertController = UIAlertController(
                    title: "Редактирование",
                    message: nil,
                    preferredStyle: .alert
                )

                alertController.addTextField { textField in
                    textField.placeholder = "Название тренировки"
                    textField.autocapitalizationType = .sentences
                    textField.text = oldTitle
                }

                let saveAction = UIAlertAction(
                    title: "Сохранить",
                    style: .default
                ) { [weak self] _ in

                    guard
                        let self,
                        let newTitle = alertController.textFields?.first?.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                        !newTitle.isEmpty, // добавить в данном случае алерт с предложением удалить тренировку
                        oldTitle != newTitle
                    else {
                        return
                    }

                    workout?.workoutTitle = newTitle

                    do {
                        try self.modelContext.save()
                        self.collectionView.reloadItems(at: [indexPath])
                    } catch {
                        print("Не получилось изменить название: \(error)")
                    }
                }

                let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)

                alertController.addAction(saveAction)
                alertController.addAction(cancelAction)

                self?.present(alertController, animated: true)
            }

            let deleteAction = UIAction(
                title: "Удалить",
                image: UIImage(systemName: "trash.fill"),
                attributes: .destructive
            ) { [weak self] _ in
                self?.deleteWorkout(indexPath: indexPath)
            }

            return UIMenu(
                title: "",
                children: [editAction, deleteAction]
            )
        }
    }
}

    // MARK: - Work with SwiftData

private extension WorkoutController {

    private func loadWorkouts() {
        let descriptor = FetchDescriptor<WorkoutModel>(
            sortBy: [SortDescriptor(\.createWorkoutDate, order: .reverse)]
        )
        workouts = (try? modelContext.fetch(descriptor)) ?? []
        collectionView.reloadData()
        placeholderView.isHidden = !workouts.isEmpty
    }

    private func deleteWorkout(indexPath: IndexPath) {

        let workout = workouts[indexPath.item]

        modelContext.delete(workout)

        do {
            try modelContext.save()
            workouts.remove(at: indexPath.item)
            collectionView.deleteItems(at: [indexPath])

            placeholderView.isHidden = !workouts.isEmpty
        } catch {
            print("Ошибка удаления \(error)")
        }
    }
}
