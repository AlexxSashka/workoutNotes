//
//  Created by Gryaznoy Alexander on 11.11.2026.
//
import UIKit

final class MainCell: UICollectionViewCell {

    private struct Constants {
        static let cellColor: UIColor = UIColor(
            red: 0xC4 / 255,
            green: 0x7C / 255,
            blue: 0x14 / 255,
            alpha: 1.0
        )
    }

    static let reuseIdentifier = "WorkoutCell"

    // MARK: - Subviews

    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let separatorView = UIView()
    private let countExerciseImage = UIImageView() // change name
    private let exerciseLabel = UILabel()
    private let timerImage = UIImageView()
    private let timerLabel = UILabel()
    private let chevronImage = UIImageView()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
        setupTitle()
        setupDate()
        setupSeparator()
        setupExerciseCountImage()
        setupExerciseLabel()
        setupTimerImage()
        setupTimerLabel()
        setupChevronImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setups

    private func setupView() {
        contentView.backgroundColor = Constants.cellColor

        contentView.layer.cornerRadius = 20
    }

    private func setupTitle() {
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        titleLabel.textAlignment = .left

        contentView.addSubview(titleLabel)
    }

    private func setupDate() {
        dateLabel.textColor = .white
        dateLabel.font = .systemFont(ofSize: 12, weight: .light)
        dateLabel.textAlignment = .left

        contentView.addSubview(dateLabel)
    }

    private func setupSeparator() {
        separatorView.backgroundColor = .white

        contentView.addSubview(separatorView)
    }

    private func setupExerciseCountImage() {
        countExerciseImage.image = UIImage(systemName: "list.bullet.clipboard")
        countExerciseImage.tintColor = .white

        contentView.addSubview(countExerciseImage)
    }

    private func setupExerciseLabel() {
        exerciseLabel.textColor = .white
        exerciseLabel.font = .systemFont(ofSize: 12, weight: .medium)
        exerciseLabel.textAlignment = .left

        contentView.addSubview(exerciseLabel)
    }

    private func setupTimerImage() {
        timerImage.image = UIImage(systemName: "stopwatch")
        timerImage.tintColor = .white

        contentView.addSubview(timerImage)
    }

    private func setupTimerLabel() {
        timerLabel.textColor = .white
        timerLabel.font = .systemFont(ofSize: 12, weight: .medium)
        timerLabel.textAlignment = .left

        contentView.addSubview(timerLabel)
    }

    private func setupChevronImage() {
        chevronImage.image = UIImage(systemName: "chevron.right")
        chevronImage.tintColor = .white

        contentView.addSubview(chevronImage)
    }

    // MARK: - Configure

    public func configure(
        title: String,
        exerciseCount: Int,
        minutes: Int
    ) {
        titleLabel.text = title
        dateLabel.text = "Today, 9:05 AM"
        exerciseLabel.text = "\(exerciseCount) Exercises"
        timerLabel.text = "\(minutes) mins"
    }

    // MARK: - Layout

    public override func layoutSubviews() {

        let titleLabelSize = titleLabel.sizeThatFits(
            CGSize(
                width: contentView.frame.width / 2,
                height: 40
            )
        )

        titleLabel.frame = .init(
            x: 10,
            y: 10,
            width: titleLabelSize.width,
            height: titleLabelSize.height
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

        countExerciseImage.frame = .init(
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
                x: countExerciseImage.frame.maxX + 5,
                y: countExerciseImage.frame.midY - exerciseLabelSize.height / 2
            ),
            size: exerciseLabelSize
        )

        timerImage.frame = .init(
            origin: .init(
                x: exerciseLabel.frame.maxX + 20,
                y: countExerciseImage.frame.origin.y
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
