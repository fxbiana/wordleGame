import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WordleViewModel()

    var body: some View {
        VStack {
            ForEach(0..<viewModel.maxAttempts, id: \.self) { row in
                HStack {
                    ForEach(0..<viewModel.wordLength, id: \.self) { col in
                        LetterBoxView(letter: viewModel.grid[row][col])
                    }
                }
            }
            Spacer()
            KeyboardView(viewModel: viewModel)
        }
        .padding()
        .alert(isPresented: $viewModel.showingWinAlert) {
            Alert(
                title: Text("You Win!"),
                message: Text("Nice job!"),
                dismissButton: .default(Text("OK")) {
                    viewModel.resetGrid()
                }
            )
        }
        .alert(isPresented: $viewModel.showingLoseAlert) {
            Alert(
                title: Text("You Lost!"),
                message: Text("Better luck next time. The word was \(viewModel.solution)."),
                dismissButton: .default(Text("Play Again")) {
                    viewModel.resetGrid()
                }
            )
        }
    }
}
