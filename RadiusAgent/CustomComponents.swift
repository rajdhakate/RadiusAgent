//
//  CustomComponents.swift
//  RadiusAgent
//
//  Created by Raj  Dhakate on 30/06/23.
//

import SwiftUI

struct SelectButton: View {
    
    let facility: Facility
    let option: FacilityOption
    let isSelected: Bool
    let onTapAction: (_ facility: Facility, _ option: FacilityOption) -> ()
    
    var body: some View {
        
        HStack {
            Image(option.icon)
            
            Text(option.name)
            
            if isSelected {
                Image(systemName: "checkmark.square.fill")
            }
        }
        .padding()
        .foregroundColor(.cyan)
        .background(Color.black)
        .cornerRadius(8)
        .onTapGesture {
            onTapAction(facility, option)
        }
    }
    
}

struct SimpleTitle: View {
    
    let title: String
    
    var body: some View {
        Text(title + ":")
            .padding()
            .cornerRadius(8)
    }
    
}
