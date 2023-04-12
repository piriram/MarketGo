//
//  ParkingLotViewModel.swift
//  MarketGo
//
//  Created by ram on 2023/04/12.
//

import Foundation
import SwiftUI
import Alamofire


class ParkingLotViewModel{
   
    //카테고리로 주차장 찾기(카카오맵)
    func searchParkingLot(location:CoordinateInfo,queryKeyword: String) -> [Document]{
        
        let radius: Int =  1000 //중심 좌표로부터의 반경거리,미터 단위
        let page: Int = 1//결과 페이지 번호(1~45),기본값 1
        let size: Int = 5//한 페이지에 보여질 문서의 개수(1~15),기본값 15
        let sort: String = "distance"//결과 정렬 순서(distance,accuracy),기본값:accuracy
        
        let category = GroupCode["주차장"]!
        //x:lng(경도),y:lat(위도)
        //        let url="https://dapi.kakao.com/v2/local/search/keyword"
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded;charset=utf-8",
            "Authorization": "KakaoAK 1712da9b3de78f2c91296dfe29222efa",
            
        ]
        var parkingLots=[Document]()
        
        //        let parameters : [String: Any] = [
        //            "format":".json",
        //            "query": queryKeyword,
        //            "page": 1,
        //            "size": 15,
        //            "x":location.lng,
        //            "y":location.lat,
        //            "category_group_code":category,
        //            "sort" : sort,
        //
        //        ]
        AF.request("https://dapi.kakao.com/v2/local/search/keyword.json?page=\(page)&size=\(size)&sort=\(sort)&query=%EC%A3%BC%EC%B0%A8%EC%9E%A5&category_group_code=\(category)&x=\(location.lng)&y=\(location.lat)&radius=\(radius)",
                   method: .get,
                   encoding: URLEncoding.default,
                   headers: headers)
        .validate(statusCode: 200..<300)
        .responseJSON { response in
            switch response.result {
                case .success(let res):
                    if let data = response.data {
                        do {
                            let decoder = JSONDecoder()
                            let result = try decoder.decode(ParkingLotJSONData.self, from: data)
                            // result를 사용하여 검색 결과를 처리합니다.
                            //print(result)
                            
                            for item in result.documents{
                                let parkingLot = Document(distance: item.distance, id: item.id, phone: item.phone, placeName: item.placeName, placeURL: item.placeURL, roadAddressName: item.roadAddressName, x: item.x, y: item.y)
                                parkingLots.append(parkingLot)
                            }
                            // distance가 가까운 순으로 정렬합니다.
    //                        self.parkingLots = parkingLots.sorted { $0.distance < $1.distance }
                            
                            print(parkingLots[0])
                            
                        } catch let error {
                            print(error.localizedDescription)
                        }
                    }
                case .failure(let error):
                    print("Request failed with error: \(error)")
            }
        }
        return parkingLots
        
        
        
    }


}
