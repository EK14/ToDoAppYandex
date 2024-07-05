//
//  CalendarViewController.swift
//  ToDoApp
//
//  Created by Elina Karapetian on 01.07.2024.
//

import UIKit
import Collections

class CalendarViewController: UIViewController {
    
    private var calendarDaycollectionView: UICollectionView! = nil
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = C.backPrimary.color
        return tableView
    }()
    private let fileCache = FileCache.shared
    private var days = [String]()
    private var items = [ToDoItem]()
    private var selectedDay = 0
    private var sectionData = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = C.backPrimary.color
        fileCache.saveAction = { [weak self] in
            guard let self else { return }
            setupCollectionViewData()
            setupTableViewData()
        }
        setupCollectionViews()
        setupTableView()
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
        calendarDaycollectionView.register(CalendarDayCollectionViewCell.self, forCellWithReuseIdentifier: "calendarcell")
        calendarDaycollectionView.register(OtherDateCollectionViewCell.self, forCellWithReuseIdentifier: "othercell")
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
        
        let sortedItems = items.sorted { $0.deadline ?? Date.distantFuture < $1.deadline ?? Date.distantFuture }
        
        for item in sortedItems {
            guard let date = item.deadline else { continue }
            let dateString = DateFormatterManager.shared.dateFormatter().string(from: date)
            guard !days.contains(dateString) else { continue }
            days.append(dateString)
        }
        
        calendarDaycollectionView.reloadData()
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tablecell")
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: calendarDaycollectionView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        setupTableViewData()
    }
    
    private func setupTableViewData() {
        let sortedItems = items.sorted { $0.deadline ?? Date.distantFuture < $1.deadline ?? Date.distantFuture }

        var dateDictionary = OrderedDictionary<String, [String]>()

        for item in sortedItems {
            if let deadline = item.deadline {
                let dateString = DateFormatterManager.shared.dateFormatter().string(from: deadline)
                if var itemsForDate = dateDictionary[dateString] {
                    itemsForDate.append(item.text)
                    dateDictionary[dateString] = itemsForDate
                } else {
                    dateDictionary[dateString] = [item.text]
                }
            } else {
                if var itemsForDate = dateDictionary["Другое"] {
                    itemsForDate.append(item.text)
                    dateDictionary["Другое"] = itemsForDate
                } else {
                    dateDictionary["Другое"] = [item.text]
                }
            }
        }

        sectionData = Array(dateDictionary.values)

        tableView.reloadData()
    }
}

extension CalendarViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        days.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == days.count {
            guard let cell = calendarDaycollectionView.dequeueReusableCell(withReuseIdentifier: "othercell", for: indexPath) as? OtherDateCollectionViewCell
            else { return UICollectionViewCell() }
            cell.setCell()
            if (indexPath.row == selectedDay){
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
        } else {
            guard let cell = calendarDaycollectionView.dequeueReusableCell(withReuseIdentifier: "calendarcell", for: indexPath) as? CalendarDayCollectionViewCell
            else { return UICollectionViewCell() }
            cell.setCell(
                day: "\(DateFormatterManager.shared.getDay(dateString: days[indexPath.row])!)",
                month: DateFormatterManager.shared.getMonth(dateString: days[indexPath.row])!
            )
            if (indexPath.row == selectedDay){
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
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width - 60) / 5, height: (UIScreen.main.bounds.width - 60) / 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        cell.backgroundColor = C.calendarBackground.color
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor = C.calendarBorder.color.cgColor
        selectedDay = indexPath.row
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
        if section == sectionData.count - 1{
            return "Другое"
        } else {
            return days[section]
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tablecell", for: indexPath) as? UITableViewCell else { return UITableViewCell() }
        cell.textLabel?.text = sectionData[indexPath.section][indexPath.row]
        cell.selectionStyle = .none
        cell.backgroundColor = C.white.color
        return cell
    }
}
