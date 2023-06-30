//
//  ContentView.swift
//  RadiusAgent
//
//  Created by Raj  Dhakate on 30/06/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        
        Group {
            ScrollView(.vertical) {
                VStack {
                    ForEach(viewModel.facilitiesData.facilities, id: \.self) { facility in
                        HStack {
                            VStack {
                                SimpleTitle(title: facility.name)
                                Spacer()
                            }
                            
                            Spacer()
                            
                            VStack {
                                ForEach(viewModel.getFilteredOptions(facility: facility), id: \.self) { option in
                                    Group {
                                        SelectButton(facility: facility, option: option, isSelected: viewModel.isSelected(facility: facility, option: option)) { facility, option in
                                            onTapAction(facility: facility, option: option)
                                        }
                                        
                                        Spacer()
                                    }
                                }
                            }
                            
                            Spacer()
                            Spacer()
                        }
                        
                        Divider()
                    }
                }
            }
        }
        .padding()
        .onAppear {
            viewModel.fetchFacilities()
        }
    }
    
    func onTapAction(facility: Facility, option: FacilityOption) {
        viewModel.selectFacility(facility: facility, option: option)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
