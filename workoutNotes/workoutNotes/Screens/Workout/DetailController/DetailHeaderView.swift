//
//  Created by Gryaznoy Alexander on 22.11.2026.
//

import UIKit

final class DetailHeaderView: UIView {

    // MARK: - Subviews

    private let dateIcon = UIImageView()
    private let dateLabel = UILabel()

    private let timeIcon = UIImageView()
    private let timeLabel = UILabel()

    private let exerciseIcon = UIImageView()
    private let exerciseLabel = UILabel()

    private let workout: WorkoutModel

    init(
        workout: WorkoutModel
    ) {
        self.workout = workout
        super.init(frame: .zero)

        setup() // разнести на методы
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        dateIcon.image = UIImage(systemName: "calendar")
        dateIcon.tintColor = .systemGreen
        dateLabel.text = workout.createWorkoutDate.relativeText
        dateLabel.textColor = .white

        timeIcon.image = UIImage(systemName: "clock")
        timeIcon.tintColor = .systemGreen
        timeLabel.textColor = .white
        if let startDate = workout.startWorkoutDate,
           let endDate = workout.endWorkoutDate {
            print("Заглушка \(startDate) и \(endDate)")
            // пока заглушка
        } else {
            timeLabel.text = "---"
        }

        addSubview(dateIcon)
        addSubview(dateLabel)

        addSubview(timeIcon)
        addSubview(timeLabel)

        addSubview(exerciseIcon)
        addSubview(exerciseLabel)
    }

    override func layoutSubviews() {

        dateIcon.frame = .init(
            x: 10,
            y: 10,
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
