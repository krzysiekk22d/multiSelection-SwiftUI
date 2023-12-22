//
//  ContentView.swift
//  multiSelection
//
//  Created by Krzysztof Czura on 22/12/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var words: [Word] = [Word(id: "a", text: "aa"), Word(id: "b", text: "bb"), Word(id: "c", text: "cc"), Word(id: "d", text: "dd"), Word(id: "e", text: "ee"), Word(id: "f", text: "ff"), Word(id: "g", text: "gg"), Word(id: "h", text: "hh")]
    
    @State private var isBeingEdited = false
    @State private var isSelectedToDelete = false
    @State private var willBeDeleted = false
    @State private var willBeMoved = false
    @State private var selectedItems = Set<String>()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(words, id: \.id) { word in
                    HStack {
                        if isBeingEdited {
                            if selectedItems.contains(word.id) {
                                ZStack {
                                    Circle()
                                        .frame(width: 20, height: 20)
                                        .foregroundStyle(.white)
                                    if isSelectedToDelete {
                                        Image(systemName: "minus.circle.fill")
                                            .foregroundStyle(.red)
                                            .font(.system(size: 20))
                                    } else {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundStyle(.blue)
                                            .font(.system(size: 20))
                                    }
                                }
                            } else {
                                Image(systemName: "circle")
                                    .foregroundStyle(.gray)
                                    .opacity(0.5)
                                    .font(.system(size: 20))
                            }
                        }
                        Text(word.text)
                        Spacer()
                    }
                    .listRowBackground(selectedItems.contains(word.id) ? Color.gray.opacity(0.3) : Color("rowColor"))
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if isBeingEdited {
                            toggleSelection(word: word)
                        }
                    }
                }
            }
            .toolbar {
                if !isBeingEdited {
                    Button {
                        isSelectedToDelete = true
                        willBeDeleted = true
                        isBeingEdited = true
                    } label: {
                        Text("Delete").foregroundStyle(.blue)
                    }
                }
                
                if !isBeingEdited {
                    Button {
                        willBeMoved = true
                        isBeingEdited = true
                    } label: {
                        Text("Move").foregroundStyle(.blue)
                    }
                }
                
                if isBeingEdited {
                    Button {
                        willBeDeleted = false
                        willBeMoved = false
                        isBeingEdited = false
                        selectedItems = []
                    } label: {
                        Text("Cancel")
                    }
                }
                
                if willBeDeleted {
                    Button {
                        if !selectedItems.isEmpty {
                            // insert deleting function here
                        }
                        isSelectedToDelete = false
                        isBeingEdited = false
                        printSelectedWords()
                        selectedItems = []
                        willBeDeleted = false
                    } label: {
                        Text("Delete")
                            .foregroundStyle(Color.red)
                    }
                }
                
                if willBeMoved {
                    Button {
                        if !selectedItems.isEmpty {
                            // insert moving function here
                        }
                        isBeingEdited = false
                        printSelectedWords()
                        selectedItems = []
                        willBeMoved = false
                    } label: {
                        Text("Move")
                    }
                }
            }
            .animation(.spring, value: isBeingEdited)
            .navigationBarTitle(Text("Selected \(selectedItems.count) rows"))
        }
    }
    
    private func printSelectedWords() {
        let selectedWordIDs = Array(selectedItems)
        if !selectedWordIDs.isEmpty {
            print("Items selected: \(selectedWordIDs)")
        }
            
    }
    
    private func toggleSelection(word: Word) {
        if selectedItems.contains(word.id) {
            selectedItems.remove(word.id)
        } else {
            selectedItems.insert(word.id)
        }
    }
}

#Preview {
    ContentView()
}
