/*
    Created by Random Meow in March 2026
    You may use any code here as long as you give credit
    Thanks
*/

import SwiftUI

struct PhysicalFlip: View {
    @State private var useOldTestament: Bool = true
    @State private var useNewTestament: Bool = true
    @State private var useBookOfMormon: Bool = true
    @State private var useDoctrineAndCovenants: Bool = true
    @State private var usePearlOfGreatPrice: Bool = true
    @State private var showVolume: Bool = false
    @State private var isSettingsLocked: Bool = false
    
    @State private var score = 0
    @State private var recentScore = 0
    @State private var bestScore = 0
    @State private var startTime: Date?
    @State private var elapsedTime: Double = 0
    @State private var completedLevels: Int = 0
    @State private var isPlaying: Bool = false
    
    @State private var currentLocation: String = ""
        
    @State private var allowedVolumes: [Int] = []
    
    func chooseRandomLocation() {
        let randomVolume = allowedVolumes.randomElement()!
        let randomBook = books[randomVolume].randomElement()!
        let randomBookIndex = books[randomVolume].firstIndex(of: randomBook)!
        let randomChapter = Int.random(in: 1...chapters[randomVolume][randomBookIndex])
        
        currentLocation = "\(randomBook) \(randomChapter)\(showVolume ? "\n\(volumes[randomVolume])" : "")"
    }
    
    var volumes: [String] = [
        "Old Testament",
        "New Testament",
        "Book of Mormon",
        "Doctrine and Covenants",
        "Pearl of Great Price"
    ]

    var books: [[String]] = [
        // Old Testament
        ["Genesis", "Exodus", "Leviticus", "Numbers", "Deuteronomy", "Joshua", "Judges", "Ruth", "1 Samuel", "2 Samuel", "1 Kings", "2 Kings", "1 Chronicles", "2 Chronicles", "Ezra", "Nehemiah", "Esther", "Job", "Psalms", "Proverbs", "Ecclesiastes", "Solomon's Song", "Isaiah", "Jeremiah", "Lamentations", "Ezekiel", "Daniel", "Hosea", "Joel", "Amos", "Obadiah", "Jonah", "Micah", "Nahum", "Habakkuk", "Zephaniah", "Haggai", "Zechariah", "Malachi"],
        // New Testament
        ["Matthew", "Mark", "Luke", "John", "Acts", "Romans", "1 Corinthians", "2 Corinthians", "Galatians", "Ephesians", "Philippians", "Colossians", "1 Thessalonians", "2 Thessalonians", "1 Timothy", "2 Timothy", "Titus", "Philemon", "Hebrews", "James", "1 Peter", "2 Peter", "1 John", "2 John", "3 John", "Jude", "Revelation"],
        // Book of Mormon
        ["1 Nephi", "2 Nephi", "Jacob", "Enos", "Jarom", "Omni", "Words of Mormon", "Mosiah", "Alma", "Helaman", "3 Nephi", "4 Nephi", "Mormon", "Ether", "Moroni"],
        // Doctrine and Covenants
        ["Doctrine and Covenants", "Official Declarations"],
        // Pearl of Great Price
        ["Moses", "Abraham", "Joseph Smith—Matthew", "Joseph Smith—History", "Articles of Faith"]
    ]

    var chapters: [[Int]] = [
        // Old Testament Chapters
        [50, 40, 27, 36, 34, 24, 21, 4, 31, 24, 22, 25, 29, 36, 10, 13, 10, 42, 150, 31, 12, 8, 66, 52, 5, 48, 12, 14, 3, 9, 1, 4, 7, 3, 3, 3, 2, 14, 4],
        // New Testament Chapters
        [28, 16, 24, 21, 28, 16, 16, 13, 6, 6, 4, 4, 5, 3, 6, 4, 3, 1, 13, 5, 5, 3, 5, 1, 1, 1, 22],
        // Book of Mormon Chapters
        [22, 33, 7, 1, 1, 1, 1, 29, 63, 16, 30, 1, 9, 15, 10],
        // Doctrine and Covenants Sections/Declarations
        [138, 2],
        // Pearl of Great Price Chapters
        [8, 5, 1, 1, 1]
    ]
        
    var body: some View {
        NavigationStack {
            setup
        }
    }
    
    var game: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Spacer()
                    
                    Text(currentLocation)
                        .font(.system(size: 45))
                        .fontWeight(.heavy)
                        .fontDesign(.monospaced)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    TimelineView(.animation) { context in
                        let currentElapsed = context.date.timeIntervalSince(startTime ?? Date())
                        
                        VStack {
                            Text("\(isPlaying ? currentElapsed : elapsedTime, specifier: "%.3f")")
                                .font(.system(size: 30))
                                .fontWeight(.semibold)
                                .fontDesign(.monospaced)
                        }
                    }
                    
                    if isPlaying {
                        VStack {
                            Text("\(completedLevels + 1) / 10")
                                .font(.system(size: 30))
                                .fontWeight(.bold)
                                .fontDesign(.default)
                        }
                    } else {
                        VStack {
                            Text("Final score: \(score)")
                                .font(.system(size: 30))
                                .fontWeight(.bold)
                                .fontDesign(.default)
                        }
                    }
                    
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    
                    if isPlaying {
                        Button {
                            completedLevels += 1
                            score += 100
                            
                            if completedLevels == 10 {
                                isPlaying = false
                                elapsedTime = Date().timeIntervalSince(startTime!)
                                
                                score -= Int(elapsedTime / 2)
                                
                                if score > bestScore {
                                    bestScore = score
                                }
                                recentScore = score
                            } else {
                                chooseRandomLocation()
                            }
                        } label: {
                            Image(systemName: "checkmark")
                                .font(.system(size: 60))
                                .fontWeight(.heavy)
                                .tint(.white)
                                .padding()
                                .frame(width: 120, height: 120)
                                .background(.accent)
                                .clipShape(Circle())
                        }
                    }
                }
            }
        }
        .onAppear {
            completedLevels = 0
            score = 0
            allowedVolumes = []
            if useOldTestament {
                allowedVolumes.append(0)
            }
            if useNewTestament {
                allowedVolumes.append(1)
            }
            if useBookOfMormon {
                allowedVolumes.append(2)
            }
            if useDoctrineAndCovenants {
                allowedVolumes.append(3)
            }
            if usePearlOfGreatPrice {
                allowedVolumes.append(4)
            }
            
            isPlaying = true
            startTime = Date()
            
            chooseRandomLocation()
        }
    }
    
    private var setup: some View {
        HStack {
            VStack(alignment: .leading, spacing: 20) {
                Group {
                    if isSettingsLocked {
                        Button {
                            isSettingsLocked = false
                        } label: {
                            Image(systemName: "lock.fill")
                        }
                        .buttonStyle(BorderedProminentButtonStyle())
                    } else {
                        Button {
                            isSettingsLocked = true
                        } label: {
                            Image(systemName: "lock.open.fill")
                        }
                        .buttonStyle(BorderedButtonStyle())
                    }
                }
                
                Toggle("Use Old Testament", isOn: $useOldTestament)
                    .disabled(isSettingsLocked)
                Toggle("Use New Testament", isOn: $useNewTestament)
                    .disabled(isSettingsLocked)
                Toggle("Use Book of Mormon", isOn: $useBookOfMormon)
                    .disabled(isSettingsLocked)
                Toggle("Use Doctrine and Covenants", isOn: $useDoctrineAndCovenants)
                    .disabled(isSettingsLocked)
                Toggle("Use Pearl of Great Price", isOn: $usePearlOfGreatPrice)
                    .disabled(isSettingsLocked)
                
                Spacer()
                
                Toggle("Show Full Location", isOn: $showVolume)
                    .disabled(isSettingsLocked)
            }
            .padding()
            .background(.secondary.opacity(0.15))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .cornerRadius(30)
            
            VStack {
                VStack(alignment: .leading, spacing: 20) {
                    Spacer()
                    
                    HStack {
                        Label("Best Score", systemImage: "trophy")
                            .font(.title.bold())
                        
                        Spacer()
                        
                        Text(String(bestScore))
                            .font(.system(size: 30, design: .monospaced))
                    }
                    
                    HStack {
                        Label("Recent Score", systemImage: "stopwatch")
                            .font(.title.bold())
                        
                        Spacer()
                        
                        Text(String(recentScore))
                            .font(.system(size: 30, design: .monospaced))
                    }
                    
                    Text("Best and Recent scores are deleted when the app is closed.")
                        .multilineTextAlignment(.leading)
                        .font(.caption)
                    
                    Spacer()
                }
                .padding()
                .background(.secondary.opacity(0.15))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .cornerRadius(30)
                
                if useOldTestament || useNewTestament || useBookOfMormon || useDoctrineAndCovenants || usePearlOfGreatPrice {
                    NavigationLink(destination: game) {
                        Label("Start", systemImage: "play.fill")
                            .padding()
                            .font(.largeTitle.bold())
                            .frame(maxWidth: .infinity)
                            .frame(maxHeight: .infinity)
                            .background(Color.accent)
                            .cornerRadius(30)
                            .tint(Color.white)
                    }
                } else {
                    VStack {
                        Spacer()
                        
                        HStack {
                            Spacer()
                            Text("You must select at least one Standard Work to play")
                                .foregroundStyle(.red)
                                .multilineTextAlignment(.center)
                            Spacer()
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .background(.secondary.opacity(0.3))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .cornerRadius(30)
                }
            }
        }
        .padding()
    }
}

#Preview {
    PhysicalFlip()
}
