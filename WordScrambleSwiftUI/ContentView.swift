//
//  ContentView.swift
//  WordScrambleSwiftUI
//
//  Created by Anastasiia Veremiichyk on 11/09/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""

    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .autocapitalization(.none)
                }

                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
        }
    }

    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard !answer.isEmpty else { return }

        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
    }

    func startGame() {
        guard let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"),
              let startWords = try? String(contentsOf: startWordsURL) else {
            fatalError("Could not load start.txt from bundle.")
        }

        let allWords = startWords.components(separatedBy: "\n")
        rootWord = allWords.randomElement() ?? "silkworm"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
