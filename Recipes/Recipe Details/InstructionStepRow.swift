//
//  InstructionStepRow.swift
//  Recipes
//
//  Created by Blaine Fahey on 5/24/23.
//

import SwiftUI

struct InstructionStepRow: View {
    let number: Int
    let instructions: String
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(number.formatted(.number))
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text(instructions)
                .font(.body)
        }
    }
}

struct InstructionStepRow_Previews: PreviewProvider {
    static var previews: some View {
        InstructionStepRow(number: 1, instructions: "If you want to make a pie from scratch, you must first create the universe.")
    }
}
