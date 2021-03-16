import TSCUtility
import TSCBasic
import Foundation
import Darwin

class Main: NSObject, CovidRequestDelegate {
    
    private let request: CovidRequest
    private let animation: PercentProgressAnimation!
    
    override init() {
        self.request = CovidRequest()
        self.animation = PercentProgressAnimation(stream: stdoutStream, header: "Downloading Greece Covid Data")
        super .init()
        self.request.delegate = self
        request.getData()
        animation.complete(success: true)
    }
    
    func covidRequestData(request: CovidRequest, data: Data) {
        do {
            let country: Country = try JSONDecoder().decode(Country.self, from: data)
            var everyTwoWeeks: [Stat] = []
            
            for stat in country.greece.stats {
                if stat.date.isLastDate || stat.date.isTwoWeeksIn {
                    everyTwoWeeks.append(stat)
                }
            }
            
            country.greece.stats = everyTwoWeeks
            let url = URL(fileURLWithPath: "./statistics/greece.json")
                        let data: Data = try JSONEncoder().encode(country)
                        try data.write(to: url)
            exit(EXIT_SUCCESS)
        } catch {
            print("Error converting data into objects")
        }
    }
    
    func covidRequestError(request: CovidRequest, error: Error) {
        print("Error getting covid data: \(error)")
    }
    
    func covidRequestProgress(request: CovidRequest, progress: Double) {
        animation.update(step: Int(progress) * 100, total: 100, text: "")
    }
}

let _ = Main()
