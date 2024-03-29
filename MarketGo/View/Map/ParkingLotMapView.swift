//
//  NMapView.swift
//  MarketGo
//
//  Created by ram on 2023/03/31.
//

import SwiftUI
import NMapsMap

// TODO: 지도에서 마커를 클릭하면 셀이 셀렉트 된 표시가 났으면 좋겠음
struct ParkingLotMapView: UIViewRepresentable {

    @ObservedObject var locationManager = LocationManager()
    @Binding var parkingLots: [Document]
    @Binding var selectedParkingLot: Document?
    var cauLocation = CoordinateInfo(lat: 37.505080, lng: 126.9571020)
    public let mapView = NMFNaverMapView()
    func makeUIView(context: Context) -> NMFNaverMapView {
        mapView.showLocationButton = true
        
        DispatchQueue.main.async {
            if let userLocation = locationManager.userLocation {
                let nmg = NMGLatLng(lat: userLocation.lat , lng: userLocation.lng )
                let cameraUpdate = NMFCameraUpdate(scrollTo: nmg)
                let marketMarker = NMFMarker()
                marketMarker.iconImage = NMF_MARKER_IMAGE_BLACK
                marketMarker.iconTintColor = UIColor.red
                marketMarker.position = nmg
                marketMarker.mapView = mapView.mapView
                marketMarker.mapView?.moveCamera(cameraUpdate)
            }
            for parkingLot in parkingLots {
                let marker = NMFMarker()
                marker.position = NMGLatLng(lat: Double(parkingLot.y) ?? 0, lng: Double(parkingLot.x) ?? 0)
                marker.mapView = mapView.mapView
                if let selectedParkingLot = selectedParkingLot, let lat = Double(selectedParkingLot.y), let lng = Double(selectedParkingLot.x) {
                    // 해당 위치로 카메라 이동
                    let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: lat, lng: lng))
                    mapView.mapView.moveCamera(cameraUpdate)
                }
                marker.touchHandler = { [weak mapView] (overlay: NMFOverlay) -> Bool in
                    if let marker = overlay as? NMFMarker {
                        let cameraUpdate = NMFCameraUpdate(scrollTo: marker.position)
                        mapView?.mapView.moveCamera(cameraUpdate)
                        DispatchQueue.main.async {
                            self.selectedParkingLot = parkingLot
                        }
                        
                    }
                    return true
                }
            }
        }
        return mapView
    }
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
        // 선택된 주차장이 있고, 해당 주차장의 위치 정보가 있는 경우
        if let selectedParkingLot = selectedParkingLot, let lat = Double(selectedParkingLot.y), let lng = Double(selectedParkingLot.x) {
            // 해당 위치로 카메라 이동
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: lat, lng: lng))
            mapView.mapView.moveCamera(cameraUpdate)
        }
    }
}
