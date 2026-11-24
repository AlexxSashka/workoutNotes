//
//  Created by Gryaznoy Alexander on 11.11.2026.
//
import UIKit

final class WorkoutCell: UICollectionViewCell { // надо будет переименовать в WorkoutCell

    static let reuseIdentifier = "WorkoutCell"

    // MARK: - Subviews

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail

        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textAlignment = .left

        return label
    }()

    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white

        return view
    }()

    private let exerciseCountImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "list.bullet.clipboard")
        imageView.tintColor = .white

        return imageView
    }()

    private let exerciseLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .left

        return label
    }()

    private let timerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "stopwatch")
        imageView.tintColor = .white

        return imageView
    }()

    private let timerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .left

        return label
    }()

    private let chevronImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .white

        return imageView
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setups

    private func setupView() {
        contentView.backgroundColor = Constants.cellColor

        contentView.layer.cornerRadius = 20
    }

    private func addSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(separatorView)
        contentView.addSubview(exerciseCountImage)
        contentView.addSubview(exerciseLabel)
        contentView.addSubview(timerImage)
        contentView.addSubview(timerLabel)
        contentView.addSubview(chevronImage)
    }

    // MARK: - Configure

    public func configure(
        workoutModel: WorkoutModel
    ) {
        titleLabel.text = workoutModel.workoutTitle
        dateLabel.text = workoutModel.createWorkoutDate.formatted(date: .abbreviated, time: .shortened)
        exerciseLabel.text = "\(workoutModel.exercises.count) Exercises"
//        if let duration = workoutModel.durationMinutes {
//            timerLabel.text = "\(duration) mins"
//        } else {
//            timerLabel.text = "-"
//        } надо будет поправить
    }

    // MARK: - Layout

    public override func layoutSubviews() {

        titleLabel.frame = .init(
            origin: .init(
                x: 10,
                y: 10
            ),
            size: .init(
                width: contentView.frame.width - 20,
                height: 28
            )
        )

        dateLabel.frame = .init(
            x: 10,
            y: titleLabel.frame.maxY,
            width: contentView.bounds.width / 2,
            height: 30
        )

        separatorView.frame = .init(
            x: 10,
            y: dateLabel.frame.maxY + 3,
            width: contentView.bounds.width - 20,
            height: 0.5
        )

        exerciseCountImage.frame = .init(
            x: 10,
            y: separatorView.frame.maxY + 10,
            width: 24,
            height: 24
        )

        let exerciseLabelSize = exerciseLabel.sizeThatFits(
            CGSize(
                width: contentView.frame.width / 2,
                height: 30
            )
        )
        exerciseLabel.frame = .init(
            origin: .init(
                x: exerciseCountImage.frame.maxX + 5,
                y: exerciseCountImage.frame.midY - exerciseLabelSize.height / 2
            ),
            size: exerciseLabelSize
        )

        timerImage.frame = .init(
            origin: .init(
                x: exerciseLabel.frame.maxX + 20,
                y: exerciseCountImage.frame.origin.y
            ),
            size: CGSize(width: 24, height: 24)
        )

        let timerLabelSize = timerLabel.sizeThatFits(
            CGSize(
                width: contentView.frame.width / 2,
                height: 30
            )
        )
        timerLabel.frame = .init(
            origin: .init(
                x: timerImage.frame.maxX + 5,
                y: timerImage.frame.midY - timerLabelSize.height / 2
            ),
            size: timerLabelSize
        )

        chevronImage.frame = .init(
            origin: .init(
                x: contentView.frame.maxX - 12 - 10,
                y: timerImage.frame.origin.y
            ),
            size: CGSize(width: 10, height: 12)
        )
    }
}

private extension WorkoutCell {

    private struct Constants {
        static let cellColor: UIColor = UIColor(
            red: 0xC4 / 255,
            green: 0x7C / 255,
            blue: 0x14 / 255,
            alpha: 1.0
        )
    }
}
