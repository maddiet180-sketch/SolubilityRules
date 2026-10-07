import SwiftUI

struct HomeView: View {
    @State var path = NavigationPath()
    @StateObject private var viewModel = HomeViewModel()
    
    @State private var isShowingQuestionPicker: Bool = false
    @State private var questionCount: Int = 3
    
    var body: some View {
        NavigationStack(path: $path) {
            GeometryReader { geo in
                ZStack {
                    Image("HomeBackground")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea(edges: .all)

                    VStack(spacing: geo.size.height / 30) {
                        Image("HomeTitle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width * 0.75)

                        Group {
                            Button("LEARN") {
                                isShowingQuestionPicker = true
                            }
                            .buttonStyle(OutlinedButtonStyle(background: .primaryCream, text: .primaryBrown, outline: .primaryBrown))

                            Button("EXPLORE") {
                                path.append(Route.explore)
                            }
                            .buttonStyle(OutlinedButtonStyle(background: .primaryCream, text: .primaryBrown, outline: .primaryBrown))
                        }
                        .frame(width: geo.size.width * 0.5)
                    }
                    .padding(.bottom, geo.size.height / 4)
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .learn(let count):
                    LearnView(questionCount: count)
                case .explore:
                    ExploreView()
                }
            }
            .sheet(isPresented: $isShowingQuestionPicker) {
                QuestionCountPopUp(count: $questionCount,
                                   maxCount: QuestionDatabase.all.count) { count in
                    isShowingQuestionPicker = false
                    path.append(Route.learn(questionCount: count))
                }
            }
        }
        .appTheme()
    }
}

enum Route: Hashable {
    case learn(questionCount: Int)
    case explore
}

