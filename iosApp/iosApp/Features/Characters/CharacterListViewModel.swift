import Foundation
import SwiftUI
import shared

class CharacterListViewModel: ObservableObject {
    @Published public var characters: [CharacterDetail] = []
    let repository = MortyRepository()
    var hasNextPage: Bool = false
    
    func fetchCharacters() {
        repository.getCharacters(page: 0) { result, error in
            
        }
    }
    
    
    func fetchNextData() {
        repository.characterPager.loadNext()
    }
    
    public var shouldDisplayNextPage: Bool {
        return hasNextPage
    }
}

