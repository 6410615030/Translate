//
//  ContentView.swift
//  Translate
//
//  Created by Babypowder on 11/3/2567 BE.
//

import SwiftUI

struct ContentView: View {
    @State private var inputLanguage = "English"
    @State private var outputLanguage = "Thai"
    @State private var inputText = ""
    @State private var translatedText = "Translated text will appear here"
    @State private var showCopiedPopup = false
    
    
    let languages = ["English", "Thai", "Spanish", "French", "German"]
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Picker("Input Language", selection: $inputLanguage) {
                        ForEach(languages, id: \.self) { language in
                            Text(language).tag(language)
                        }
                    }
                    
                    .pickerStyle(MenuPickerStyle())
                    
                    Button(action: swapLanguages) {
                        Image(systemName: "arrow.left.arrow.right")
                    }
                    
                    
                    Picker("Output Language", selection: $outputLanguage) {
                        ForEach(languages, id: \.self) { language in
                            Text(language).tag(language)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                .padding()
                
                TextField("Enter text", text: $inputText)
                                .padding()
                                .border(Color.gray, width: 1)
                                .padding()
                                .frame(width: 335)
                
                Button("Translate") {
                    let sourceLangCode = languageCode(for: inputLanguage)
                    let targetLangCode = languageCode(for: outputLanguage)

                    translateText(text: inputText, sourceLang: sourceLangCode, targetLang: targetLangCode) { translated in
                        DispatchQueue.main.async {
                            translatedText = translated
                        }
                    }
                }
                .padding()
                
                VStack {
                    
                    Text(translatedText)
                        .padding()
                        
                            .frame(width: 300, height: 200)

                    Button(action: {
                                    UIPasteboard.general.string = translatedText
                                    showCopiedPopup = true
                        
                                    // Hide the "Copied" popup after 1 seconds
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        showCopiedPopup = false
                                    }
                                }) {
                                    HStack {
                                        Image(systemName: "doc.on.doc")
                                        if showCopiedPopup {
                                            Text("Copied")
                                                .font(.subheadline)
                                                .transition(.scale)
                                                
                                        }
                                    }
                                    .foregroundColor(.gray)
                                }
                                .padding()

                                
                }.border(Color.gray, width: 1)
                
                    
 
                Spacer()
            }
            .navigationTitle("Translate")
            
        }
    }
    
    func swapLanguages() {
        (inputLanguage, outputLanguage) = (outputLanguage, inputLanguage)
    }

    

}

#Preview {
    ContentView()
}
