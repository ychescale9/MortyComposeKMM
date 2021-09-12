import Foundation
import SwiftUI
import shared

class CharacterListViewModel: ObservableObject {
    @Published public var characters: [CharacterDetail] = []
    let repository = MortyRepository()
    var hasNextPage: Bool = false
    
    func fetchCharacters() {
        // this crashes
        createFuture(for: repository.getCharactersNative(page: 0))
            .assertNoFailure()
            .sink { _ in }
            .store(in: &subscriptions)
        
        // this also crashes
        createPublisher(for: repository.characterPagerFlowNative)
            .assertNoFailure()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("Received completion: \(completion)")
            } receiveValue: { value in
                print("Received value: \(value)")
            }
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

