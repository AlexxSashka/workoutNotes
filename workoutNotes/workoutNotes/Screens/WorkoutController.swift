//
//  Created by Gryaznoy Alexander on 15.10.2026.
//

import UIKit

class WorkoutController: UIViewController {

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

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTitle()
    }

    func setupTitle() {

        title = "Workouts"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
    }
}

