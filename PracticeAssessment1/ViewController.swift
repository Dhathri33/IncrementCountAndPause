//
//  ViewController.swift
//  PracticeAssessment1
//
//  Created by Dhathri Bathini on 9/25/25.
//

import UIKit

class ViewController: UIViewController {

    //MARK: Properties
    
    let tableView: UITableView = UITableView()
    let viewModel: CounterViewModelProtocol
    var timer: Timer?
    
    init(viewModel: CounterViewModelProtocol = CounterViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = CounterViewModel()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startTimer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopTimer()
    }
    
}

//MARK: TableView DataSource Methods

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumberOfCounters()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let counter = viewModel.getCounter(at: indexPath.row)
        cell.textLabel?.text = "\(counter.count)"
        cell.accessoryType = counter.didPause ? .checkmark : .none
        cell.backgroundColor = counter.didPause ? .gray : .white
        return cell
    }
}

//MARK: TableView Delegate Methods

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.togglePause(index: indexPath.row)
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}

//MARK: Helper functions

extension ViewController {
    
    func setupUI() {
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self,
            let visible = self.tableView.indexPathsForVisibleRows else { return }
            let visibleIndices = visible.map { $0.row }
            self.viewModel.increment(index: visibleIndices)
            self.tableView.reloadRows(at: visible, with: .none)
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
