//
//  Created by Gryaznoy Alexander on 20.11.2026.
//

import SwiftData

@Model
final class ApproachModel {
    var weight: Int = 0
    var amount: Int = 0
    var isDone: Bool = false
    var complexity: Complexity?

    init(
        weight: Int = 0,
        amount: Int = 0,
        isDone: Bool = false,
        complexity: Complexity? = nil
    ) {
        self.weight = weight
        self.amount = amount
        self.isDone = isDone
        self.complexity = complexity
    }
}

enum Complexity: String, Codable {
    case easy
    case medium
    case hard
}
