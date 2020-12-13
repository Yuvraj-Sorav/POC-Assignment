//
//  POCNetworkManager.swift
//  Proofofconcept
//
//  Created by Yuvraj Sorav on 13/12/20.
//

import UIKit
import SVProgressHUD

enum NetworkError: Error {
    case domainError
}

class POCNetworkManager {
    
    static let sharedManager = POCNetworkManager()
    static let imageCache = NSCache<AnyObject, UIImage>()
    
    func makeGetRequest(urlString: String, completion:@escaping (Result<Data,NetworkError>) -> Void){

        guard let url = URL(string: urlString) else {
            completion(.failure(.domainError))
            return
        }
        SVProgressHUD.show()
        URLSession.shared.dataTask(with: url) { data, response, error in
            SVProgressHUD.dismiss()
            guard let urlData = data, error == nil else {
                if let error = error as NSError?, error.domain == NSURLErrorDomain {
                        completion(.failure(.domainError))
                }
                return
            }
            
            let str = String(data: urlData, encoding: .isoLatin1)
            guard let dataUTF8 = str?.data(using: .utf8) else {
                return
            }
            completion(.success(dataUTF8))
        }.resume()
    }
    
    func downloadImage(url: URL, completion: @escaping (_ image: UIImage?, _ error: Error?) -> Void) {
        if let cachedImage = POCNetworkManager.imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage, nil)
        } else {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(nil, error)
                    
                } else if let urlData = data, let image = UIImage(data: urlData) {
                    POCNetworkManager.imageCache.setObject(image, forKey: url.absoluteString as AnyObject)
                    completion(image, nil)
                } else {
                    completion(nil, NetworkError.domainError)
                }
            }.resume()
        }
    }
}
