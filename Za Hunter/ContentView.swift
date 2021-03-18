//
//  ContentView.swift
//  Za Hunter
//
//  Created by Student on 3/8/21.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var places = [Place]()
    @StateObject var locationManager = LocationManager()
    @State private var userTrackingMode:MapUserTrackingMode = .follow
    @State private var regan = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 42.15704, longitude: -88.14812), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
   
    
    
    var body: some View {
        Map(coordinateRegion: $regan,
            interactionModes: .all,
            showsUserLocation: true,
            userTrackingMode: $userTrackingMode,
            annotationItems: places)
            {
                place in
                MapAnnotation(coordinate: place.anadation.coordinate)
                {
                    Marker(mapItem: place.mapidem)
                }
            }
            .onAppear(perform:
                    {
                        performsearch(item: "Pizza")
                    })
        
    }
    
    func performsearch(item: String)
    {
        let searchReaquest = MKLocalSearch.Request()
        searchReaquest.naturalLanguageQuery = item
        searchReaquest.region = regan
        let search = MKLocalSearch(request: searchReaquest)
        search.start { (response, Error) in
            if let response = response
            {
                for mapitem in response.mapItems
                {
                    let anidation = MKPointAnnotation()
                    anidation.coordinate = mapitem.placemark.coordinate
                    anidation.title = mapitem.name
                    places.append(Place(anadation: anidation, mapidem: mapitem))
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Place: Identifiable
{
    let id = UUID()
    let anadation: MKPointAnnotation
    let mapidem: MKMapItem
}

struct Marker: View
{
    var mapItem: MKMapItem
    var body: some View
    {
        if let urll = mapItem.url
        {
            Link(destination: urll, label:
                    {
                        Image("pizza")
                    })
        }
    }
}
