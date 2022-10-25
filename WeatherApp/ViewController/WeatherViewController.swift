//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Suleman Ali on 25/10/2022.
//

import UIKit
import Combine
class WeatherViewController: UIViewController {
    @IBOutlet weak var tblWeather:UITableView!
    var viewModel:WeatherViewModel = WeatherViewModel()
    var cancellable:Set<AnyCancellable> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    func setupUI(){
        tblWeather.register(UINib(nibName: "HistoryTVC", bundle: nil), forCellReuseIdentifier: "HistoryTVC")
        tblWeather.delegate = self
        tblWeather.dataSource = self
        viewModel.$isReloadNeed.receive(on: RunLoop.main).sink{[weak self] weatherItems in
            guard let self = self else {return}
            self.tblWeather.reloadData()
        }.store(in: &cancellable)
        viewModel.$errorMessage.receive(on: RunLoop.main).sink{[weak self] msg in
            guard let self = self else {return}
            if let message  = msg{
                DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                    self.showAlertAction(title: "Error", message: message)
                })
                
            }
        }.store(in: &cancellable)
        viewModel.$isShowProgress.receive(on: RunLoop.main).sink{[weak self] isShow in
            guard let self = self else {return}
            
            if isShow {
                self.showProgress()
            }
            else {
                self.hideProgress()
            }
        }.store(in: &cancellable)
            //this can be Modified using await and Dispatch Group  but for Office busy routine  i done here
        viewModel.getAllWeathers()
        
    }
    func hideProgress(){
        dismiss(animated: false, completion: nil)
    }
    func showProgress(){
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    func showAlertAction(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        self.present(alert, animated: true, completion: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                alert.dismiss(animated: true)
            })
        })
    }
}

extension WeatherViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.weatherArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTVC", for: indexPath) as! HistoryTVC
        cell.weakItem = viewModel.weatherArr[indexPath.row]
        return cell
    }
}
