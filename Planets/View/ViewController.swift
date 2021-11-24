import UIKit

class ViewController: UIViewController {
    private var viewModel = PlanetViewModel()
    @IBOutlet weak var planetsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel.getTitle()
        planetsTableView.register(PlanetTableViewCell.nib, forCellReuseIdentifier: PlanetTableViewCell.identifier)
        planetsTableView.dataSource = self
        viewModel.getPlanetsList()
        viewModel.reloadTable = { [weak self] in
            DispatchQueue.main.async {
                self?.planetsTableView.reloadData()
            }
        }
    }
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlanetTableViewCell.identifier, for: indexPath) as? PlanetTableViewCell else { return UITableViewCell () }
        let planet = viewModel.getPlanet(for: indexPath.row)
        cell.setData(planet: planet)
        return cell
    }
}

