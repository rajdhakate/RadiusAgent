//
//  ViewModel.swift
//  RadiusAgent
//
//  Created by Raj  Dhakate on 30/06/23.
//

import Foundation

@MainActor
final class ContentViewModel: ObservableObject {
    
    @MainActor @Published private(set) var facilitiesData = FacilitiesData()
    
    let networkManager = NetworkManagerActor()
    
    @Published var selectedFacilities: [Exclusion] = []
    
    func fetchFacilities() {
        Task {
            do {
                facilitiesData = try await networkManager.getData()
                print("Loaded");
            } catch {
                print(error)
            }
            
        }
    }
    
    func isSelected(facility: Facility, option: FacilityOption) -> Bool {
        let selected = Exclusion(facilityID: facility.facilityID, optionsID: option.id)
        return selectedFacilities.contains([selected])
    }
    
    func selectFacility(facility: Facility, option: FacilityOption) {
        let selected = Exclusion(facilityID: facility.facilityID, optionsID: option.id)
        
        let alreadySelected = selectedFacilities.contains { exclusion in
            exclusion.facilityID == selected.facilityID && option.id == exclusion.optionsID
        }
        selectedFacilities.removeAll { exclusion in
            exclusion.facilityID == selected.facilityID
        }
        
        if !alreadySelected {
            selectedFacilities.append(selected)
        }
    }
    
    func getFilteredOptions(facility: Facility) -> [FacilityOption] {
        var options = facility.options

        for selectedFacility in selectedFacilities {
            if selectedFacility.facilityID == facility.facilityID { return options }
            
            if let excludedPair = facilitiesData.exclusions.first(where: { array in
                array.contains(selectedFacility)
            }) {
                
                for pair in excludedPair {
                    options.removeAll { option in
                        option.id == pair.optionsID && pair.facilityID == facility.facilityID
                    }
                }
            }
        }
        return options
    }
}
