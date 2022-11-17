//
//  ViewController.swift
//  NetworkingStudy
//
//  Created by 김하늘 on 2022/11/17.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: - Property
    let baseURLString: String = "https://openapi.naver.com"
    let pathString: String = "v1/search/movie.json?"
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
   
        fetchMovieData()
    }
    
    // MARK: - Function
    private func aboutBaseURL() {
        let url = URL(string: baseURLString)
        let relativeURL = URL(string: pathString, relativeTo: url)
        print(relativeURL?.baseURL) // https://openapi.naver.com/v1
    }
    
    private func aboutURLComponents() {
        var urlComponents = URLComponents(string: baseURLString)
        let query = URLQueryItem(name: "query", value: "가")
        urlComponents?.queryItems?.append(query)
    }
    
    private func fetchMovieData() {
        
        // URLSession 생성
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // URL 생성
        let baseURL = URL(string: baseURLString)
        let relativeURL = URL(string: pathString, relativeTo: baseURL)!
        
        // URLComponents 생성 및 쿼리 설정
        var urlComponents = URLComponents(url: relativeURL, resolvingAgainstBaseURL: true)
        let query = URLQueryItem(name: "query", value: "마블")
        urlComponents?.queryItems?.append(query)
        
        // request 생성하기 위해 url로 다시 변경....
        guard let requestURL = urlComponents?.url else { return }
        var request = URLRequest(url: requestURL)
        
        // 헤더 넣어주기
        request.setValue("hfqwT8cgs0_S7F6ob2yc", forHTTPHeaderField: "X-Naver-Client-Id")
        request.setValue("iFRqjxyM3K", forHTTPHeaderField: "X-Naver-Client-Secret")
        request.httpMethod = "GET"
        
        // URLSessionDataTask 생성
        let dataTask = session.dataTask(with: request) { (data, response, error) in

            // 에러 확인
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            // statusCode 확인
            let successRange = 200..<300
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
            if !successRange.contains(statusCode) {
                print("status code :", statusCode)
            }
            
            // decode
            let decoder: JSONDecoder = JSONDecoder()
            guard let resultData = data else { return }
            do {
                let userResponse = try decoder.decode(GeneralResponse.self, from: resultData)
                print("결과는", userResponse.items!.count,"개 있다")
            } catch {
                print(error.localizedDescription)
            }
            
        }
        dataTask.resume()
    }
}

