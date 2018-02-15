//
//  ViewController.swift
//  RxCityApp
//
//  Created by Marius Ilie on 15/02/2018.
//  Copyright © 2018 Marius Ilie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CountriesAPI.Name("Romania").requestData()
            .map({ return try Country.fromData($0)})
            .subscribe(onNext: { countries in
                for country in countries {
                    print(country.name)
                }
            }, onError: { error in
                print(error)
            })
    }
}

