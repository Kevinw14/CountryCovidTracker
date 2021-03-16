//
//  File.swift
//  
//
//  Created by Kevin Wood on 3/15/21.
//

import Foundation
import Alamofire

protocol CovidRequestDelegate: class {
    func covidRequestData(request: CovidRequest, data: Data)
    func covidRequestError(request: CovidRequest, error: Error)
    func covidRequestProgress(request: CovidRequest, progress: Double)
}
class CovidRequest {
    
    weak var delegate: CovidRequestDelegate?
    private let url: URL
    init() {
        let url: URL = URL(string: "https://covid.ourworldindata.org/data/owid-covid-data.json")!
        self.url = url
    }
    
    func getData() {
        let request = AF.request(url)
        request.responseData { (response) in
            switch response.result {
            case .success( let data ):
                self.delegate?.covidRequestData(request: self, data: data)
            case .failure( let error ):
                self.delegate?.covidRequestError(request: self, error: error)
            }
        }
        
        request.downloadProgress { (progress) in
            self.delegate?.covidRequestProgress(request: self, progress: progress.fractionCompleted)
        }
        
        RunLoop.current.run()
    }
}
