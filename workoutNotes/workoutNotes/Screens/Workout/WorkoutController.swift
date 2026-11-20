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

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .secondarySystemBackground
        setupTitle()
        setupCollectionView()
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
    }

    private func setupTitle() {
        title = "Workouts"

        rightButton.addTarget(
            self,
            action: #selector(didTapAddTrainingButton),
            for: .touchUpInside
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
    }

    private func setupCollectionView() {
        view.addSubview(collectionView)

        collectionView.register(
            MainCell.self,
            forCellWithReuseIdentifier: MainCell.reuseIdentifier
        )

        collectionView.dataSource = self
        collectionView.delegate = self
    }

    @objc
    private func didTapAddTrainingButton() {
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
                title: addText,
                date: .now,
                durationMinutes: 0
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
                withReuseIdentifier: MainCell.reuseIdentifier,
                for: indexPath
            ) as? MainCell
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
        didSelectItemAt indexPath: IndexPath) {
            print("Нажали на \(workouts[indexPath.item].title)")
    }
}

    // MARK: - Work with SwiftData

private extension WorkoutController {

    private func loadWorkouts() {
        let descriptor = FetchDescriptor<WorkoutModel>(
            sortBy: [SortDescriptor(\.date, order: .reverse)]
        )
        workouts = (try? modelContext.fetch(descriptor)) ?? []
        collectionView.reloadData()
    }
}
