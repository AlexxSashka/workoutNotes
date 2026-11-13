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

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
        setupTitle()
        setupDate()
        setupSeparator()
        setupExerciseCountImage()
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

    // MARK: - Configure

    public func configure(title: String) {
        titleLabel.text = title
        dateLabel.text = "Today, 9:05 AM"
    }

    // MARK: - Layout

    public override func layoutSubviews() {

        let maxAvailableWidth = contentView.frame.width / 2
        let titleLabelSize = titleLabel.sizeThatFits(
            .init(
                width: maxAvailableWidth,
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
            y: separatorView.frame.maxY + 3,
            width: 24,
            height: 24
        )
    }
}
