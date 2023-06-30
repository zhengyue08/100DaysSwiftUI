//
//  ContentView.swift
//  WordScramble
//
//  Created by Yue ZHENG on 2023/6/26.
//

import SwiftUI

struct ContentView: View {
    @State private var newWord: String = ""
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    
    
    // alert
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Input your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                
                Section {
                    ForEach(usedWords, id: \.self) {word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
                Text(usedWords.count, format:.number)
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWordtoList)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK"){}
            } message: {
                Text(errorMessage)
            }
            .toolbar {
                Button("Restart") {
                    startGame()
                }
            }
            
        }

    }
    
    func addNewWordtoList() {
        let formattedWord = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard formattedWord.count > 0  else {return}
        
        guard isOriginal(word: formattedWord) else {
            wordError(title: "Word was used", message: "Try another one")
            newWord = ""
            return
        }
        
        guard isReal(word: formattedWord) else {
            wordError(title: "Not an correct word", message: "Maybe you misspelt it")
            newWord = ""
            return
        }
        
        guard isPossible(word: formattedWord) else {
            wordError(title: "Follow rules", message: "You can only use characters in \"\(rootWord)\"")
            newWord = ""
            return
        }
        
        guard isLongEnough(word: formattedWord) else {
            wordError(title: "Too short", message: "Try a word consists of at least 3 characters")
            newWord = ""
            return
        }
        
        
        withAnimation {
            usedWords.insert(formattedWord, at: 0)
            newWord = ""
        }
        

    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allowWords = startWords.components(separatedBy: "\n")
                rootWord = allowWords.randomElement() ?? "silkworm"
                usedWords.removeAll()
                newWord = ""
                return
            }
        }

        fatalError("Couldn't load start.txt file")
    }
    
    func isOriginal(word: String) -> Bool {
        if usedWords.contains(word) || (word == rootWord) {
            return false
        } else {
            return true
        }
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func isLongEnough (word: String) -> Bool {
        return word.count < 3 ? false : true
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
