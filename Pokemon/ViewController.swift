//
//  ViewController.swift
//  Pokemon
//
//  Created by Kishor Mainali on 10/5/20.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {

    var mapView:GMSMapView!
    let locationManager = CLLocationManager()
    var listPokemon = [Pokemons]()
    var playerPower = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        loadPokemons()
        let camera = GMSCameraPosition.camera(withLatitude: 27, longitude: 85, zoom: 9.0)
        mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.view.addSubview(mapView)
        self.mapView.delegate = self
        
        // Creates a marker in the center of the map.
       
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
       
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        self.listPokemon.append(Pokemons(latitude: coordinate.latitude, longitude: coordinate.longitude, image: "squirtle", name: "Squirtle", description: "Squirtle", power: 33, isCached: false))
    addPokemons()
        }
    
    var oldLocation = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        oldLocation = manager.location!.coordinate
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: oldLocation.latitude, longitude: oldLocation.longitude)
        marker.title = "MY Location"
        marker.snippet = "Nepal"
        marker.icon = UIImage(named: "mario")
        marker.map = self.mapView
    
        addPokemons()
    
        let camera = GMSCameraPosition.camera(withLatitude: oldLocation.latitude, longitude: oldLocation.longitude, zoom: 9.0)
        self.mapView.camera = camera
        
    
    }

    func addPokemons() {
        var index = 0
        for pokemon in self.listPokemon{
            if pokemon.isCached == false {
                let markerPokemon = GMSMarker()
                markerPokemon.position = CLLocationCoordinate2D(latitude: pokemon.latitude, longitude: pokemon.longitude)
                markerPokemon.title = pokemon.name
                markerPokemon.snippet = "\(pokemon.description) \(pokemon.power)"
                markerPokemon.icon = UIImage(named: pokemon.image)
                markerPokemon.map = self.mapView
                
                if (Double(oldLocation.latitude).roundTo(places: 4) == Double(pokemon.latitude).roundTo(places: 4)) && (Double(oldLocation.longitude).roundTo(places: 4) == Double(pokemon.longitude).roundTo(places: 4)){
                    
                    listPokemon[index].isCached = true
                    showAlert(power: pokemon.power)
                    
                }
            }
            index = index + 1
            
        }
        
    }
    
    func loadPokemons() {
        self.listPokemon.append(Pokemons(latitude: 27.7172, longitude: 85.3240, image: "squirtle", name: "Squirtle", description: "Squirtle", power: 33, isCached: false))
        self.listPokemon.append(Pokemons(latitude: 27.4368, longitude: 85.0026, image: "bulbasaur", name: "Bulbasaur", description: "Bulbasaur", power: 33, isCached: false))
        self.listPokemon.append(Pokemons(latitude: 27.6253, longitude:85.5561, image: "charmander", name: "Charmander", description: "Charmander", power: 33, isCached: false))
    }
    
    func  showAlert(power:Double)  {
       playerPower   = playerPower + power
        let alert = UIAlertController(title: "Cache new Pokemon", message: "Your new power is \(playerPower)", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

   

}
extension Double{
    func roundTo(places:Int) -> Double {
        let diviser = pow(10.0, Double(places))
        return (self * diviser).rounded() / diviser
    }
}

