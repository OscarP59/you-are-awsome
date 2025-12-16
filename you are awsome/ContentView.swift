//
//  ContentView.swift
//  You are awsome
//
//  Created by PERLA, OSCAR on 11/4/25.
//

import SwiftUI
import AVFAudio

struct ContentView: View {
    @State private var message = ""
    @State private var imageName = " "
    @State private var lastMessageNumber = -1
    @State private var audioPlayer : AVAudioPlayer!
    @State private var lastSoundNumber = -1
    @State private var lastImageNumber = -1
    @State private var soundIsOn = true
    let numberOfSound = 6
    let numberOfImages = 10 // images labeled image0 - image9
    var body: some View {
        VStack {
            Text(message)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundStyle(.red)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.5)
                .frame(height: 150)
                .animation(.easeInOut(duration: 0.15), value: message)
            
            Image(imageName)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .shadow(radius: 30)
                .animation(.default, value: imageName)
            
            
            
            Spacer()
            
            
            HStack {
                Text("Sound On")
                Toggle("", isOn: $soundIsOn)
                    .labelsHidden()
                    .onChange(of: soundIsOn) { oldValue, newValue in
                        if audioPlayer != nil && audioPlayer.isPlaying{
                            audioPlayer.stop()
                        }
                    }
                
                Spacer()
                
                
                Button("show message") {
                    let messages = ["you are awesome","you are great","you are fantastic",
                                    "fabulous? thats you", "you make me smile", "when the Genius bar needs help,they call you"]
                    
                    
                    lastMessageNumber = nonRepatingRandom(lastNumber: lastMessageNumber, upperBound: messages.count-1)
                    message = messages[lastMessageNumber]
                    
                    lastImageNumber = nonRepatingRandom(lastNumber: lastImageNumber, upperBound: numberOfImages)
                    imageName = "image\(lastImageNumber)"
                    
                    
                    lastSoundNumber = nonRepatingRandom(lastNumber: lastSoundNumber, upperBound: numberOfSound-1)
                    if soundIsOn {
                        playsound(soundName: "sound\(lastSoundNumber)")
                    }
                    
                }
                .buttonStyle(.borderedProminent)
                .font(.largeTitle)
                
                .padding()
            }
        }
    }

    func nonRepatingRandom(lastNumber: Int, upperBound: Int) -> Int {
        var newNumber: Int
        repeat{
            newNumber = Int.random(in: 0...upperBound)
        }while newNumber == lastMessageNumber
        return newNumber
    }
    func playsound(soundName: String) {
        if audioPlayer != nil && audioPlayer.isPlaying{
            audioPlayer.stop()
        }
        guard let soundFile = NSDataAsset(name: soundName) else {
            print("😡 Could not read file name \(soundName)")
            return
        }
        do{
            audioPlayer = try AVAudioPlayer(data: soundFile.data)
            audioPlayer.play()
        }catch{
            print("😡 ERRO: \(error.localizedDescription) creating audioPlayer")
        }
    }
    
    
}
        #Preview {
            ContentView()
    }

