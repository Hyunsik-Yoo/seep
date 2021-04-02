import RxSwift
import RxCocoa
import ReactorKit

class PageItemReactor: Reactor {
  
  enum Action {
    case viewDidLoad(Void)
    case setViewType(ViewType)
    case tapFinishButton(Int)
  }
  
  enum Mutation {
    case fetchWishList([Wish])
    case setViewType(ViewType)
    case fetchHome(Void)
  }
  
  struct State {
    var wishiList: [Wish] = []
    var viewType: ViewType = .list
    var endRefresh: Bool = false
    var fetchHomeVC: Bool = false
  }
  
  let initialState = State()
  let wishService: WishServiceProtocol
  let userDefaults: UserDefaultsUtils
  let category: Category
  
  init(
    category: Category,
    wishService: WishServiceProtocol,
    userDefaults: UserDefaultsUtils
  ) {
    self.category = category
    self.wishService = wishService
    self.userDefaults = userDefaults
  }
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .viewDidLoad():
      let wishList = self.wishService.fetchAllWishes(category: self.category)
      
      return Observable.concat([
        Observable.just(Mutation.fetchWishList(wishList)),
        Observable.just(Mutation.setViewType(self.userDefaults.getViewType()))
      ])
    case .setViewType(let viewType):
      return Observable.just(Mutation.setViewType(viewType))
    case .tapFinishButton(let index):
      let tappedWish = self.currentState.wishiList[index]
      self.wishService.finishWish(wish: tappedWish)
      let wishList = self.wishService.fetchAllWishes(category: self.category)
      
      return Observable.concat([
        Observable.just(Mutation.fetchWishList(wishList)),
        Observable.just(Mutation.fetchHome(()))
      ])
    }
  }

  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case .fetchWishList(let wishList):
      newState.wishiList = wishList
      newState.endRefresh.toggle()
    case .setViewType(let viewType):
      newState.viewType = viewType
    case .fetchHome():
      newState.fetchHomeVC = false
      newState.fetchHomeVC = true
    }
    
    return newState
  }
}
