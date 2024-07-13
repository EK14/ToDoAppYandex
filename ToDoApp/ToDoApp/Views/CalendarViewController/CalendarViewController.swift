//
//  CalendarViewController.swift
//  ToDoApp
//
//  Created by Elina Karapetian on 01.07.2024.
//

import SwiftUI
import Collections
import CocoaLumberjackSwift
import FileCache

class CalendarViewController: UIViewController {
    private var calendarDaycollectionView: UICollectionView! = nil

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = C.backPrimary.color
        return tableView
    }()

    var viewWillDissapear: (() -> Void)?

    @ObservedObject var viewModel = CalendarViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        DDLogInfo("CalendarViewController viewDidLoad")
        view.backgroundColor = C.backPrimary.color
        viewModel.fileCache.saveAction = { [weak self] in
            guard let self else { return }
            setupCollectionViewData()
            setupTableViewData()
            setInitialCalendarDay()
        }
        setupCollectionViews()
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DDLogInfo("CalendarViewController viewWillAppear")
        setInitialCalendarDay()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        DDLogInfo("CalendarViewController viewWillDisappear")
        viewWillDissapear?()
    }

    private func setInitialCalendarDay() {
        guard !viewModel.days.isEmpty else { return }
        let firstCellIndexPath = IndexPath(item: 0, section: 0)
        calendarDaycollectionView.selectItem(at: firstCellIndexPath, animated: false, scrollPosition: .left)
        collectionView(calendarDaycollectionView, didSelectItemAt: firstCellIndexPath)
    }

    private func setupCollectionViews() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10

        calendarDaycollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        calendarDaycollectionView.dataSource = self
        calendarDaycollectionView.delegate = self
        calendarDaycollectionView.showsHorizontalScrollIndicator = false
        calendarDaycollectionView.translatesAutoresizingMaskIntoConstraints = false
        calendarDaycollectionView.register(
            CalendarDayCollectionViewCell.self,
            forCellWithReuseIdentifier: "calendarcell"
        )
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

        NSLayoutConstraint.activate(
            [
                calendarDaycollectionView.topAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.topAnchor,
                    constant: 10
                ),
                calendarDaycollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                calendarDaycollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                calendarDaycollectionView.heightAnchor.constraint(
                    equalToConstant: (UIScreen.main.bounds.width - 60) / 5 + 20
                ),
                innerView.topAnchor.constraint(equalTo: calendarDaycollectionView.topAnchor),
                innerView.leadingAnchor.constraint(equalTo: calendarDaycollectionView.leadingAnchor, constant: 10),
                innerView.trailingAnchor.constraint(equalTo: calendarDaycollectionView.trailingAnchor, constant: -10),
                innerView.bottomAnchor.constraint(equalTo: calendarDaycollectionView.bottomAnchor)
            ]
        )

        calendarDaycollectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        setupCollectionViewData()
    }

    private func setupCollectionViewData() {
        viewModel.fileCache.upload()
        viewModel.items = viewModel.fileCache.todoItems

        DDLogInfo("CalendarViewController setupCollectionViewData")

        let sortedItems = viewModel.items.sorted {
            $0.deadline ?? Date.distantFuture < $1.deadline ?? Date.distantFuture
        }

        viewModel.days = []

        for item in sortedItems {
            guard let date = item.deadline else { continue }
            let dateString = DateFormatterManager.shared.dateFormatter().string(from: date)
            guard !viewModel.days.contains(dateString) else { continue }
            viewModel.days.append(dateString)
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
        let sortedItems = viewModel.items.sorted {
            $0.deadline ?? Date.distantFuture < $1.deadline ?? Date.distantFuture
        }

        var dateDictionary = OrderedDictionary<String, [ToDoItem]>()

        for item in sortedItems {
            if let deadline = item.deadline {
                let dateString = DateFormatterManager.shared.dateFormatter().string(from: deadline)
                if var itemsForDate = dateDictionary[dateString] {
                    itemsForDate.append(item)
                    dateDictionary[dateString] = itemsForDate
                } else {
                    dateDictionary[dateString] = [item]
                }
            } else {
                if var itemsForDate = dateDictionary["Другое"] {
                    itemsForDate.append(item)
                    dateDictionary["Другое"] = itemsForDate
                } else {
                    dateDictionary["Другое"] = [item]
                }
            }
        }

        viewModel.sectionData = Array(dateDictionary.values)

        tableView.reloadData()
        DDLogInfo("CalendarViewController setupTableViewData")
    }
}

extension CalendarViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.sectionData.isEmpty {
            return 0
        } else {
            return viewModel.days.count + 1
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if indexPath.row == viewModel.days.count {
            guard let cell = calendarDaycollectionView.dequeueReusableCell(
                withReuseIdentifier: "othercell",
                for: indexPath
            ) as? OtherDateCollectionViewCell
            else { return UICollectionViewCell() }
            cell.setCell()
            return cell
        } else {
            guard let cell = calendarDaycollectionView.dequeueReusableCell(
                withReuseIdentifier: "calendarcell",
                for: indexPath
            ) as? CalendarDayCollectionViewCell
            else { return UICollectionViewCell() }
            cell.setCell(
                day: "\(DateFormatterManager.shared.getDay(dateString: viewModel.days[indexPath.row])!)",
                month: DateFormatterManager.shared.getMonth(dateString: viewModel.days[indexPath.row])!
            )
            return cell
        }
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width - 60) / 5, height: (UIScreen.main.bounds.width - 60) / 5)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard collectionView.cellForItem(at: indexPath) != nil else { return }
        self.calendarDaycollectionView.selectItem(
            at: IndexPath(
                row: indexPath.row,
                section: 0
            ),
            animated: true,
            scrollPosition: .left
        )
        tableView.scrollToRow(at: IndexPath(row: 0, section: indexPath.row), at: .top, animated: true)
        DDLogInfo("CalendarViewController collectionView didSelectItemAt indexPath: \(indexPath)")
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
        viewModel.sectionData.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.sectionData[section].count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == viewModel.sectionData.count - 1 {
            return "Другое"
        } else {
            return viewModel.days[section]
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tablecell", for: indexPath) as UITableViewCell
        cell.selectionStyle = .none
        cell.backgroundColor = C.white.color
        cell.textLabel?.textColor = C.labelPrimary.color
        cell.textLabel?.attributedText = NSAttributedString(
            string: viewModel.sectionData[indexPath.section][indexPath.row].text
        )
        if viewModel.sectionData[indexPath.section][indexPath.row].isDone {
            let attributedString = NSAttributedString(
                string: cell.textLabel?.text ?? "",
                attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue]
            )
            cell.textLabel?.attributedText = attributedString
            cell.textLabel?.textColor = C.labelTertiary.color
        }

        // Создаем раскрашенный кружок
        let circleView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        circleView.layer.cornerRadius = 10
        circleView.backgroundColor = UIColor(
            hex: viewModel.sectionData[indexPath.section][indexPath.row].categoryColor ?? ""
        )

        // Добавляем кружок в правый край ячейки
        cell.accessoryView = circleView

        DDLogInfo(
            "CalendarViewController tableView cellForRowAt indexPath: \(indexPath), text: \(cell.textLabel?.text ?? "")"
        )
        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView === self.tableView {
            if let topSectionIndex = self.tableView.indexPathsForVisibleRows?.map({ $0.section }).sorted().first,
               let selectedCollectionIndex = self.calendarDaycollectionView.indexPathsForSelectedItems?.first?.row,
               selectedCollectionIndex != topSectionIndex {
                let indexPath = IndexPath(item: topSectionIndex, section: 0)
                self.calendarDaycollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .left)
            }
        }
    }

    func tableView(
        _ tableView: UITableView,
        leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let move = doneButtonToggleContextualAction(isDone: true, indexPath: indexPath)
        move.backgroundColor = C.green.color
        move.image = UIImage(systemName: "checkmark.circle.fill")

        let configuration = UISwipeActionsConfiguration(actions: [move])
        DDLogInfo("CalendarViewController tableView leadingSwipeActionsConfigurationForRowAt indexPath: \(indexPath)")
        return configuration
    }

    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let undo = doneButtonToggleContextualAction(isDone: false, indexPath: indexPath)
        undo.backgroundColor = C.red.color
        undo.image = UIImage(systemName: "arrow.uturn.left.circle.fill")

        let configuration = UISwipeActionsConfiguration(actions: [undo])
        DDLogInfo("CalendarViewController tableView trailingSwipeActionsConfigurationForRowAt indexPath: \(indexPath)")
        return configuration
    }

    private func doneButtonToggleContextualAction(isDone: Bool, indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: nil) { [weak self] (_, _, completionHandler) in
            guard let self else { return }
            viewModel.doneButtonToggle(viewModel.sectionData[indexPath.section][indexPath.row], isDone: isDone)
            DDLogInfo(
                "CalendarViewController doneButtonToggleContextualAction isDone: \(isDone), indexPath: \(indexPath)"
            )
            guard let cell = tableView.cellForRow(at: indexPath) else { completionHandler(false); return }
            // Animation
            UIView.animate(withDuration: 0.1,
                           animations: {
                cell.transform = cell.transform.scaledBy(x: 1.5, y: 1.5)
            }, completion: { (_) in
                UIView.animate(withDuration: 0.3,
                               delay: 0,
                               usingSpringWithDamping: 0.7,
                               initialSpringVelocity: 0.5,
                               options: .curveEaseOut,
                               animations: {
                    cell.transform = CGAffineTransform.identity
                },
                               completion: nil)
            })

            completionHandler(true)
        }
        return action
    }
}
