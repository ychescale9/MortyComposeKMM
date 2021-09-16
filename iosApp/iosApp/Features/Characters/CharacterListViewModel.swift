import Foundation
import SwiftUI
import shared

class CharacterListViewModel: ObservableObject {
    @Published public var characters: [CharacterDetail] = []
    let repository = MortyRepository()
    var hasNextPage: Bool = false
    
    func fetchCharacters() {
        // this crashes due to unable to Freeze
        createFuture(for: repository.getCharactersNative(page: 0))
            .assertNoFailure()
            .sink { _ in }
            .store(in: &subscriptions)
        
        // this works
        repository.getCharacters(page: 0) { result, error in
            print(result)
        }
    }
    
    
    func fetchNextData() {
        repository.characterPager.loadNext()
    }
    
    public var shouldDisplayNextPage: Bool {
        return hasNextPage
    }
}

