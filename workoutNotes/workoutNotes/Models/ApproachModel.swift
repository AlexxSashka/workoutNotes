//
//  Created by Gryaznoy Alexander on 20.11.2026.
//

import SwiftData

@Model
final class ApproachModel {
    var weight: Int
    var amount: Int
    var complexity: Complexity

    init(
        weight: Int,
        amount: Int,
        complexity: Complexity
    ) {
        self.weight = weight
        self.amount = amount
        self.complexity = complexity
    }
}

enum Complexity: String, Codable {
    case easy
    case medium
    case hard
}
