//
//  PokemonListViewController.swift
//  WellPokemonAssesment
//
//  Created by Derrick Wilde on 6/4/24.
//

import Foundation
import UIKit
import Combine

class PokemonListUIView: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIBarPositioningDelegate {
    
    @IBOutlet weak var switchViewTypeButton: UIButton!
    @IBOutlet weak var pkmnTableView: UITableView!
    
    var pokemonListVM: PokemonListViewModel
    var detailView = PokemonDetailViewUIKit()
    var showInSwiftUI: () -> () = { }
    
    init(vm: PokemonListViewModel) {
        self.pokemonListVM = vm
        super.init(nibName: nil, bundle: nil)
        navigationController?.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pkmnTableView.dataSource = self
        pkmnTableView.delegate = self
        self.modalPresentationStyle = .fullScreen
        self.pkmnTableView.register(UINib(nibName: "PokemonTableViewCell", bundle: nil), forCellReuseIdentifier: "PokemonTableViewCell")

        Task {
            await pokemonListVM.loadPokemonData()
            pkmnTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pkmnTableView.dequeueReusableCell(withIdentifier: "PokemonTableViewCell", for: indexPath) as! PokemonTableViewCell
        let pkmn = pokemonListVM.pokemonList[indexPath.row]
        cell.pokemonImage.loadFrom(url: pkmn.imageUrl)
        cell.pokemonDescription.text = pkmn.description
        cell.pokemonName.text = pkmn.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        detailView = PokemonDetailViewUIKit(nibName: "PokemonDetailViewUIKit", bundle: nil)
        let associatedRow = self.pkmnTableView.cellForRow(at: indexPath) as? PokemonTableViewCell
        detailView.loadView()
        let pokemon = pokemonListVM.pokemonList[indexPath.row]
        detailView.pokemonDescription.text = pokemon.description
        detailView.pokemonImageView.image = associatedRow?.pokemonImage.image
        detailView.navigationController?.title = pokemon.name
        self.navigationController?.pushViewController(detailView, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonListVM.pokemonList.count
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return.topAttached
    }
    @IBAction func switchViewButtonDidTouchUpInside(_ sender: Any) {
        self.showInSwiftUI()
    }
}
