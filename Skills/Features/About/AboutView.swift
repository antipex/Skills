//
//  AboutView.swift
//  Skills
//
//  Created by Kyle Rohr on 20/11/2024.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: .Spacing.six) {
            Text("In a time period where egregious and unnecessary coding assessments have become commonplace, many employers have forgotten that job candidates are human beings.")
            Text("This app was designed as both a code example and a learning tool for potential employers.")
            VStack(alignment: .leading, spacing: .Spacing.two) {
                Text("Created by Kyle Rohr")
                    .typography(.info)
                Text("https://www.kylerohr.com/")
            }
        }
        .typography(.bodyXL)
        .padding(.horizontal, .Spacing.six)
        .navigationTitle("About")
    }
}

#Preview {
    AboutView()
}
