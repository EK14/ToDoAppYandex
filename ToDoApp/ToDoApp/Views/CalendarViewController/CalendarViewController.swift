//
//  CalendarViewController.swift
//  ToDoApp
//
//  Created by Elina Karapetian on 01.07.2024.
//

import UIKit

class CalendarViewController: UIViewController {
    
    private var calendarView = CalendarView(frame: .zero)
    private var calendarDaycollectionView: UICollectionView! = nil
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = C.backPrimary.color
        return tableView
    }()
    private let fileCache = FileCache.shared
    private var days = [Date]()
    private var items = [ToDoItem]()

    private let shortDayOfWeek = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"]
    private var select = 0
    private var sectionData = [["Купить сыр", "Сделать пиццу", "Задание"],
                               ["Купить сыр", "Сделать пиццу"],
                               ["Купить сыр", "Сделать пиццу"],
                               ["Купить сыр", "Сделать пиццу"]]
    private var titles = ["30 июня", "10 июля", "12 июля", "25 июля"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fileCache.saveAction = { [weak self] in
            guard let self else { return }
            setupCollectionViewData()
            self.tableView.reloadData()
        }
        setupCollectionViews()
        setupTableView()
    }
    
    override func loadView() {
        view = calendarView
    }

    private func setupCollectionViews(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10

        calendarDaycollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        calendarDaycollectionView.dataSource = self
        calendarDaycollectionView.delegate = self
        calendarDaycollectionView.showsHorizontalScrollIndicator = false
        calendarDaycollectionView.translatesAutoresizingMaskIntoConstraints = false
        calendarDaycollectionView.register(CalendarDayCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        calendarDaycollectionView.allowsMultipleSelection = false
        calendarDaycollectionView.backgroundColor = C.backPrimary.color

        let innerView = UIView()
        innerView.translatesAutoresizingMaskIntoConstraints = false
        calendarDaycollectionView.backgroundColor = C.backPrimary.color
        calendarDaycollectionView.layer.borderWidth = 0.5
        calendarDaycollectionView.layer.borderColor = C.calendarBorder.color.cgColor

        view.addSubview(calendarDaycollectionView)
        calendarDaycollectionView.addSubview(innerView)

        NSLayoutConstraint.activate([
            calendarDaycollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            calendarDaycollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calendarDaycollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            calendarDaycollectionView.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 60) / 5 + 20),

            innerView.topAnchor.constraint(equalTo: calendarDaycollectionView.topAnchor),
            innerView.leadingAnchor.constraint(equalTo: calendarDaycollectionView.leadingAnchor, constant: 10),
            innerView.trailingAnchor.constraint(equalTo: calendarDaycollectionView.trailingAnchor, constant: -10),
            innerView.bottomAnchor.constraint(equalTo: calendarDaycollectionView.bottomAnchor),
        ])

        calendarDaycollectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        setupCollectionViewData()
    }
    
    private func setupCollectionViewData() {
        fileCache.upload()
        items = fileCache.todoItems
        for item in items {
            guard let date = item.deadline, !days.contains(date) else { continue }
            days.append(date)
        }
        days = days.sorted()
        calendarDaycollectionView.reloadData()
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: calendarDaycollectionView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension CalendarViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = calendarDaycollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CalendarDayCollectionViewCell else { return UICollectionViewCell() }
        cell.setCell(
            day: DateFormatterManager.shared.getDay().string(from: days[indexPath.row]),
            month: DateFormatterManager.shared.getMonth().string(from: days[indexPath.row])
        )
        if (indexPath.row == select){
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition.top)
            cell.backgroundColor = C.calendarBackground.color
            cell.layer.borderWidth = 2.0
            cell.layer.borderColor = C.calendarBorder.color.cgColor
        }else{
            cell.backgroundColor = C.backPrimary.color
            cell.layer.borderColor = C.calendarBorder.color.cgColor
            cell.layer.borderWidth = 0.0
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width - 60) / 5, height: (UIScreen.main.bounds.width - 60) / 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        cell.backgroundColor = C.calendarBackground.color
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor = C.calendarBorder.color.cgColor
        select = indexPath.row
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath as IndexPath) else { return }
        cell.backgroundColor = .clear
        cell.layer.borderColor = UIColor.clear.cgColor
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension CalendarViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionData.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sectionData[section].count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        titles[section]
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = sectionData[indexPath.section][indexPath.row]
        cell.selectionStyle = .none
        cell.backgroundColor = C.white.color
        return cell
    }
}
