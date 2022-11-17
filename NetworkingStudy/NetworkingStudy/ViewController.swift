//
//  ViewController.swift
//  NetworkingStudy
//
//  Created by 김하늘 on 2022/11/17.
//

import UIKit

final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
    


}

