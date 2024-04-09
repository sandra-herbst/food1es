//
//  SuggestionsViewModel.swift
//  food1es
//
//  Created by Sandra Herbst on 27.06.22.
//

import Foundation
import TabularData

class SuggestionsViewModel: ObservableObject {
    private var searchableGroceryItemList: [String] = []
    @Published var searchInput: String = "" {
        didSet {
            filterSuggestions()
        }
    }
    @Published var suggestions: [String] = []
    
    init() {
        convertCSV(fileName: "topIngredients")
        suggestions = searchableGroceryItemList
    }
    
    func convertCSV(fileName: String) {
        let url = Bundle.main.url(forResource: fileName, withExtension: "csv")!
        let result = try? DataFrame(contentsOfCSVFile: url).rows.map({ row in
            (row.first as! String).components(separatedBy: ";")[0].capitalizingFirstLetter()
        })
        print(result!)
        self.searchableGroceryItemList = result!
    }
    
    func resetState() {
        searchInput = ""
        suggestions = searchableGroceryItemList
    }
    
    func filterSuggestions() {
        self.suggestions = FilterSortHelper.filterStringList(searchInput: searchInput, allStrings: searchableGroceryItemList)
    }
}
