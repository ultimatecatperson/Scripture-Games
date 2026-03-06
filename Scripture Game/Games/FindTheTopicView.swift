/*
    Created by Random Meow in March 2026
    You may use any code here as long as you give credit
    Thanks
*/

import SwiftUI

struct FindTheTopic: View {
    @State private var preventRepetitions: Bool = true
    @State private var isSettingsLocked: Bool = false
    
    @State private var score = 0
    @State private var recentScore = 0
    @State private var bestScore = 0
    @State private var startTime: Date?
    @State private var elapsedTime: Double = 0
    @State private var completedLevels: Int = 0
    @State private var isPlaying: Bool = false
    
    @State private var currentTopic: String = ""
    @State private var topicsUsed: [String] = []
    
    func chooseRandomTopic() {
        let randomTopic = topics.randomElement()!
        
        if preventRepetitions && topicsUsed.contains(randomTopic) {
            chooseRandomTopic()
        } else {
            currentTopic = randomTopic
            topicsUsed.append(currentTopic)
        }
    }
    
    var topics: [String] = [
        "Agency", "Atonement of Jesus Christ", "Baptism", "Charity", "Covenants",
        "Faith", "Family History", "Grace", "Holy Ghost", "Jesus Christ",
        "Plan of Salvation", "Prayer", "Priesthood", "Prophets", "Repentance",
        "Restoration", "Revelation", "Service", "Temples", "Tithing",
        "Adversity", "Articles of Faith", "Apostle", "Apostasy", "Armour of God",
        "Baptism for the Dead", "Beattitudes", "Belief", "Benevolence", "Bishop",
        "Book of Mormon", "Celestial Kingdom", "Chastity", "Children of God", "Christmas",
        "Church Administration", "Commitment", "Compassion", "Confirmation", "Consecration",
        "Cornerstone", "Creation", "Death, Physical", "Death, Spiritual", "Degrees of Glory",
        "Dispensation", "Doctrine and Covenants", "Easter", "Education", "Endurance",
        "Endure to the End", "Eternal Life", "Eternal Marriage", "Exaltation", "Fall of Adam and Eve",
        "Family", "Fasting", "First Premortal Spirit Birth", "First Vision", "Forgiveness",
        "Gadianton Robbers", "Gathering of Israel", "General Conference", "Gethsemane", "Gifts of the Spirit",
        "Godhead", "Gospel", "Gratitude", "Happiness", "Healing",
        "Heavenly Father", "Heavenly Mother", "Hell", "High Council", "Holiness",
        "Honesty", "Hope", "Humility", "Immortality", "Individual Worth",
        "Integrity", "Israel", "Joseph Smith", "Joy", "Judgment, The Last",
        "Justice", "Kindness", "Knowledge", "Liahona", "Light of Christ",
        "Living Prophets", "Love", "Marriage", "Melchizedek Priesthood", "Mercy",
        "Millennium", "Ministering", "Miracles", "Missionary Work", "Modesty",
        "Mortality", "Mortal Life", "New and Everlasting Covenant", "Obedience", "Ordinances",
        "Original Sin", "Parables", "Paradise", "Patience", "Patriarchal Blessings",
        "Peace", "Pearl of Great Price", "Perseverance", "Pioneer", "Postmortal Spirit World",
        "Pre-earth Life", "Preparation", "Pride", "Priesthood Keys", "Priesthood Quorums",
        "Primary", "Promised Land", "Prophecy", "Quorum of the Twelve Apostles", "Relief Society",
        "Resurrection", "Reverence", "Sabbath Day", "Sacrament", "Sacrifice",
        "Salvation", "Salvation for the Dead", "Scriptures", "Sealing", "Second Coming",
        "Self-Reliance", "Sermon on the Mount", "Signs of the Times", "Sin", "Spirit of Prophecy",
        "Spiritual Rebirth", "Stake", "Standard Works", "Stewardship", "Temple Endowment",
        "Temple Ordinances", "Temple Work", "Ten Commandments", "Telestial Kingdom", "Terrestrial Kingdom",
        "Testimony", "Tree of Life", "Tragedy", "Trust in God", "Truth",
        "Unselfishness", "Virtue", "War in Heaven", "Ward", "Witness",
        "Word of Wisdom", "Work", "Worship", "Zion"
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
                    
                    Text(currentTopic)
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
                            Text("\(completedLevels + 1) / 5")
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
                            score += 200
                            
                            if completedLevels == 5 {
                                isPlaying = false
                                elapsedTime = Date().timeIntervalSince(startTime!)
                                
                                score -= Int(elapsedTime * 4)
                                
                                if score > bestScore {
                                    bestScore = score
                                }
                                recentScore = score
                            } else {
                                chooseRandomTopic()
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
            topicsUsed = []
            
            isPlaying = true
            startTime = Date()
            
            chooseRandomTopic()
        }
    }
        
    var setup: some View {
        HStack {
            VStack {
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
                    
                    Toggle("Prevent Repetitions", isOn: $preventRepetitions)
                        .disabled(isSettingsLocked)
                }
                .padding()
                .background(.secondary.opacity(0.15))
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .cornerRadius(30)
                
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading) {
                        Label("Recent topics", systemImage: "book.closed")
                            .font(.title2.bold())
                        
                        if !topicsUsed.isEmpty {
                            ScrollView {
                                VStack(alignment: .leading, spacing: 8) {
                                    ForEach(topicsUsed, id: \.self) { topic in
                                        Text(topic)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                }
                                .padding(.vertical, 4)
                            }
                            .padding()
                            .background(.background)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                            .cornerRadius(30)
                        } else {
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Label("You need to play at least once to see recent topics", systemImage: "exclamationmark.circle")
                                    
                                    Spacer()
                                }
                                
                                Spacer()
                            }
                            .padding()
                            .background(.background)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                            .cornerRadius(30)
                        }
                    }
                }
                .padding()
                .background(.secondary.opacity(0.15))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .cornerRadius(30)
            }
            
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
                
                if true {
                    NavigationLink(destination: game) {
                        Label("Start", systemImage: "play.fill")
                            .padding()
                            .font(.largeTitle.bold())
                            .frame(maxWidth: .infinity)
                            .background(Color.accent)
                            .cornerRadius(30)
                            .tint(Color.white)
                    }
                }
            }
        }
        .padding()
    }
}


#Preview {
    FindTheTopic()
}
